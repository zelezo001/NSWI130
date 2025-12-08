# Quality attributes

Author: Michal Matoušek

1. Design time
- type: Modifiability
- scenario: Enrollment validators -- needs to preprocess data --> Students Database Handler -- supports adding data preprocessing --> one month of development and testing
- architecture change: add Students Database Handler between Enrollment validators and Students Database

2. Run time
- type: Performance:
- scenario: Enrollment archiver -- periodically reads data --> Enrollment event log database -- all events archived --> with maximum of twelve hours delay
- architecture change: none