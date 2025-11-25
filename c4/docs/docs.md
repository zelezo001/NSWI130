# C4 Documentation

## Introduction

The Enrollment System manages the complete lifecycle of student course enrollments within an educational institution. It handles enrollment requests, validates prerequisites and capacity constraints, manages queues and provides interface to administer configuration of the system.

The system serves three primary types of users:

- **Students** enroll in courses, views enrollment status, and manage their class schedule

- **Teachers** view enrolled students, manage course capacity limits, and have the ability to manually enroll students from queues

- **Administrators** configure enrollment periods, manage course offerings.

### External Systems

The Enrollment System integrates with several existing systems:

- **Schedule Module** is a source for information like allocation of time slots, classroom assignments and subject information

- **Authentication and Authorization API** handles all user authentication and authorization

- **Students Database** maintains student records including completed courses and academic history

- **Mailing Service** handles email distribution for various notification purposes

## Design decisions

The system was designed with fine granularity and detail but with easy extensibility in mind. The **Dashboard** combines multiple web components to provide easy access to all the core funcionalities.

It passes requests to the **Enrollment Manager**, which is the largest container, housing core enrollment logic. This design reflects high cohesion within containers (components that work together) and low coupling between containers (each can fail, scale, and deploy independently). Its inner workings can be logically grouped together - e.g. enrollment validators, queue manager - but are tightly coupled to other parts of the manager, like enrollment state changes.

The user is informed about the behaviour of the system through separate **Notification Manager** service with optional connection to external mailing service. It is separated due to it's different characteristics and possibility for separate debugging. When the notification server fails, the enrollments still succeed. Important events are also captured by **Logger** service which writes to a database to store historical data. This service can be accessed independently of the enrollment manager to show event logs for monitoring the behaviour of the system which is useful to actors other than the enrollment manager.

**Enrollment Archiver** runs periodic jobs to move finalized data into long-term storage, separate from the Logger's continuous real-time recording. This separation prevents resource-intensive archival operations from competing with live enrollment processing.

## Assignment of Responsibilities

This section maps key system responsibilities for each key feature to specific containers and components in the C4 architecture model. Each responsibility is assigned to maintain clear accountability and avoid duplication of logic.

### Enrollment

- user info: Authentication and authorization API
- data collection: Schedule Database Communicator
- validation: Rule Enforcer, Capacity Validator
- data management: Schedule Database Communicator
- alert responsibility: Notification Manager
- user interface: Dashboard
- rule-enforcing: Rule Enforcer, Prerequisites Checker
- subject sorting: Subject Sorter
- queue: Automatic Enrollment Handler, Queue Position Manager

### Changes and cancellation of enrollment

- authorization and validation: Authentication and authorization API
- data retrieval: Schedule Database Communicator
- capacity management: Capacity Validator
- queue processing: Automatic Enrollment Handler, Queue Position Manager
- notification: Notification Manager
- data persistence: Enrollment Request Processor, Enrollment History Tracker
- user interface: Dashboard
- error handling: Enrollment Request Processor
- data consistency: Rule Enforcer
- alternative offer: Subject Suggestor, Alternative Suggestor

### Enrollment limits

- authorization: Authentication and authorization API
- data persistence: Enrollment Configuration Manager
- notification: Notification manager
- error handling: Enrollment Request Processor
- user interface: Dashboard
- logging: Logger

### Queue

- authentication and authorization: Authentication and authorization API
- data persistence: Manual Enrollment Handler, Automatic Enrollment Handler
- notification: Notification Manager
- validation: Queue Capacity Validator
- (de)activation: Enrollment Configuration Manager
- error handling: Enrollment Request Processor
- user interface: Dashboard
- logging: Logger

### Enrollment Period Configuration

- authorization: Authentication and authorization API
- data validation: Enrollment Configuration Manager
- data persistence: Enrollment Configuration Manager
- notification: Notification Manager
- error handling: Enrollment Request Processor
- user interface: Dashboard
- logging: Logger
