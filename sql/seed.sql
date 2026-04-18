-- One dummy row per table

INSERT INTO users (username, email, password_hash, role)
VALUES ('demo_user', 'demo@alughadi.com', '$2a$10$abcdefghijklmnopqrstuv', 'user');

INSERT INTO categories (name, slug)
VALUES ('Luxury', 'luxury');

INSERT INTO products (
	category_id,
	name,
	brand,
	description,
	price,
	old_price,
	rating,
	image_url,
	in_stock
)
VALUES (
	1,
	'Premium Chronograph Watch',
	'Premium Luxury',
	'Dummy product row seeded from SQL script.',
	499.00,
	699.00,
	4.9,
	'/static/images/snow_leopard.png',
	TRUE
);

INSERT INTO wishlists (user_id, product_id)
VALUES (1, 1);

INSERT INTO for_him_collection (product_id, title, style_tag, price_range, description)
VALUES (1, 'Executive Classic', 'classic', 'NPR 8,000 - 15,000', 'Dummy For Him collection row.');

INSERT INTO for_her_collection (product_id, title, style_tag, price_range, description)
VALUES (1, 'Elegant Essential', 'elegant', 'NPR 6,500 - 12,000', 'Dummy For Her collection row.');
