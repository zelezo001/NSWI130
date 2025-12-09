# Availability
Student => Unable to read their enrolled subjects => [ Enrollment Manager ] => Mask (ask backup), log => 2s downtime

# Performance
1000 enrollment requests from students => Unable to enroll within 1 second => [ Enrollment Manager ] => Process all => With a maximum of 1000 req/s

# Security
- Scenario:
  - Student => Disputes enrollment failure => [Enrollment Event Log Database] => Administrator requests event history =>  Logs with timestamps and failure reasons retrieved withing 5 minutes
- Architecture change:
  - none; The architecture already includes logging and Enrollment History Tracker with its DB

# Integrability
- Scenaroi:
  - External [Schedule Module] changes its API => Developer implements the changes (adapt to new API) => [Schedule Database Communicator] => Changes are localized only within the 'Schedule Database Communicator' component with no major impact to core logic
- Architecture change:
  - none; The architecture already isolates external dependencies on schedule module via the Schedule Database Communicator
