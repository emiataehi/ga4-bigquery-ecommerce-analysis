# GA4 and BigQuery Ecommerce Analysis

This project uses Google Analytics 4 and BigQuery to investigate user behaviour, channel value and purchase patterns across the Google Merchandise Store. The dataset is publicly available through the GA4 demo account.

I started in GA4 Reports and Explore to understand how sessions, events and user journeys are structured before writing any SQL. I then moved into BigQuery to answer specific business questions the GA4 interface could not answer on its own. The findings are presented in a three-page Power BI dashboard built from the exported query results.

---

## Business Questions

1. Where in the purchase journey do users drop out, and at which stage is the loss greatest?
2. Which acquisition channels bring users who spend the most?
3. Which products get viewed or added to cart but rarely purchased?
4. Do users who return for a second purchase spend more than those who only purchase once?
5. Does a channel's value keep growing over 30, 60 and 90 days or does it plateau early?

---

## Key Findings

**The biggest drop happens before users even view a product**

Only 23% of users who started a session went on to view an item. By the purchase stage, just 1.7% of the original session count completed a transaction. The largest single loss point was at the very first step, not at checkout.

**Referral and organic channels produce higher value users than paid search**

Referral had the highest average revenue per user. CPC had the lowest. Over 90 days, organic revenue continued to grow while CPC plateaued after 30 days and did not recover. Volume alone does not reflect channel value.

**Several high-view products had very low purchase rates**

The Android Large Removable Sticker Sheet and Android SM S/F18 Sticker Sheet had the highest event counts but low conversion to purchase. High engagement with a product does not mean it converts.

**Repeat buyers spend significantly more than one-time buyers**

Users who returned for a second purchase had 89% higher average revenue per user than those who purchased only once.

**Channel value trajectories diverge significantly over time**

At 30 days, channel revenue figures looked relatively similar. By 90 days, organic had grown consistently while CPC had not moved. A 30-day snapshot would have produced a different conclusion than the 90-day picture.

---

## Tools Used

- Google Analytics 4, Reports and Explore
- BigQuery, SQL
- Power BI Desktop

---

## Project Structure

```
big_query/
├── 01_funnel_analysis/
├── 02_channel_clv/
├── 03_product_abandonment/
├── 04_repeat_purchase_behaviour/
├── 05_channel_clv_over_time/
└── GA4_BigQuery_Dashboard.pbix
```

---

## How to Run

1. Access the GA4 demo account at analytics.google.com and navigate to the Google Merchandise Store property
2. Open BigQuery and link the GA4 export dataset
3. Run the SQL files in order from 01 to 05
4. Export each query result as a CSV into the matching folder
5. Open the Power BI file and update the data source to point to your exported CSVs
