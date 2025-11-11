workspace "NSWI130" {

    m = model {
        archetypes {
            web = container {
                tags "web"
            }
            web_comp = component {
                tags "web"
            }
            db = container {
                tags "db"
            }

            external = softwareSystem {
            }
        }

        student = person "Student"
        teacher = person "Učitel"
        scheduler = person "Rozvrhář"

        notifications = external "Notifkační služba"
        enrollments = external "Enrollments"

        sch = softwareSystem "Rozvrhy" {

            sis_fe = web "SIS frontend" {
                timetable_front = web_comp "Zobrazení rozvrhu" "" "HTML+JS"
                course_provider_front = web_comp "Zobrazení/listování předmětů" "" "HTML+JS"
            }

            sis_admin_fe = web "SIS admin frontend" {
                course_manager_front = web_comp "Správa předmětů" "" "HTML+JS"
                ticket_manager_front = web_comp "Správa rozvrhových lístků" "" "HTML+JS"
            }

            sis_be = container "SIS backend" {
                timetable_provider = component "API kontroler pro čtení rozvrhů"

                course_provider = component "API kontroler pro čtení předmětů"

                simple_ticket_repository = component "Adresář rozvrhových lístků"

                simple_course_repository = component "Adresář předmětů"

                simple_timeslot_repository = component "Adresář místností/časových slotů"
            }

            sis_admin_be = container "SIS admin backend" {

                course_admin_controller = component "API kontroler správy předmětů"

                ticket_admin_controller = component "API kontroler správy rozvrhových lístků"

                timeslot_admin_controller = component "API kontroler pro časové sloty"

                course_manager = component "Správce předmětů"

                ticket_manager = component "Správce rozvrhových lístků"

                ticket_repository = component "Uložení/Historizace rozvrhových lístků"

                course_repository = component "Uložení/Historizace předmětů"

                timeslot_repository = component "Adresář místností/časových slotů"

                timetable_notifications = component "Správce notifikací o rozvrhu"
            }

            scheduleDB = db "scheduleDB"
            courseDB = db courseDB
            timeslotDB = db timeslotDB

            scheduler_front = container "Rozvrhovadlo" "" "HTML+JS"

            # SIS

            student -> course_provider_front "Hledá předměty"
            student -> timetable_front "Kouká na rozvrh"
            teacher -> course_provider_front "Hledá předměty"
            teacher -> timetable_front "Kouká na rozvrh"

            course_provider_front -> course_provider "Hledá / čte předměty"
            timetable_front -> timetable_provider "Čte rozvrhové lístky"

            course_provider -> simple_course_repository "Čte předměty"

            timetable_provider -> simple_ticket_repository "Čte rozvrhové lístky"
            timetable_provider -> simple_timeslot_repository "Čte časoprostor"
            timetable_provider -> simple_course_repository "Načte metadata předmětu"

            simple_ticket_repository -> scheduleDB "Čte data z"
            simple_course_repository -> courseDB "Čte data z"
            simple_timeslot_repository -> timeslotDB "Čte data z"

            # SIS Admin
            teacher -> course_manager_front "Vytváří předmět"
            teacher -> course_manager_front "Upravuje předmět"
            teacher -> course_manager_front "Maže předmět"
            teacher -> ticket_manager_front "Upravuje/maže rozvrhové lístky"

            scheduler -> scheduler_front "Tvoří rozvrh"

            scheduler_front -> course_admin_controller "Čte předměty"
            scheduler_front -> timeslot_admin_controller "Čte časové sloty"

            timeslot_admin_controller -> timeslot_repository "Načítá časové sloty dle API požadavků"

            course_manager_front -> course_admin_controller "Odesílá požadavky uživatele"

            course_admin_controller -> course_manager  "Provádí změnu v předmětech"
            course_manager -> course_repository "Ukládá změny"
            course_manager -> ticket_manager "Maže lístky předmětu"

            scheduler_front -> ticket_admin_controller "Upravuje rozvrh"
            ticket_manager_front -> ticket_admin_controller "Odesílá požadavky uživatele"

            ticket_admin_controller -> ticket_manager "Provádí změny nad rozvrhovými lístky"
            ticket_manager -> timeslot_repository "Získává dostupné sloty"
            ticket_manager -> ticket_repository "Ukládá změny"
            ticket_manager -> timetable_notifications "Posílá eventy o změně"

            timetable_notifications -> enrollments "Ȟledá, koho se notifikace o změně rozvrhu týká"
            timetable_notifications -> notifications "Posílá notifikaci o změně rozvrhu"

            ticket_repository -> scheduleDB "Čte data z"
            course_repository -> courseDB "Čte data z"
            timeslot_repository -> timeslotDB "Čte data z"

        }

        production = deploymentEnvironment "Produkce" {

            deploymentNode "Prohlížeč admina" {
                containerInstance sis_admin_fe
            }

            deploymentNode "Prohlížeč rozvrháře" {
                containerInstance scheduler_front
            }

            deploymentNode "Prohlížeč uživatele" {
                containerInstance sis_fe
            }

            deploymentNode "Hardware" {
                deploymentNode "Container orchestration system" "" "Kubernetes" {
                    deploymentNode "Databases" "" "Docker container" {
                        deploymentNode "Relational DB server" "" "PostgreSQL 18.0.0" {
                            containerInstance scheduleDB
                            containerInstance courseDB
                            containerInstance timeslotDB
                        }
                    }
                    deploymentNode "Admin backend" "" "Docker container" {
                        deploymentNode ".NET 9 runtime" {
                            containerInstance sis_admin_be
                        }
                    }
                    deploymentNode "Backend" "" "Docker container" {
                        deploymentNode ".NET 9 runtime" {
                            containerInstance sis_be
                        }
                    }
                }
            }
        }

        development = deploymentEnvironment "Development prostředí" {
            deploymentNode "Počítač vývojáře" "" "Arch linux" {
                deploymentNode "Prohlížeč vývojáře" {
                    containerInstance sis_admin_fe
                    containerInstance sis_fe
                    containerInstance scheduler_front
                }
                deploymentNode "Databases" "" "Docker container" {
                    deploymentNode "Relational DB server" "" "PostgreSQL 18.0.0" {
                        containerInstance scheduleDB
                        containerInstance courseDB
                        containerInstance timeslotDB
                    }
                }
                deploymentNode "Admin backend" "" "Docker container" {
                    deploymentNode ".NET 9 runtime" {
                        containerInstance sis_admin_be
                    }
                }
                deploymentNode "Backend" "" "Docker container" {
                    deploymentNode ".NET 9 runtime" {
                        containerInstance sis_be
                    }
                }
            }
        }
    }

    views {
        systemcontext sch {
            include *
            autolayout
        }

        container sch {
            include *
            autoLayout
        }

        component sis_be {
            include *
            autoLayout
        }

        component sis_fe {
            include *
            autoLayout
        }

        component sis_admin_be {
            include *
            autoLayout
        }

        component sis_admin_fe {
            include *
            autoLayout
        }

        deployment sch development {
            include *
            autoLayout
        }

        deployment sch production {
            include *
            autoLayout
        }

        //split "Příslušník univerzity si chce zobrazit rozvrh předmětu" into two - search_course & view_course_schedule, otherwise unreadeable
        dynamic sis_be "search_course" {
            description "Uživatel hledá a vybírá předmět"
            autoLayout lr

            student -> course_provider_front "Otevře 'Předměty'"
            course_provider_front -> course_provider "Požádá o seznam"
            course_provider -> simple_course_repository "Načte data"
            simple_course_repository -> courseDB "Čte databázi"
            courseDB -> simple_course_repository "Vrátí data"
            simple_course_repository -> course_provider "Vrátí seznam"
            course_provider -> course_provider_front "Vrátí výsledky"
            course_provider_front -> student "Zobrazí seznam předmětů"
        }

        dynamic sis_be "view_course_schedule" {
            description "Uživatel má vybraný předmět a chce vidět jeho rozvrh"
            autoLayout lr

            student -> timetable_front "Klikne 'Zobrazit rozvrh'"
            timetable_front -> student "Zobrazí rozvrh uživateli"

            timetable_front -> timetable_provider "Požádá o rozvrh (pomocí courseID)"
            timetable_provider -> timetable_front "Vrátí agregovaný rozvrh"

            timetable_provider -> simple_ticket_repository "Načte rozvrhové lístky"
            timetable_provider -> simple_timeslot_repository "Načte časoprostor"
            timetable_provider -> simple_course_repository "Načte metadata předmětu"

            simple_timeslot_repository -> timeslotDB "Čte místnosti/časy"
            timeslotDB -> simple_timeslot_repository "Vrátí data"

            simple_course_repository -> courseDB "Čte podrobnosti"
            courseDB -> simple_course_repository "Vrátí data"

            simple_ticket_repository -> scheduleDB "Čte rozvrh z databáze"
            scheduleDB -> simple_ticket_repository "Vrátí data"
        }

        dynamic sis_admin_be "collisision_detection" {
            description "Rozvrhář se pokouší umístit novou přednášku do času a místnosti, které jsou již obsazené"
            autoLayout lr

            scheduler -> scheduler_front "Zadává údaje o nové rozvrhové akci (učitel, místnost, čas)"
            scheduler_front -> ticket_admin_controller "API požadavek na vytvoření rozvrhového lístku"
            ticket_admin_controller -> ticket_manager ""
            ticket_manager -> timeslot_repository "Ověřuje platnost místnosti a časového slotu"
            timeslot_repository -> timeslotDB "Čte místnosti/časy"
            timeslotDB -> timeslot_repository "Vrátí data"
            timeslot_repository -> ticket_manager "Vrací výsledek validace slotu"
            ticket_manager -> ticket_repository "Vyžádá existující lístky pro daného učitele NEBO místnost v daném čase"
            ticket_repository -> scheduleDB "Dotaz na existující záznamy"
            scheduleDB -> ticket_repository "Vrací nalezené (kolidující) lístky"
            ticket_repository -> ticket_manager "Předává nalezené lístky"
            ticket_admin_controller -> scheduler_front "Vrací varování o kolizi (akce nebyla uložena)"
            scheduler_front -> scheduler "Zobrazí varování o kolizi"
        }

        dynamic sis_admin_be "schedulling" {
            description "Rozvržení předmětu (bez kontroly kolize)"
            autoLayout

            scheduler -> scheduler_front "Rozvrhář rozvrhává předmět"
            scheduler_front -> course_admin_controller "FE si načítá data o předmětech"
            course_admin_controller -> scheduler_front "Vrací informace o předmětech"
            scheduler_front -> timeslot_admin_controller "FE si načítá data o časových slotech"
            timeslot_admin_controller -> scheduler_front "Vrací dostupné časových sloty"
            scheduler_front -> ticket_admin_controller "API požadavek na vytvoření rozvrhových lístků dle zadaných parametrů"
            ticket_admin_controller -> ticket_manager "Předává zpracované API požadavky na rozvrh"
            ticket_manager -> timeslot_repository "Ověřuje existenci slotů"
            timeslot_repository -> timeslotDB "Čte místnosti/časy"
            timeslotDB -> timeslot_repository "Vrátí data"
            timeslot_repository -> ticket_manager "Vrací existující sloty"
            ticket_manager -> ticket_repository "Vytváří rozvrhové lístky"
            ticket_repository -> scheduleDB "Ukládá lístky do databáze"
            scheduleDB -> ticket_repository "Vrací informaci o vytvořených lístcích"
            ticket_repository -> ticket_manager "Předává vytvořené lístky"
            ticket_admin_controller -> scheduler_front "Vrací informaci o úspěšnosti akce"
            scheduler_front -> scheduler "Přijímá výsledek"
        }

        dynamic sis_admin_be "create_course" {
            description "Učitel vytváří nový předmět"
            autoLayout lr

            teacher -> course_manager_front "Otevře 'Vytvořit předmět'"
            course_manager_front -> teacher "Zobrazí formulář"

            teacher -> course_manager_front "Odešle vyplněný formulář"
            course_manager_front -> course_manager "Odesílá data"
            course_manager -> course_repository "Ukládá předmět"
            course_repository -> courseDB "Zapisuje data"

            courseDB -> course_repository "Potvrzuje zápis"
            course_repository -> course_manager "Potvrzuje uložení"
            course_manager -> course_manager_front "Potvrzuje vytvoření"
            course_manager_front -> teacher "Zobrazí potvrzení"
        }
        
        dynamic sis_admin_be "edit_course" {
            description "Učitel upravuje existující předmět"
            autoLayout lr

            teacher -> course_provider_front "Otevře 'Předměty'"
            course_provider_front -> course_provider "Požádá o seznam"
            course_provider -> simple_course_repository "Načte data"
            simple_course_repository -> courseDB "Čte databázi"
            courseDB -> simple_course_repository "Vrátí data"
            simple_course_repository -> course_provider "Vrátí seznam"
            course_provider -> course_provider_front "Vrátí výsledky"
            course_provider_front -> teacher "Zobrazí seznam předmětů"
            
            teacher -> course_manager_front "Otevře úpravu předmětu"
            course_manager_front -> course_manager "Požádá o data"
            course_manager -> course_repository "Načte data"
            course_repository -> courseDB "Čte databázi"

            courseDB -> course_repository "Vrací data"
            course_repository -> course_manager "Vrací data"
            course_manager -> course_manager_front "Vrací data"
            course_manager_front -> teacher "Zobrazí vyplněný formulář"
            
            teacher -> course_manager_front "Odešle vyplněný formulář"
            course_manager_front -> course_manager "Odesílá data"
            course_manager -> course_repository "Ukládá předmět"
            course_repository -> courseDB "Zapisuje data"

            courseDB -> course_repository "Potvrzuje zápis"
            course_repository -> course_manager "Potvrzuje uložení"
            course_manager -> course_manager_front "Potvrzuje vytvoření"
            course_manager_front -> teacher "Zobrazí potvrzení"
        }

        styles {
            element Person {
                shape person
            }
            element db {
                shape cylinder
            }
            element web {
                shape WebBrowser
                stroke #ffc0cb
            }
            element app {
                shape Window
                stroke #ffc0cb
            }
            element Container {
                shape RoundedBox
                background #f1f1f1
            }
            relationship Relationship {
                position 15
            }
        }
    }

}
