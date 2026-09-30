-- 1. Customers
CREATE TABLE olist_customers_dataset (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);
-- 2. Orders
CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
-- 3. Order Items
CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12,2),
    freight_value NUMERIC(12,2)
);
-- 4. Products
CREATE TABLE olist_products_dataset (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);
-- 5. Payments
CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value NUMERIC(12,2)
);
-- 6. Sellers
CREATE TABLE olist_sellers_dataset (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);
-- 7. Reviews
CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);
-- 8. Category Translation
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

SELECT COUNT(*) AS customers
FROM olist_customers_dataset;

SELECT COUNT(*) AS orders
FROM olist_orders_dataset;

SELECT COUNT(*) AS order_items
FROM olist_order_items_dataset;

SELECT COUNT(*) AS products
FROM olist_products_dataset;

SELECT COUNT(*) AS payments
FROM olist_order_payments_dataset;

SELECT COUNT(*) AS sellers
FROM olist_sellers_dataset;

SELECT COUNT(*) AS reviews
FROM olist_order_reviews_dataset;

SELECT COUNT(*) AS categories
FROM product_category_name_translation;

SELECT *
FROM olist_customers_dataset
LIMIT 5;

SELECT *
FROM olist_orders_dataset
LIMIT 5;

SELECT *
FROM olist_order_items_dataset
LIMIT 5;

SELECT
    tc.table_name,
    kcu.column_name,
    tc.constraint_type
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE tc.table_schema = 'public'
  AND tc.constraint_type IN ('PRIMARY KEY', 'FOREIGN KEY')
ORDER BY tc.table_name;


-- ADD forigen keys

ALTER TABLE olist_orders_dataset
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES olist_customers_dataset(customer_id);

ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_items_order
FOREIGN KEY (order_id)
REFERENCES olist_orders_dataset(order_id);

ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_items_product
FOREIGN KEY (product_id)
REFERENCES olist_products_dataset(product_id);

ALTER TABLE olist_order_items_dataset
ADD CONSTRAINT fk_items_seller
FOREIGN KEY (seller_id)
REFERENCES olist_sellers_dataset(seller_id);

-- now we create the source 2 
SELECT order_id
FROM olist_orders_dataset
LIMIT 1000;


