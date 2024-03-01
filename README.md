# Sammy's Soccer Shop Weekly Analysis
## Project Summary
Sammy’s Soccer Shop is a fictional soccer equipment business. Their philosophy is to provide reliable, industry-standard equipment at a reasonable price. They receive orders from all around the world. Recently, their Order Management Analyst was diagnosed with a strained left pinky finger and deemed unable to perform the weekly analysis. To fill the position, they hired me. I took on the responsibilities of the role starting on January 1, 2024.

### Business Task
Perform general analysis on the order log and stock control for Sammy’s Soccer Shop for the week of January 1, 2024. Produce two charts, one that shows daily revenue and one that shows the daily bestselling item as a percentage of total units sold for each day of the week.

## About the Data
The data to be analyzed was found in two Excel datasets, SSS_OrderLog and SSS_StockControl. The datasets were generated partially by ChatGPT and partially by using Google Random Number Generator and BehindTheName.com’s Name generator. 
## ChatGPT Prompt / Response

### Prompt
Create a dataset of an imaginary soccer equipment business's order log and stock control as a resource for practicing SQL and data visualization. Deliberately include small errors to practice data cleaning.

### Response
Sure, here's a simplified version of what such a dataset might look like:
### Order Log Dataset:

| Order_ID | Customer_Name | Order_Date | Item_ID | Item_Name     | Quantity | Unit_Price | Total_Price |
|----------|---------------|------------|---------|---------------|----------|------------|-------------|
| 1        | John Doe      | 2023-01-05 | 101     | Soccer Ball   | 2        | 20.99      | 41.98       |
| 2        | Jane Smith    | 2023-01-08 | 102     | Soccer Jersey | 3        | 35.50      | 106.50      |
| 3        | Mike Johnson  | 2023-01-10 | 103     | Shin Guards   | 1        | 15.75      | 15.75       |
| 4        | Emily Brown   | 2023-01-15 | 104     | Soccer Cleats | 2        | 55.25      | 110.50      |
| 5        | John Doe      | 2023-01-20 | 105     | Goalkeeper Gloves | 1   | 29.99      | 29.99       |
| ...      | ...           | ...        | ...     | ...           | ...      | ...        | ...         |
| 75       | Sarah Lee     | 2023-03-15 | 117     | Soccer Socks  | 2        | 9.99       | 19.98       |

### Stock Control Dataset:

| Item_ID | Item_Name        | Quantity_in_Stock | Last_Restocked |
|---------|------------------|-------------------|----------------|
| 101     | Soccer Ball      | 15                | 2023-02-01     |
| 102     | Soccer Jersey    | 20                | 2023-01-25     |
| 103     | Shin Guards      | 10                | 2023-02-10     |
| 104     | Soccer Cleats    | 12                | 2023-01-30     |
| 105     | Goalkeeper Gloves| 8                 | 2023-02-05     |
| ...     | ...              | ...               | ...            |
| 117     | Soccer Socks     | 25                | 2023-02-20     |

### Notes:
- **Errors**: To simulate small errors, you might introduce discrepancies between the quantities ordered and the quantities in stock, or slight variations in dates and prices.
- **Completeness**: Ensure that both datasets have a total of 75 rows each for sufficient practice.
- **Data Types**: Dates should be formatted consistently, and prices should have appropriate precision (e.g., two decimal places for currency).
- **Consistency**: Check that item IDs and names match between the two datasets, and ensure that restocking dates are logical (e.g., not in the future).
- **Integrity**: Each item in the order log should have a corresponding entry in the stock control dataset.
- **Realism**: While this is an imaginary dataset, try to keep the quantities and prices within realistic ranges for soccer equipment.
- **Data Cleaning Practice**: You can include missing values, duplicate entries, or inconsistent formatting to provide opportunities for data cleaning practice.

## Cleaning Data in Excel
-	(Multiple orders were assigned to the same order Id for Id’s 56-60. Fixed by moving the second set of duplicates up 5 along w the nonduplicates that come after i.e. 5661… 6166…7580 )
-	Added Total Price column to Order Log (Not to be confused with Order Total column which will be added later)
-	Updated Last_Restocked column in SSS_StockControl
- Exported tables as CSVs
-	Imported csv’s into Azure Data Studio to be queried with SQL

## Analyzing Data with SQl
THe SQL queries I used to analyze the data (and generate the following visualizations) can be found [HERE](https://github.com/r7ckyj/Sammy-sSoccerShop/blob/1fa59e76ebdf10ff796e4bb36d564aa871fe7630/SSSqueries.sql)

## Visualizations With Tableau
<p align="center">
  <img width="460" src="https://github.com/r7ckyj/SammysSoccerShop/assets/156801040/15ce17ca-5ed8-4367-8556-def803d3f6e7">
</p>
Our Soccer Balls were the bestselling item for 3/6 days this week (tied w/ Lanyards on Tuesday) and made up about 30% of total sales for Wednesday.

<p align="center">
  <img width="231" src="https://github.com/r7ckyj/SammysSoccerShop/assets/156801040/c7226c87-60cf-4ffd-a2b9-021a0c7a0841">
</p>
We brought in the most money on Saturday, and the least on Wednesday.

<p align="center">
<img width="482" src="https://github.com/r7ckyj/SammysSoccerShop/assets/156801040/7e525a0d-e7b4-4540-ba1f-8f1da4562d19">
</p>
The most concerning result I discovered was that a few orders contained understocked items. These orders won’t be able to be processed until the items are restocked, which should happen ASAP.


## Conclusion
