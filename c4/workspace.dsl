workspace "School Enrollment System" "This workspace documents the architecture of the Enrollment System which manages student course enrollments, teacher assignments, and administrative oversight." {
    
    model {
        # software systems
        enrollmentSystem = softwareSystem "Enrollment System" "Manages course enrollments, class capacities, prerequisites validation, and enrollment periods for students and teachers." {

            subjectAnalyzer = container "Subject Analyzer" "Filters subjects and provides subject/time slot recommendations." {
                
            }
        }
        scheduleModule = softwareSystem "Schedule Module" "Manages course schedules, classroom assignments, time slots, and academic calendar." "Existing System"
        
        # actors
        student = person "Student" "Enrolls in courses, views enrollment status, and manages their class schedule."
        teacher = person "Teacher" "Views class rosters, manages course capacities, and approves special enrollment requests."
        administrator = person "Administrator" "Configures enrollment periods, manages course offerings, and handles enrollment exceptions."
        
        # relationships between users and Enrollment System
        student -> enrollmentSystem "Enrolls in courses, drops classes, and views enrollment history"
        teacher -> enrollmentSystem "Views enrolled students, sets enrollment limits, and approves waitlist requests"
        administrator -> enrollmentSystem "Configures enrollment rules, manages enrollment periods, and resolves conflicts"
        enrollmentSystem -> student "Sends enrollment confirmations and waitlist notifications to"
        enrollmentSystem -> teacher "Notifies about enrollment changes and capacity limits to"

        ### relationships of Subject Analyzer components


        # relationships between external systems and Enrollment System
        enrollmentSystem -> scheduleModule "Retrieves course schedules, time conflicts, and room availability from"
        scheduleModule -> enrollmentSystem "Notifies about schedule changes to"
    }
    
    views {
        systemContext enrollmentSystem "enrollmentSystemContextDiagram" {
            include *
            autoLayout
        }

        container enrollmentSystem "enrollmentSystemContainerDiagram" {
            include *
            autoLayout
        }

        component subjectAnalyzer "subjectAnalyzerComponentDiagram" {
            include *
            autoLayout
        }
        
        theme default
        
        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }

            element "Web Front-End" {
                shape WebBrowser
            }

            element "Database" {
                shape Cylinder
            }
        }
    }
    
}