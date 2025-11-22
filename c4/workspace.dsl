workspace "School Enrollment System" "This workspace documents the architecture of the Enrollment System which manages student course enrollments, teacher assignments, and administrative oversight." {

    model {
        scheduleModule = softwareSystem "Schedule Module" "Manages course schedules, classroom assignments, time slots, and academic calendar." "Existing System"
        mailingService = softwareSystem "Mailing Service" "External e-mail handling service." "Existing System"
        enrollmentSystem = softwareSystem "Enrollment System" "Manages course enrollments, class capacities, prerequisites validation, and enrollment periods for students and teachers." {

            # Enrollment system databases
            logDB = container "Enrollment Event Log Database" "Stores logs of changes in enrollment." "" "Database"

            enrollmentManager = container "Enrollment Manager" "Manages enrollments and cancellations" {
                enrollmentRequestProcessor = component "Enrollment Request Processor" "Processes student enrollment requests and coordinates the enrollment flow."
                //cancellationHandler = component "Cancellation Handler" "Handles enrollment cancellations and modifications."
                group "Enrollment Validators - Validates various conditions before enrollment." {
                    capacityValidator = component "Capacity Validator" "Validates ticket capacity before allowing enrollment."
                    prerequisitesChecker = component "Prerequisites Checker" "Checks if student meets prerequisites for a subject."
                    ruleEnforcer = component "Rule Enforcer" "Enforces enrollment rules like mandatory lecture-exercise pairing and enrollment attempt limits."
                }
                enrollmentHistoryTracker = component "Enrollment History Tracker" "Tracks and stores enrollment history for students."


                group "Subject Analyzer - Filters subjects and provides subject/time slot recommendations." {
                    subjectSorter = component "Subject Sorter" "Sorts provided subjects based on given criteria."
                    subjectSuggestor = component "Subject Suggestor" "Suggests subjects for empty time slots in the users' enrolled schedule."
                    alternativeSuggestor = component "Alternative suggestor" "For an unavailable time slot of a subject, gives free time slots that don't overlap with the users' schedule."
                }
                group "Queue Manager - Manages operations related to the queue." {
                    queuePositionManager = component "Queue Position Manager" "Manages student positions in the queue and maintains queue order."
                    queueProcessor = component "Queue Processor" "Processes queue operations like adding, removing, and validating queue entries."
                    automaticEnrollmentHandler = component "Automatic Enrollment Handler" "Automatically enrolls the first student from queue when capacity becomes available."
                    queueNotificationCoordinator = component "Queue Notification Coordinator" "Coordinates notifications for queue-related events."
                    queueCapacityValidator = component "Queue Capacity Validator" "Validates queue capacity limits and enforces maximum waiting students."
                    manualEnrollmentHandler = component "Manual Enrollment Handler" "Handles teacher-initiated enrollment from queue with capacity expansion."
                }

                scheduleDbCommunicator = component "Schedule Database Communicator" "Acts as a single point of connection to the subject database."

                group "Configuration manager - admin controls" {
                    currentEnrollmentDatesManager = component "Current Enrollment Dates Manager" "Manages the enrollment dates for the current period"
                    pastEnrollmentDatesGetter = component "Past Enrollment Dates Getter" "Gets the enrollment dates for past enrollment periods"
                    enrollmentConfigurationRepository = component "Enrollment Configuration Repository" "Stores configurations for all study periods"
                }

            }


            notificationManager = container "Notification Manager" "Sends notifications to users"

            enrollmentDB = container "Enrollment Database" "Stores enrollments of students to tickets and queue" "" "Database"

            logger = container "Logger" "Manages writing all enrollment event logs." {
                changeLog = component "Change Log" "Records all modification events across the enrollment system (e.g., capacity updates, enrollment period changes)."
                enrollmentHistory = component "Subject enrollment History" "Tracks and manages records of all student subject (un)enrollments."

            }
            dashboard = container "Dashboard" "Provides an administrative overview of the enrollment system status and activities." "HTML+Javascript" "Web Front-End" {
                queueItemsHTML = component "Queue Items HTML" "Displays a table of subjects for which the user is registered in a queue." "HTML+Javascript" "Web Front-End"
                studentsInQueueHTML = component "Queueud Students HTML" "Displays a table of students which are in queue for a given ticket." "HTML+Javascript" "Web Front-End"
                // enrollmentConfigurationHTML = component "Enrollment Configuration HTML" "Allows viewing parameters for enrollment periods and changing them for the current one" "HTML+Javascript" "Web Front-End"

                logViewer = component "Change History Viewer" "Displays the history of system changes and enrollment events (read from Logger)."
                enrolledSubjectsViewer = component "Enrolled Subjects Viewer" "Displays the list of subjects a student is currently enrolled in."
                alternativeViewer = component "Alternative Subject Viewer" "Displays suggested alternative subjects for unavailable time slots."
            }
            enrollmentArchiver = container "Enrollment Archiver" "Archives past enrollment data for long-term storage and compliance."
            enrollmentArchiveDB = container "Enrollment archive" "Stores past enrollments" "" "Database"
        }
        accessControl = softwareSystem "Authentication and authorization API" "Manages user authentication and authorization." "Existing System"
        studentsDB = softwareSystem "Students Database" "Stores information about students" "Existing System"

        # archiver

        enrollmentArchiver -> enrollmentDB "Periodically reads current enrollment data"
        enrollmentArchiver -> logDB "Periodically reads all logs"
        enrollmentArchiver -> enrollmentArchiveDB "Writes archived enrollment data"

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


        ### relationships of Subject Analyzer group
        subjectSorter -> scheduleDbCommunicator "Sorts lists of subjects provided by the schedule module."
        subjectSuggestor -> scheduleDbCommunicator "Gets full subject list to compare options."
        subjectSuggestor -> enrollmentDB "Requests student's current enrollment schedule to evaluate free slots."
        alternativeSuggestor -> scheduleDbCommunicator "Requests subject schedules to find an alternative free slot."

        ### relationships of Queue Manager components
        queueProcessor -> queuePositionManager "Manages queue positions through"
        queueProcessor -> queueCapacityValidator "Validates capacity before adding to queue"
        queueProcessor -> enrollmentDB "Reads and writes queue entries"
        queuePositionManager -> enrollmentDB "Updates student positions in queue"
        automaticEnrollmentHandler -> queuePositionManager "Gets first student from queue"
        # automaticEnrollmentHandler -> enrollmentManager "Requests enrollment for student"
        automaticEnrollmentHandler -> queueNotificationCoordinator "Triggers notification for enrolled student"
        manualEnrollmentHandler -> queuePositionManager "Gets selected student from queue"
        # manualEnrollmentHandler -> enrollmentManager "Requests enrollment with capacity expansion"
        manualEnrollmentHandler -> queueNotificationCoordinator "Triggers notification for manually enrolled student"
        queueNotificationCoordinator -> notificationManager "Sends queue-related notifications"
        queueCapacityValidator -> scheduleDbCommunicator "Checks maximum queue capacity settings"

        ### relationships of Enrollment Manager components
        enrollmentRequestProcessor -> capacityValidator "Validates ticket capacity"
        enrollmentRequestProcessor -> prerequisitesChecker "Checks prerequisites"
        enrollmentRequestProcessor -> ruleEnforcer "Enforces enrollment rules"
        enrollmentRequestProcessor -> currentEnrollmentDatesManager "Checks if enrollment period is active"
        enrollmentRequestProcessor -> enrollmentDB "Records successful enrollment"
        enrollmentRequestProcessor -> enrollmentHistoryTracker "Logs enrollment action"
        //enrollmentRequestProcessor -> queueManager "Adds student to queue if capacity full"
        // capacityValidator -> scheduleDbCommunicator "Checks current ticket capacity"
        prerequisitesChecker -> studentsDB "Gets student's completed subjects"
        // prerequisitesChecker -> scheduleDbCommunicator "Gets subject prerequisites"
        // ruleEnforcer -> scheduleDbCommunicator "Gets subject-specific rules"
        ruleEnforcer -> studentsDB "Gets student enrollment history"
        //cancellationHandler -> enrollmentDB "Removes enrollment record"
        //cancellationHandler -> enrollmentHistoryTracker "Logs cancellation action"
        //cancellationHandler -> queueManager "Triggers automatic enrollment from queue"
        enrollmentRequestProcessor -> alternativeSuggestor "Gets available alternative tickets"
        enrollmentHistoryTracker -> logDB "Writes enrollment events to log"
        ### relationships of Enrollment Configuration Manager components
        //currentEnrollmentDatesManager -> enrollmentConfigurationRepository "Reads and writes enrollment dates for the current period"
        // currentEnrollmentDatesManager -> enrollmentManager "Provides current enrollmentDates"
        // pastEnrollmentDatesGetter -> enrollmentConfigurationRepository "Asks for the dates for past enrollments"
        // enrollmentConfigurationRepository -> enrollmentDB "Reads and writes information about enrollment configuration"

        scheduleDbCommunicator -> scheduleModule "Retrieves and processes external schedule info."

        # relationships between external systems and Enrollment System
        enrollmentSystem -> scheduleModule "Retrieves course schedules, time conflicts, and room availability from"
        scheduleModule -> enrollmentSystem "Notifies about schedule changes to"

        queueItemsHTML -> enrollmentManager "Makes API calls to"
        studentsInQueueHTML -> enrollmentManager "Makes API calls to"
        //queueManager -> queueItemsHTML "Gives data about items in queue"
        //queueManager -> notificationManager "Makes requests upon removing and adding to queue"

        //studentsInQueueHTML -> queueManager "Makes API calls to"
        //queueManager -> studentsInQueueHTML "Provides students in queue"
        //queueManager -> studentsDB "Reads information about students"

        //queueManager -> scheduleDbCommunicator "Reads information about tickets"
        //queueManager -> enrollmentDB "Reads and writes info about students' in-queue tickets"

        // enrollmentConfigurationHTML -> currentEnrollmentDatesManager "Makes API calls to"
        // enrollmentConfigurationManager -> enrollmentConfigurationHTML "Gives current enrollment dates"
        // enrollmentConfigurationManager -> enrollmentDB "Reads and writes enrollment configuration"

        //enrollmentManager -> queueManager "Sends requests to add to queue/remove to queue"
        //enrollmentConfigurationManager -> queueManager "Turns on/off based on changes"
        # relationship between users and presentation layers
        student -> queueItemsHTML "Views their items in the queue."
        teacher -> studentsInQueueHTML "Views students in the queue."
        // administrator -> enrollmentConfigurationHTML "Sets enrollment period dates."

        # logger relationships
        enrollmentManager -> logger "Writes general enrollment event logs (successful enrollment/cancellation)"
        //queueManager -> logger "Writes queue-related event logs"
        changeLog -> logDB "Writes general events"
        enrollmentHistory -> logDB "Writes enrollment events"

        # dashboard relationships
        student -> dashboard "Views their current list of enrolled subjects"
        student -> dashboard "Views suggested alternative subjects for time conflicts"

        administrator -> dashboard "Views system status and change logs"

        student -> enrolledSubjectsViewer "Views currently enrolled subjects"
        enrolledSubjectsViewer -> enrollmentManager "Reads currently enrolled subjects"
        student -> alternativeViewer "Views suggested alternative subjects"
        alternativeViewer -> alternativeSuggestor "Reads suggested alternative subjects"
        logViewer -> changeLog "Reads event logs for display"

        # notification manager relationships
        notificationManager -> student "Sends enrollment and waitlist notifications"

        notificationManager -> teacher "Sends notifications about enrollment changes"
        notificationManager -> teacher "Sends notifications about class capacity limits"

        notificationManager -> administrator "Sends critical system alerts"

        //notificationManager -> queueManager "Receives queue-related notification requests"
        notificationManager -> enrollmentManager "Receives enrollment confirmation notifications"
        // notificationManager -> enrollmentConfigurationManager "Sends enrollment period change alerts"
        notificationManager -> logger "Logs notification events"

        notificationManager -> dashboard "Sends system status updates"
        notificationManager -> mailingService "Requests e-mail distribution for important notices."

        # authentication and authorization relationships
        enrollmentSystem -> accessControl "Authenticates and authorizes users"
        accessControl -> enrollmentSystem "Provides authentication and authorization services"

        deploymentEnvironment "Development" {
            deploymentNode "Users" "" "" {
            }

            deploymentNode "Developer Computer" "" "" {
                deploymentNode "SQL Databases Container" "" "Docker" {
                    deploymentNode "SQL Databases" "" "PostgreSQL server" {
                        containerInstance enrollmentDB
                        containerInstance logDB
                    }
                }

                deploymentNode "Object Storage Container" "" "Docker" {
                    deploymentNode "Object storage" "" "Minio" {
                        containerInstance enrollmentArchiveDB
                    }
                }

                deploymentNode "Dashboard Server Container" "" "Docker" {
                    deploymentNode "Dashboard Server" "" "Nginx" {
                        containerInstance dashboard
                    }
                }

                deploymentNode "Monorepo Development build" {
                    deploymentNode "Enrollment manager" "" ".NET runtime" {
                        containerInstance enrollmentManager
                    }

                    deploymentNode "Notification manager" "" ".NET runtime" {
                        containerInstance notificationManager
                    }

                    deploymentNode "Logger" "" ".NET runtime" {
                        containerInstance logger
                    }

                    deploymentNode "Archiver" "" ".NET runtime" {
                        containerInstance enrollmentArchiver
                    }
                }
            }
        }

        deploymentEnvironment "Production" {
            deploymentNode "Users" "" "" {
            }

            deploymentNode "AWS" "" "" {
                deploymentNode "Web Application" "" "AWS EC2 instance, Nginx" {
                    containerInstance dashboard
                }

                deploymentNode "Compute engine" "" "AWS Fargate" {
                    deploymentNode "Core container, scalable" {
                        deploymentNode "Core" "" ".NET runtime" {
                            containerInstance enrollmentManager
                        }
                    }

                    deploymentNode "Background Jobs" "" ".NET runtime, AWS lambdas" {
                        containerInstance logger
                        containerInstance enrollmentArchiver
                    }
                }

                deploymentNode "Notifications" "" "AWS EC2 instance, .NET runtime" {
                    containerInstance notificationManager
                }

                deploymentNode "Database Tier" "" "AWS RDS, PostgreSQL" {
                    containerInstance enrollmentDB
                    containerInstance logDB
                }

                deploymentNode "Archive Storage" "" "AWS S3 object storage" {
                    containerInstance enrollmentArchiveDB
                }
            }
        }
    }

    views {
        dynamic enrollmentSystem "StudentEnrollsContainerView" "Flow of container interactions during a student's enrollment to a subject." {
            student -> dashboard "Opens their dashboard, searches for a subject to-enroll by name/ID/etc."
            dashboard -> enrollmentManager "Asks for a list of subjects."
            enrollmentManager -> scheduleModule "Requests subject list from the schedule module."
            enrollmentManager -> dashboard "Updates list of subjects."
            dashboard -> student "Displays subject list."
            student -> dashboard "Selects desired subject."
            dashboard -> enrollmentManager "Requests time-slot data for given subject."
            enrollmentManager -> scheduleModule "Requests up-to-date information for given subject."
            enrollmentManager -> dashboard "Provides available time slots for given subject."
            dashboard -> student "Displays available time slots."

            student -> dashboard "Selects lecture at a time frame they want to attend."
            dashboard -> enrollmentManager "Asks for validation of request."
            enrollmentManager -> enrollmentDB "Writes successful enrollment to the module database."
            enrollmentManager -> logger "Logs enrollment attempt."

            enrollmentManager -> notificationManager "[A] If valid (enough capacity, prereqs fulfilled), signals for UI confirmation."
            enrollmentManager -> notificationManager "[B] If invalid (time frame full), signals for error.

            notificationManager -> student "Sends notification about enrollment."
            notificationManager -> mailingService "Optionally, sends e-mail confirming status."

            autoLayout
        }

        dynamic enrollmentSystem "StudentCancelsEnrollment_ContainerView" "Dynamic diagram showing container flow for a student cancelling an enrollment." {
            student -> dashboard "Open dashboard, selects cancel enrollment and submits request"
            dashboard -> enrollmentManager "Sends cancellation request"

            {
                {
                    enrollmentManager -> enrollmentDB "Validates and removes enrollment record, updates capacity"
                }
                {
                    enrollmentManager -> logger "Logs cancellation event"
                }
            }

            {
                {
                    enrollmentManager -> enrollmentDB "Checks for students in queue for the ticket"
                }
                {
                    enrollmentManager -> notificationManager "Notifies student of successful cancellation, notifies queued student he was enrolled"
                }
            }

            notificationManager -> student "Delivers confirmations"
            enrollmentManager -> dashboard "Updates dashboard view"
            dashboard -> student "Displays updated enrolled subjects"

            autoLayout
        }

        dynamic enrollmentSystem "ManualEnrollmentFromQueueContainerView" "Dynamic diagram showing container flow for a teacher manually enrolling a student from the queue." {
            teacher -> dashboard "Opens dashboard, views students in queue for a subject"
            dashboard -> enrollmentManager "Requests list of students in queue"

            enrollmentManager -> enrollmentDB "Retrieves students in queue"
            enrollmentManager -> dashboard "Provides queue list"

            teacher -> dashboard "Selects a student to enroll from the queue"
            dashboard -> enrollmentManager "Sends manual enrollment request"

            enrollmentManager -> enrollmentDB "Validates request, expands capacity, enrolls student"
            enrollmentManager -> logger "Logs manual enrollment event"

            enrollmentManager -> notificationManager "Requests notifications for enrollment"
            notificationManager -> student "Notifies student of successful enrollment"
            notificationManager -> teacher "Notifies teacher of successful manual enrollment"
            notificationManager -> mailingService "Optionally, forwards the notifications to mailing service"

            enrollmentManager -> dashboard "Updates dashboard view"
            dashboard -> teacher "Displays updated queue and enrollment status"

            autoLayout
        }

        dynamic enrollmentSystem "EnrollmentPeriodSettingContainerView" "Dynamic diagram showing container flow for an administrator changing the enrollment period dates." {
            administrator -> dashboard "Opens dashboard, selects enrollment configuration page"

            dashboard -> enrollmentManager "Requests current enrollment period dates"
            enrollmentManager -> enrollmentDB "Retrieves current enrollment period dates"
            enrollmentManager -> dashboard "Provides current dates"

            administrator -> dashboard "Modifies enrollment period dates and submits changes"
            dashboard -> enrollmentManager "Sends updated enrollment period dates"

            enrollmentManager -> enrollmentDB "Validates and saves new enrollment period dates"

            dashboard -> administrator "Displays updated enrollment period information"

            enrollmentManager -> logger "Logs enrollment period date changes"
            logger -> logDB "Writes change event"

            autoLayout
        }

        dynamic enrollmentSystem "EnrollmentLimitNumberOfEnrollmentsContainerView" "Dynamic diagram showing container flow for an administrator setting enrollment limit for a course." {
            administrator -> dashboard "Opens dashboard, selects enrollment configuration page"

            dashboard -> enrollmentManager "Requests current enrollment limit for the subject"
            enrollmentManager -> scheduleModule "Retrieves current enrollment limit from schedule module"
            enrollmentManager -> dashboard "Provides current enrollment limit"

            administrator -> dashboard "Sets new enrollment limit and submits changes"
            dashboard -> enrollmentManager "Sends updated enrollment limit"

            enrollmentManager -> scheduleModule "Validates and updates enrollment limit in schedule module"

            dashboard -> administrator "Displays updated enrollment limit information"

            enrollmentManager -> logger "Logs enrollment limit changes"
            logger -> logDB "Writes change event"

            autoLayout
        }

        deployment enrollmentSystem "Development" "DevelopmentDeployment" {
            include *
            autoLayout
        }

        deployment enrollmentSystem "Production" "ProductionDeployment" {
            include *
            autoLayout
        }

        systemContext enrollmentSystem "enrollmentSystemContextDiagram" {
            include *
            autoLayout
        }

        container enrollmentSystem "enrollmentSystemContainerDiagram" {
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
