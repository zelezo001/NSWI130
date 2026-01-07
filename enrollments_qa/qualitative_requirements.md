# Availability
- **Scenario**: 
  - Student => Unable to read their enrolled subjects => **[Enrollment Manager]** => Mask (ask backup), log => 2s downtime
- **Architecture changes**:
  - read-only backup instance(s) of Enrollment Manager

# Performance
- **Scenario**: 
  - 1000 enrollment requests per second from students => Unable to enroll within 1 second => **[Enrollment Manager]** => Process all => With average latency below 1s
- **Architecture changes**:
  - scalable Enrollment Manager:
    - add load balancer, split subjects between instances, split read requests from enroll/deroll requests

# Performance
- **Scenario**: 
  - Enrollment archiver => periodically reads (stochastic) 20000 events/hour data => **[Enrollment event log database]** => all events archived => with maximum of twelve hours delay
- **Architecture changes**: 
  - none

# Modifiability
- **Scenario**: 
  - New notification channel is support is requested => Developer implements support of channel =>  **[Notification Manager]** => Concrete notification channels can be encapsuled inside 'Notification Manager container', no need to modify core logic => 3 man-days of development & testing 
- **Architecture changes**: 
  - none

# Modifiability
- **Scenario**: 
  - New feature requires change in the Enrollment Database schema => Developer modifies schema => **[Enrollment Manager]** => Changes are localized to an anticorruption layer => 1 man-week of development and testing
- **Architecture changes**:
  - add anticorruption layer between Enrollment Manager components and the Enrollment Database

# Modifiability
- **Scenario**: 
  - Enrollment validators => needs to preprocess data => **[Students Database Handler]** => supports adding data preprocessing => one month of development and testing
- **Architecture changes**: 
  - add Students Database Handler between Enrollment validators and Students Database

# Security
- **Scenario**:
  - Student => Disputes enrollment failure => **[Enrollment Event Log Database]** => Administrator requests event history =>  Logs with timestamps and failure reasons retrieved withing 5 minutes
- **Architecture changes**:
  - none; The architecture already includes logging and Enrollment History Tracker with its DB

# Integrability
- **Scenario**:
  - External [Schedule Module] changes its API => Developer implements the changes (adapt to new API) => **[Schedule Database Communicator]** => Changes are localized only within the 'Schedule Database Communicator' component with no major impact to core logic
- **Architecture changes**:
  - none; The architecture already isolates external dependencies on schedule module via the Schedule Database Communicator

# Modifiability
- **Scenario**:
    - New platform support is requested (e.g. CUNI mobile app) => New platform is developed =>  **[Enrollment Manager]/[Enrollment Manager load balancer]** => New platform integration can use already developed API, zero development/testing cost in BE modification
- **Architecture changes**:
  - none

# Usability
- **Scenario**: 
  - Student with visual impairment => Attempts to enroll in courses using screen reader => **[Dashboard]** => Successfully complete enrollment process => Within same time as sighted users
- **Architecture changes**:
  - Add WCAG 2.1 AA compliance to Dashboard components with semantic HTML and ARIA labels

# Testability
- **Scenario**: 
  - Developer => Needs to verify complex queue enrollment scenario => **[Queue Manager, Enrollment Manager]** => Automated test executes with clear pass/fail results => Within 30 seconds
- **Architecture changes**:
  - Add dependency injection and test interfaces to enable component isolation and mocking of external systems
