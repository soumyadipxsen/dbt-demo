# dbt-demo

This project demonstrates a simple Data Vault implementation using dbt Cloud and Snowflake.

The source data contains customer and product information, along with the relationship between them.
The data is first cleaned in the staging layer and then loaded into Data Vault hubs, links, and satellites.

The main purpose of this project is to demonstrate:
- Data Vault modelling using dbt
- Data transformation in Snowflake
- Data quality testing
- dbt documentation and lineage
- Logging and debugging
- Basic development standards for a dbt team

This project contains dbt models, tests, documentation, and configurations used to transform and validate data within the target data warehouse.

The project follows standard dbt development practices, including:
- Layered data modeling
- Automated data quality testing
- Documentation and lineage generation
- Environment-based deployment through dbt Cloud

---
## Prerequisites
Before running the project, ensure the following are in place:
- Access to dbt Cloud
- Access to the target data warehouse
- Project repository connected to dbt Cloud
- Appropriate permissions for the development environment
- Required environment variables and credentials configured
---