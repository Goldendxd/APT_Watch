-- One dummy row per table
USE alughadi;
-- DELETE FROM categories;
-- DELETE FROM products;
DELETE FROM users;
-- DELETE FROM wishlists;
-- DELETE FROM for_him_collection;
-- DELETE FROM for_her_collection;

ALTER TABLE users AUTO_INCREMENT = 1;
-- ALTER TABLE products AUTO_INCREMENT = 1;
-- ALTER TABLE categories AUTO_INCREMENT = 1;
-- ALTER TABLE wishlists AUTO_INCREMENT = 1;
-- ALTER TABLE for_him_collection AUTO_INCREMENT = 1;
-- ALTER TABLE for_her_collection AUTO_INCREMENT = 1;

INSERT INTO users (
    username,
    email,
    password,
    role,
    full_name,
    phone,
    date_of_birth,
    gender,
    profile_image,
    address,
    country,
    city,
    Province,
    District,
    LocalUnits,
    Ward,
    is_active,
    is_verified,
    created_at,
    updated_at,
    last_login
) VALUES (
             'demo_user',
             'demo@alughadi.com',
             '$2a$10$abcdefghijklmnopqrstuv',  -- hashed password
             'user',
             'Demo User',
             '9800000000',
             '2000-01-01',
             'male',
             'default.png',
             'Street 1',
             'Nepal',
             'Pokhara',
             'Gandaki',
             'Kaski',
             'Pokhara Metropolitan',
             '10',
             1,
             1,
             CURRENT_TIMESTAMP,
             CURRENT_TIMESTAMP,
             NULL
         );

-- INSERT INTO categories (name, slug)
-- VALUES ('Luxury', 'luxury');
--
-- INSERT INTO products (
-- 	category_id,
-- 	name,
-- 	brand,
-- 	description,
-- 	price,
-- 	old_price,
-- 	rating,
-- 	image_url,
-- 	in_stock
-- )
-- VALUES (
-- 	1,
-- 	'Premium Chronograph Watch',
-- 	'Premium Luxury',
-- 	'Dummy product row seeded from SQL script.',
-- 	499.00,
-- 	699.00,
-- 	4.9,
-- 	'/static/images/snow_leopard.png',
-- 	TRUE
-- );
--
-- INSERT INTO wishlists (user_id, product_id)
-- VALUES (1, 1);
--
-- INSERT INTO for_him_collection (product_id, title, style_tag, price_range, description)
-- VALUES (1, 'Executive Classic', 'classic', 'NPR 8,000 - 15,000', 'Dummy For Him collection row.');
--
-- INSERT INTO for_her_collection (product_id, title, style_tag, price_range, description)
-- VALUES (1, 'Elegant Essential', 'elegant', 'NPR 6,500 - 12,000', 'Dummy For Her collection row.');
