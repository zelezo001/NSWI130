workspace "School Enrollment System" "This workspace documents the architecture of the Enrollment System which manages student course enrollments, teacher assignments, and administrative oversight." {

    model {
        scheduleModule = softwareSystem "Schedule Module" "Manages course schedules, classroom assignments, time slots, and academic calendar." "Existing System"
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

            queueManager = container "Queue Manager" "Manages operations related to the queue."
            queueItemsHTML = container "Queue Items HTML" "Displays a table of subjects for which the user is registered in a queue." "HTML+Javascript" "Web Front-End"
            studentsInQueueHTML = container "Queueud Students HTML" "Displays a table of students which are in queue for a given ticket." "HTML+Javascript" "Web Front-End"

            enrollmentManager = container "TODO: Zápis manager" "TODO: Manages enrollments and cancellations"
            enrollmentConfigurationManager = container "Enrollment Configuration Manager" "Manages enrollment configuration" {
                currentEnrollmentDatesManager = component "Current Enrollment Dates Manager" "Manages the enrollment dates for the current period"
                pastEnrollmentDatesGetter = component "Past Enrollment Dates Getter" "Gets the enrollment dates for past enrollment periods"
                enrollmentConfigurationRepository = component "Enrollment Configuration Repository" "Stores configurations for all study periods"
            }

            enrollmentConfigurationHTML = container "Enrollment Configuration HTML" "Allows viewing parameters for enrollment periods and changing them for the current one" "HTML+Javascript" "Web Front-End"

            notificationManager = container "Notification Manager" "Sends notifications to users"

            enrollmentDB = container "Enrollment Database" "Stores enrollments of students to tickets and queue" "" "Database"
            subjectsDB = container "Subjects Database" "Stores information about each subject and tickets" "" "Database"
            studentsDB = container "Students Database" "Stores information about students" "" "Database"

            logger = container "Logger" "Manages writing all enrollment event logs." {
                changeLog = component "Change Log" "Records all modification events across the enrollment system (e.g., capacity updates, enrollment period changes)."
                enrollmentHistory = component "Subject enrollment History" "Tracks and manages records of all student subject (un)enrollments."

            }
            dashboard = container "Dashboard" "Provides an administrative overview of the enrollment system status and activities." "HTML+Javascript" "Web Front-End" {
                logViewer = component "Change History Viewer" "Displays the history of system changes and enrollment events (read from Logger)."
                enrolledSubjectsViewer = component "Enrolled Subjects Viewer" "Displays the list of subjects a student is currently enrolled in."
                alternativeViewer = component "Alternative Subject Viewer" "Displays suggested alternative subjects for unavailable time slots."
            }

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

        ## relationships of Enrollment System containers

        scheduleDbCommunicator -> scheduleModule "Reads from schedule database"
        subjectAnalyzer -> scheduleDbCommunicator "Processes raw schedule data"

        ### relationships of Subject Analyzer components


        ### relationships of Enrollment Configuration Manager components
        currentEnrollmentDatesManager -> enrollmentConfigurationRepository "Reads and writes enrollment dates for the current period"
        currentEnrollmentDatesManager -> enrollmentManager "Provides current enrollmentDates"
        pastEnrollmentDatesGetter -> enrollmentConfigurationRepository "Asks for the dates for past enrollments"
        enrollmentConfigurationRepository -> enrollmentDB "Reads and writes information about enrollment configuration"

        # relationships between external systems and Enrollment System
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

        enrollmentManager -> enrollmentConfigurationManager "Checks if enrollments are allowed"
        enrollmentConfigurationHTML -> enrollmentConfigurationManager "Makes API calls to"
        enrollmentConfigurationManager -> enrollmentConfigurationHTML "Gives current enrollment dates"
        enrollmentConfigurationManager -> enrollmentDB "Reads and writes enrollment configuration"

        enrollmentManager -> queueManager "Sends requests to add to queue/remove to queue"
        enrollmentConfigurationManager -> queueManager "Turns on/off based on changes"
        # relationship between users and presentation layers
        student -> queueItemsHTML "Views their items in the queue."
        teacher -> studentsInQueueHTML "Views students in the queue."
        administrator -> enrollmentConfigurationHTML "Sets enrollment period dates."

        # logger relationships
        enrollmentManager -> logger "Writes general enrollment event logs (successful enrollment/cancellation)"
        queueManager -> logger "Writes queue-related event logs"
        changeLog -> logDB "Writes general events"
        enrollmentHistory -> logDB "Writes enrollment events"

        # dashboard relationships
        student -> dashboard "Views their current list of enrolled subjects"
        student -> dashboard "Views suggested alternative subjects for time conflicts"

        administrator -> dashboard "Configures enrollment period dates"
        administrator -> dashboard "Views system status and change logs"

        enrolledSubjectsViewer -> enrollmentManager "Reads currently enrolled subjects"
        alternativeViewer -> alternativeSuggestor "Reads suggested alternative subjects"
        logViewer -> changeLog "Reads event logs for display"
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

        component enrollmentConfigurationManager "enrollmentPeriodanager" {
            include *
            autoLayout
        }

        component logger "loggerComponentDiagram" {
            include *
            autoLayout
        }

        component dashboard "dashboardComponentDiagram" {
            include *
            autoLayout
        }

        component enrollmentManager "enrollmentManagerComponentDiagram" {
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