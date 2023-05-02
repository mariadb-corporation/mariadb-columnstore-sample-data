# Sample ColumnStore Data
## Description 
This simple data set uses the [on time performance](https://www.transtats.bts.gov/homepage.asp) dataset from the *Bureau of Transportation Statistics (BTS)* for US based commercial airline flights. This includes the following 3 tables:

*   **airlines** : Dimension table for airlines
*   **airports** : Dimension table for airports
*   **flights** : Fact table for airline departure data

## Quick Start
### Clone The Repo
```
git clone https://github.com/mariadb-corporation/mariadb-columnstore-samples.git
cd mariadb-columnstore-samples
```
### Run The Project
```
./run_project
```
This script will:
1. Create sample schemas(s)
2. Download flight data from our public S3 bucket
3. Load into the database
4. Offer you the ability to clone this data to InnoDB for direct comparisions with ColumnStore.

## Sample Queries
The following sample queries are provided in the [queries directory](/queries/):

1.  **1.sql** : Provides a report of flight count, market share percentage, cancelled flights percentage, and diverted flights percentage by airline for 2020.
2.  **2.sql** : Provides a report of the delay types by airline by year.
3.  **3.sql** : Provides a report of the volume and average arrival delay for California based airports by airline in 2020.
4.  **4.sql** : Provides a report of the average and maximum delay by month and hour in the day for bay area airports in 2020.
5.  **5.sql** : Provides a report of the average and maximum delay by day and hour for bay area airports in November 2020.
```
mariadb -vvv columnstore_bts < queries/1.sql
```
or
```
mariadb -vvv innodb_bts < queries/1.sql
```

## InnoDB vs ColumnStore Comparison

### Environment
|Metric                |Value                |
|:---------------------|--------------------:|
|Provider              |AWS                  |
|Instance Type         |m5.8xlarge           |
|Architecture          |x86_64               |
|CPU                   |32                   |
|RAM                   |128GB                |
|MariaDB Version       |10.6.12              |
|ColumnStore Version   |23.02.2              |

### Data Load Times
|Engine                |Time                 |
|:---------------------|--------------------:|
|InnoDB                |19 min 10.126 sec    |
|ColumnStore           |68.5367 sec          |

### Query Times

|Query                 |InnoDB*               |ColumnStore          |
|:--------------------:|--------------------:|--------------------:|
|[1](/queries/1.sql)   |27.226 sec           |0.457 sec            |
|[2](/queries/2.sql)   |1 min 24.368 sec     |1.523 sec            |
|[3](/queries/3.sql)   |6.038 sec            |0.209 sec            |
|[4](/queries/4.sql)   |6.070 sec            |0.093 sec            |
|[5](/queries/5.sql)   |18.589 sec           |0.418 sec            |    

_*Note: InnoDB tables were given indexes and a warm bufferpool._

### Disk Usage
|Engine                |Size                 |
|:---------------------|--------------------:|
|InnoDB                |15GB                 |
|ColumnStore           |2GB                  |