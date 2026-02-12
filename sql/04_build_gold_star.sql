DROP TABLE IF EXISTS gold.fact_sales;
DROP TABLE IF EXISTS gold.dim_seller;
DROP TABLE IF EXISTS gold.dim_product;
DROP TABLE IF EXISTS gold.dim_customer;
DROP TABLE IF EXISTS gold.dim_date;

-- Dimensions
CREATE TABLE gold.dim_date AS
SELECT
  date_key,
  date,
  year,
  quarter,
  month,
  month_name,
  week,
  day,
  day_name,
  is_weekend
FROM silver.dim_date;

ALTER TABLE gold.dim_date
  ADD CONSTRAINT pk_dim_date PRIMARY KEY (date_key);

CREATE TABLE gold.dim_customer AS
SELECT
  customer_id,
  customer_segment,
  customer_city,
  customer_state,
  signup_date
FROM silver.dim_customers;

ALTER TABLE gold.dim_customer
  ADD CONSTRAINT pk_dim_customer PRIMARY KEY (customer_id);

CREATE TABLE gold.dim_product AS
SELECT
  product_id,
  category,
  brand,
  unit_cost,
  list_price,
  weight_kg
FROM silver.dim_products;

ALTER TABLE gold.dim_product
  ADD CONSTRAINT pk_dim_product PRIMARY KEY (product_id);

CREATE TABLE gold.dim_seller AS
SELECT
  seller_id,
  seller_tier,
  seller_city,
  seller_state,
  onboard_date
FROM silver.dim_sellers;

ALTER TABLE gold.dim_seller
  ADD CONSTRAINT pk_dim_seller PRIMARY KEY (seller_id);

-- Fact (grain: one row per order item)
CREATE TABLE gold.fact_sales AS
SELECT
  oi.order_id,
  oi.order_item_no,
  d.date_key,
  o.customer_id,
  oi.product_id,
  oi.seller_id,
  oi.quantity,
  oi.unit_price,
  oi.discount_pct,
  oi.line_total,
  o.order_status
FROM silver.fact_order_items oi
JOIN silver.fact_orders o
  ON o.order_id = oi.order_id
JOIN silver.dim_date d
  ON d.date = o.order_date;

ALTER TABLE gold.fact_sales
  ADD CONSTRAINT pk_fact_sales PRIMARY KEY (order_id, order_item_no);

-- Foreign keys (star schema links)
ALTER TABLE gold.fact_sales
  ADD CONSTRAINT fk_sales_date FOREIGN KEY (date_key) REFERENCES gold.dim_date(date_key);

ALTER TABLE gold.fact_sales
  ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES gold.dim_customer(customer_id);

ALTER TABLE gold.fact_sales
  ADD CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES gold.dim_product(product_id);

ALTER TABLE gold.fact_sales
  ADD CONSTRAINT fk_sales_seller FOREIGN KEY (seller_id) REFERENCES gold.dim_seller(seller_id);
