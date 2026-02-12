DROP TABLE IF EXISTS bronze.dim_customers;
DROP TABLE IF EXISTS bronze.dim_sellers;
DROP TABLE IF EXISTS bronze.dim_products;
DROP TABLE IF EXISTS bronze.dim_date;
DROP TABLE IF EXISTS bronze.fact_orders;
DROP TABLE IF EXISTS bronze.fact_order_items;
DROP TABLE IF EXISTS bronze.fact_payments;
DROP TABLE IF EXISTS bronze.fact_shipments;

CREATE TABLE bronze.dim_customers (
  customer_id TEXT,
  customer_segment TEXT,
  customer_city TEXT,
  customer_state TEXT,
  signup_date TEXT
);

CREATE TABLE bronze.dim_sellers (
  seller_id TEXT,
  seller_tier TEXT,
  seller_city TEXT,
  seller_state TEXT,
  onboard_date TEXT
);

CREATE TABLE bronze.dim_products (
  product_id TEXT,
  category TEXT,
  brand TEXT,
  unit_cost TEXT,
  list_price TEXT,
  weight_kg TEXT
);

CREATE TABLE bronze.dim_date (
  date TEXT,
  date_key TEXT,
  year TEXT,
  quarter TEXT,
  month TEXT,
  month_name TEXT,
  week TEXT,
  day TEXT,
  day_name TEXT,
  is_weekend TEXT
);

CREATE TABLE bronze.fact_orders (
  order_id TEXT,
  customer_id TEXT,
  order_date TEXT,
  order_status TEXT
);

CREATE TABLE bronze.fact_order_items (
  order_id TEXT,
  order_item_no TEXT,
  product_id TEXT,
  seller_id TEXT,
  quantity TEXT,
  unit_price TEXT,
  discount_pct TEXT,
  line_total TEXT
);

CREATE TABLE bronze.fact_payments (
  order_id TEXT,
  payment_method TEXT,
  payment_status TEXT,
  amount TEXT,
  platform_fee TEXT,
  paid_date TEXT
);

CREATE TABLE bronze.fact_shipments (
  order_id TEXT,
  carrier TEXT,
  ship_date TEXT,
  delivery_date TEXT,
  shipment_status TEXT
);
