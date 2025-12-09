# Availability
Student => Unable to read their enrolled subjects => [ Enrollment Manager ] => Mask (ask backup), log => 2s downtime
- Architecture changes:
  - read-only backup instance(s) of Enrollment Manager

# Performance
1000 enrollment requests from students => Unable to enroll within 1 second => [ Enrollment Manager ] => Process all => With average latency below 1s
- Architecture change:
  - scalable Enrollment Manager:
    - add load balancer, split subjects between instances, split read requests from enroll/deroll requests

# Modifiability
- Scenario: New notification channel is support is requested => Developer implements support of channel =>  [Notifcation Module] => Concrete notification channels are encapsuled inside 'Notifcation Module', no need to modify core logic
- Architecture change: none; 

# Modifiability
New feature requires change in the Enrollment Database schema => Developer modifies schema => [ Enrollment Manager ] => Changes are localized to an anticorruption layer => 1 man-week of development and testing
- Architecture change:
  - add anticorruption layer between Enrollment Manager components and the Enrollment Database

# Security
- Scenario:
  - Student => Disputes enrollment failure => [Enrollment Event Log Database] => Administrator requests event history =>  Logs with timestamps and failure reasons retrieved withing 5 minutes
- Architecture change:
  - none; The architecture already includes logging and Enrollment History Tracker with its DB

# Integrability
- Scenario:
  - External [Schedule Module] changes its API => Developer implements the changes (adapt to new API) => [Schedule Database Communicator] => Changes are localized only within the 'Schedule Database Communicator' component with no major impact to core logic
- Architecture change:
  - none; The architecture already isolates external dependencies on schedule module via the Schedule Database Communicator
