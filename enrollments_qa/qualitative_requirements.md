# Availability
Student => Unable to read their enrolled subjects => [ Enrollment Manager ] => Mask (ask backup), log => 2s downtime

# Performance
1000 enrollment requests from students => Unable to enroll within 1 second => [ Enrollment Manager ] => Process all => With a maximum of 1000 req/s
