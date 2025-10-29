workspace "NSWI130" {

    model {
        student = person "Student"
        teacher = person "Učitel"
        scheduler = person "Rozvrhář"
        
        notifications = softwareSystem "Notifkační služba"
        enrollments = softwareSystem "Enrollments"
        
        sch = softwareSystem "Schedules" {
            sub_man = container "Správa předmětů"
            sub_man_front = container "Web:Správa předmětů" "" "" web
            sub_man_front -> sub_man "Odesílá požadavky uživatele"
            
            teacher -> sub_man_front "Vytváří předmět"
            teacher -> sub_man_front "Upravuje předmět"
            teacher -> sub_man_front "Maže předmět"
            
            ticket_man = container "Správa rozvrhových lístků"
            ticket_man_front = container "Web:Správa rozvrhových lístků"
            ticket_man_front -> ticket_man "Odesílá požadavky uživatele"
            
            sub_man -> ticket_man "Maže předmět"
            ticket_man -> notifications "Posílá notifikaci o změně předmětu"
        }

        student -> sch "čte";
    }

    views {
        container sch {
            include *
            autolayout lr
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
            }
        }
    }
    
}
