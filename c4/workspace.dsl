workspace "School Enrollment System" "This workspace documents the architecture of the Enrollment System which manages student course enrollments, teacher assignments, and administrative oversight." {
    
    model {
        # software systems
        scheduleModule = softwareSystem "Schedule Module" "Manages course schedules, classroom assignments, time slots, and academic calendar." "Existing System"
        enrollmentSystem = softwareSystem "Enrollment System" "Manages course enrollments, class capacities, prerequisites validation, and enrollment periods for students and teachers." {

            queueManager = container "Queue Manager" "Manages operations related to the queue."
            queueItemsHTML = container "Queue Items HTML" "Displays a table of subjects for which the user is registered in a queue." "HTML+Javascript" "Web Front-End"
            studentsInQueueHTML = container "Queueud Students HTML" "Displays a table of students which are in queue for a given ticket." "HTML+Javascript" "Web Front-End"

            enrollmentManager = container "TODO: Zápis manager" "TODO: Manages enrollments and cancellations"
            zapisoveObdobiManager = container "TODO: Zápisové období manager" "TODO: Manages zápisové období"

            notificationManager = container "Notification Manager" "Sends notifications to users"

            # databases
            enrollmentDB = container "Enrollment Database" "Stores enrollments of students to tickets and queue" "" "Database"
            # tohle je ale externí
            subjectsDB = container "Subjects Database" "Stores information about each subject and tickets" "" "Database"
            studentsDB = container "Students Database" "Stores information about students" "" "Database"
        }

        # actors
        student = person "Student" "Enrolls in courses, views enrollment status, and manages their class schedule."
        teacher = person "Teacher" "Views class rosters, manages course capacities, and approves special enrollment requests."
        administrator = person "Administrator" "Configures enrollment periods, manages course offerings, and handles enrollment exceptions."
        
        # relationships between Enrollment System and the outside
        student -> enrollmentSystem "Enrolls in courses, drops classes, and views enrollment history"
        teacher -> enrollmentSystem "Views enrolled students, sets enrollment limits, and approves waitlist requests"
        administrator -> enrollmentSystem "Configures enrollment rules, manages enrollment periods, and resolves conflicts"
        enrollmentSystem -> student "Sends enrollment confirmations and waitlist notifications to"
        enrollmentSystem -> teacher "Notifies about enrollment changes and capacity limits to"
        
        # relationships of Enrollment System containers
        enrollmentSystem -> scheduleModule "Retrieves course schedules, time conflicts, and room availability from"
        scheduleModule -> enrollmentSystem "Notifies about schedule changes to"

        queueItemsHTML -> queueManager "Makes API calls to"
        queueManager -> queueItemsHTML "Gives data about items in queue"
        queueManager -> notificationManager "Makes requests upon removing and adding to queue"

        studentsInQueueHTML -> queueManager "Makes API calls to"
        queueManager -> studentsInQueueHTML "Provides students in queue"
        queueManager -> studentsDB "Reads information about students"

        queueManager -> subjectsDB "Reads information about tickets"
        queueManager -> enrollmentDB "Reads and writes info about students' in-queue tickets"
        
        enrollmentManager -> queueManager "Sends requests to add to queue/remove to queue"
        zapisoveObdobiManager -> queueManager "Turns on/off based on changes"
        # relationship between users and presentation layers
        student -> queueItemsHTML "Views their items in the queue."
        teacher -> studentsInQueueHTML "Views students in the queue."
    }
    
    views {
        systemContext enrollmentSystem "enrollmentSystemContextDiagram" {
            include *
        }

        container enrollmentSystem "enrollmentSystemContainerDiagram" {
            include *
        }

        
        theme default
        
        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }

            element "Web Front-End"  {
                shape WebBrowser
            }

            element "Database"  {
                shape Cylinder
            }
        }
    }
    
}