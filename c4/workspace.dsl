workspace "School Enrollment System" "This workspace documents the architecture of the Enrollment System which manages student course enrollments, teacher assignments, and administrative oversight." {
    
    model {
        # software systems
        enrollmentSystem = softwareSystem "Enrollment System" "Manages course enrollments, class capacities, prerequisites validation, and enrollment periods for students and teachers." {

            subjectAnalyzer = container "Subject Analyzer" "Filters subjects and provides subject/time slot recommendations." {
                subjectSorter = component "Sorter" "Sorts provided subjects based on given criteria."
                subjectSuggestor = component "Subject Suggestor" "Suggests subjects for empty time slots in the users' enrolled schedule."
                alternativeSuggestor = component "Alternative suggestor" "For an unavailable time slot of a subject, gives free time slots that don't overlap with the users' schedule."
            }

            scheduleDbCommunicator = container "Schedule Database Communicator" "Acts as a single point of connection to the subject database." {
                scheduleTableGetter = component "Schedule Getter" "Fetches the subject table from the subject system."
                scheduleTeacherGetter = component "Teacher Schedule Getter" "Fetches all subjects for a given teacher in the current semester."
            }

            # Enrollment system databases
            subjectDB = container "Subject Capacity Database" "Stores students enrolled to specific subjects." "" "Database"
            logDB = container "Enrollment Event Log Database" "Stores logs of changes in enrollment." "" "Database"
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

        ## relationships of Enrollment System containers

        scheduleDbCommunicator -> scheduleModule "Reads from schedule database"
        subjectAnalyzer -> scheduleDbCommunicator "Processes raw schedule data" 

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

        component scheduleDbCommunicator "scheduleDbCommunicatorDiagram" {
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