DROP TABLE IF EXISTS silver.dim_customers;
DROP TABLE IF EXISTS silver.dim_sellers;
DROP TABLE IF EXISTS silver.dim_products;
DROP TABLE IF EXISTS silver.dim_date;
DROP TABLE IF EXISTS silver.fact_orders;
DROP TABLE IF EXISTS silver.fact_order_items;
DROP TABLE IF EXISTS silver.fact_payments;
DROP TABLE IF EXISTS silver.fact_shipments;

-- Dimensions
CREATE TABLE silver.dim_customers AS
SELECT
  customer_id,
  customer_segment,
  customer_city,
  customer_state,
  signup_date::date AS signup_date
FROM bronze.dim_customers;

CREATE TABLE silver.dim_sellers AS
SELECT
  seller_id,
  seller_tier,
  seller_city,
  seller_state,
  onboard_date::date AS onboard_date
FROM bronze.dim_sellers;

CREATE TABLE silver.dim_products AS
SELECT
  product_id,
  category,
  brand,
  unit_cost::numeric(12,2)  AS unit_cost,
  list_price::numeric(12,2) AS list_price,
  weight_kg::numeric(12,3)  AS weight_kg
FROM bronze.dim_products;

CREATE TABLE silver.dim_date AS
SELECT
  date::date AS date,
  date_key::int AS date_key,
  year::int AS year,
  quarter::int AS quarter,
  month::int AS month,
  month_name,
  week::int AS week,
  day::int AS day,
  day_name,
  (is_weekend::boolean) AS is_weekend
FROM bronze.dim_date;

-- Facts
CREATE TABLE silver.fact_orders AS
SELECT
  order_id,
  customer_id,
  order_date::date AS order_date,
  order_status
FROM bronze.fact_orders;

CREATE TABLE silver.fact_order_items AS
SELECT
  order_id,
  order_item_no::int AS order_item_no,
  product_id,
  seller_id,
  quantity::int AS quantity,
  unit_price::numeric(12,2) AS unit_price,
  discount_pct::numeric(5,2) AS discount_pct,
  line_total::numeric(12,2) AS line_total
FROM bronze.fact_order_items;

CREATE TABLE silver.fact_payments AS
SELECT
  order_id,
  payment_method,
  payment_status,
  amount::numeric(12,2) AS amount,
  platform_fee::numeric(12,2) AS platform_fee,
  paid_date::date AS paid_date
FROM bronze.fact_payments;

CREATE TABLE silver.fact_shipments AS
SELECT
  order_id,
  carrier,
  ship_date::date AS ship_date,
  delivery_date::date AS delivery_date,
  shipment_status
FROM bronze.fact_shipments;
