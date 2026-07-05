-- ВНИМАНИЕ: перед запуском замени путь C:/olist_data/ на свой (на папку, куда скачались CSV с Kaggle)
COPY customers FROM 'C:/olist_data/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY geolocation FROM 'C:/olist_data/olist_geolocation_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY orders FROM 'C:/olist_data/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY products FROM 'C:/olist_data/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY sellers FROM 'C:/olist_data/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY order_items FROM 'C:/olist_data/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY order_payments FROM 'C:/olist_data/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY order_reviews FROM 'C:/olist_data/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
COPY product_category_translation FROM 'C:/olist_data/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');