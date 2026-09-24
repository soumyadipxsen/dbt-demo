# dbt-demo

This project demonstrates a simple Data Vault implementation using dbt Cloud and Snowflake.
The source data contains customer and product information, along with the relationship between them. The data is first cleaned in the staging layer and then loaded into Data Vault hubs, links, and satellites.
The main purpose of this project is to demonstrate:
- Data Vault modelling using dbt
- Data transformation in Snowflake
- Data quality testing
- dbt documentation and lineage
- Logging and debugging
- Basic development standards for a dbt team