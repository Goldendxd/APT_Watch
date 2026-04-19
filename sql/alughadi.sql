-- AluGhadi core schema (derived from JSP views)
-- create and use database
CREATE DATABASE IF NOT EXISTS alughadi;
USE alughadi;

-- Drop existing tables for a clean install
-- (order matters: entries → topics → users, because of foreign keys)
-- DROP TABLE IF EXISTS categories;
-- DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS wishlists;
-- DROP TABLE IF EXISTS for_him_collection;
-- DROP TABLE IF EXISTS for_her_collection;

CREATE TABLE IF NOT EXISTS users (
--     Basic Info
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(150) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,

-- 	role VARCHAR(20) NOT NULL DEFAULT 'user',
--
-- --     Personal Info
--     full_name VARCHAR(100) NOT NULL,
--     phone VARCHAR(15) UNIQUE,
--     date_of_birth DATE,
--     gender ENUM('male', 'female', 'other'),
--     profile_image VARCHAR(255) DEFAULT 'default.png',
--
-- --     Address Info
--     address VARCHAR(100),
--     country VARCHAR(100),
--     city VARCHAR(100),
--     Province VARCHAR(100),
--     District VARCHAR(100),
--     LocalUnits VARCHAR(100),
--     Ward VARCHAR(100),
--
-- --     Account Status
    is_active INT(1) DEFAULT 1,
    is_verified INT(0) DEFAULT 0,

--     Timestamps
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL
);



-- CREATE TABLE IF NOT EXISTS categories (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	name VARCHAR(60) NOT NULL UNIQUE,
-- 	slug VARCHAR(60) NOT NULL UNIQUE,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
--
-- CREATE TABLE IF NOT EXISTS products (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	category_id INT NOT NULL,
-- 	name VARCHAR(150) NOT NULL,
-- 	brand VARCHAR(100) NOT NULL,
-- 	description TEXT,
-- 	price DECIMAL(10,2) NOT NULL,
-- 	old_price DECIMAL(10,2),
-- 	rating DECIMAL(2,1),
-- 	image_url VARCHAR(255),
-- 	in_stock BOOLEAN NOT NULL DEFAULT TRUE,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	CONSTRAINT fk_products_category
-- 		FOREIGN KEY (category_id) REFERENCES categories(id)
-- 		ON DELETE RESTRICT
-- );
--
-- CREATE TABLE IF NOT EXISTS wishlists (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	user_id INT NOT NULL,
-- 	product_id INT NOT NULL,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	CONSTRAINT fk_wishlists_user
-- 		FOREIGN KEY (user_id) REFERENCES users(id)
-- 		ON DELETE CASCADE,
-- 	CONSTRAINT fk_wishlists_product
-- 		FOREIGN KEY (product_id) REFERENCES products(id)
-- 		ON DELETE CASCADE,
-- 	CONSTRAINT uq_wishlists_user_product UNIQUE (user_id, product_id)
-- );
--
-- CREATE TABLE IF NOT EXISTS for_him_collection (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	product_id INT,
-- 	title VARCHAR(150) NOT NULL,
-- 	style_tag VARCHAR(50) NOT NULL,
-- 	price_range VARCHAR(60) NOT NULL,
-- 	description TEXT,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	CONSTRAINT fk_for_him_collection_product
-- 		FOREIGN KEY (product_id) REFERENCES products(id)
-- 		ON DELETE SET NULL
-- );
--
-- CREATE TABLE IF NOT EXISTS for_her_collection (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	product_id INT,
-- 	title VARCHAR(150) NOT NULL,
-- 	style_tag VARCHAR(50) NOT NULL,
-- 	price_range VARCHAR(60) NOT NULL,
-- 	description TEXT,
-- 	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- 	CONSTRAINT fk_for_her_collection_product
-- 		FOREIGN KEY (product_id) REFERENCES products(id)
-- 		ON DELETE SET NULL
-- );
