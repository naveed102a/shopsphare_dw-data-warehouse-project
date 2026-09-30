-- here we are creating dim tables in shopsphere_dw

CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(10),
    zip_code INT
);

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id VARCHAR(50) NOT NULL,
    category VARCHAR(100),
    weight DECIMAL(10,2),
    length DECIMAL(10,2),
    height DECIMAL(10,2),
    width DECIMAL(10,2)
);

CREATE TABLE dim_seller (
    seller_key SERIAL PRIMARY KEY,
    seller_id VARCHAR(50) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(10),
    zip_code INT
);

CREATE TABLE dim_payment (
    payment_key SERIAL PRIMARY KEY,
    payment_type VARCHAR(50),
    installments INT
);

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT
);

-- Ab Source 2 (Excel) ko warehouse mein represent karne ke liye

CREATE TABLE dim_marketing (
    marketing_key SERIAL PRIMARY KEY,
    sales_target DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    marketing_channel VARCHAR(50),
    campaign_cost DECIMAL(10,2),
    customer_segment VARCHAR(50)
);

CREATE TABLE dim_delivery (
    delivery_key SERIAL PRIMARY KEY,
    delivery_days INT,
    shipping_method VARCHAR(50),
    support_tickets INT,
    customer_satisfaction INT
);

-- Ab last dimension — Source 4 JSON ki table banate hain.

CREATE TABLE dim_risk (
    risk_key SERIAL PRIMARY KEY,
    fraud_risk_score DECIMAL(5,2),
    return_flag INT,
    customer_lifetime_value DECIMAL(12,2),
    risk_category VARCHAR(20)
);

CREATE TABLE fact_sales (
    sales_key SERIAL PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,

    customer_key INT,
    product_key INT,
    seller_key INT,
    date_key INT,
    payment_key INT,
    marketing_key INT,
    delivery_key INT,
    risk_key INT,

    price DECIMAL(12,2),
    freight_value DECIMAL(12,2),
    quantity INT,
    total_amount DECIMAL(12,2),

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_product
        FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    CONSTRAINT fk_seller
        FOREIGN KEY (seller_key)
        REFERENCES dim_seller(seller_key),

    CONSTRAINT fk_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key),

    CONSTRAINT fk_payment
        FOREIGN KEY (payment_key)
        REFERENCES dim_payment(payment_key),

    CONSTRAINT fk_marketing
        FOREIGN KEY (marketing_key)
        REFERENCES dim_marketing(marketing_key),

    CONSTRAINT fk_delivery
        FOREIGN KEY (delivery_key)
        REFERENCES dim_delivery(delivery_key),

    CONSTRAINT fk_risk
        FOREIGN KEY (risk_key)
        REFERENCES dim_risk(risk_key)
);

