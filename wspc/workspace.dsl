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
                timetable_front = web_comp "Zobrazení rozvrhu"
                course_provider_front = web_comp "Zobrazení/listování předmětů"
            }

            sis_admin_fe = web "SIS admin frontend" {
                course_manager_front = web_comp "Správa předmětů"
                ticket_manager_front = web_comp "Správa rozvrhových lístků"
            }

            sis_be = container "SIS backend" {
                timetable_provider = component "Poskytovatel rozvrhů"

                course_provider = component "Poskytovatel předmětů"

                simple_ticket_repository = component "Adresář rozvrhových lístků"

                simple_course_repository = component "Adresář předmětů"

                simple_timeslot_repository = component "Adresář místností/časových slotů"
            }

            sis_admin_be = container "SIS admin backend" {

                course_manager = component "Správce předmětů"

                ticket_manager = component "Správce rozvrhových lístků"

                ticket_repository = component "Uložení/Historizace rozvrhových lístků"

                course_repository = component "Uložení/Historizace předmětů"

                timeslot_repo = component "Adresář místností/časových slotů"

                timetable_notifications = component "Správce notifikací o rozvrhu"
            }

            scheduleDB = db "scheduleDB"
            courseDB = db courseDB
            timeslotDB = db timeslotDB

            scheduler_front = container "Rozvrhovadlo" "" "Delphi probably" "app"

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

            simple_ticket_repository -> scheduleDB "Čte data z"
            simple_course_repository -> courseDB "Čte data z"
            simple_timeslot_repository -> timeslotDB "Čte data z"

            # SIS Admin
            teacher -> course_manager_front "Vytváří předmět"
            teacher -> course_manager_front "Upravuje předmět"
            teacher -> course_manager_front "Maže předmět"
            teacher -> ticket_manager_front "Upravuje/maže rozvrhové lístky"

            scheduler -> scheduler_front "Tvoří rozvrh"

            course_manager_front -> course_manager "Odesílá požadavky uživatele"
            scheduler_front -> ticket_manager "Upravuje rozvrh"

            course_manager -> course_repository "Ukládá změny"
            course_manager -> ticket_manager "Maže předmět"

            ticket_manager_front -> ticket_manager "Odesílá požadavky uživatele"
            ticket_manager -> timeslot_repo "Získává dostupné sloty"
            ticket_manager -> ticket_repository "Ukládá změny"
            ticket_manager -> timetable_notifications "Posílá eventy o změně"

            timetable_notifications -> enrollments "Ȟledá, koho se notifikace o změně rozvrhu týká"
            timetable_notifications -> notifications "Posílá notifikaci o změně rozvrhu"

            ticket_repository -> scheduleDB "Čte data z"
            course_repository -> courseDB "Čte data z"
            timeslot_repo -> timeslotDB "Čte data z"

            //            timetable_provider -> course_provider "Čte předměty"

        }

        production = deploymentEnvironment "Produkce" {

            deploymentNode "Prohlížeč admina" {
                containerInstance sis_admin_fe
            }

            deploymentNode "Prohlížeč rozvrháře" {
                containerInstance sis_admin_fe
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