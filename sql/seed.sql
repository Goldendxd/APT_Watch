-- AluGhadi Watches — full database setup + seed data
-- Run once to (re)create the entire schema and load sample data.
-- Safe to re-run: drops and recreates all tables each time.
-- -------------------------------------------------------

CREATE DATABASE IF NOT EXISTS alughadi;
USE alughadi;

-- -------------------------------------------------------
-- Drop tables in FK-safe order (children first)
-- -------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

SET FOREIGN_KEY_CHECKS = 1;

-- -------------------------------------------------------
-- 1. users
-- -------------------------------------------------------
CREATE TABLE IF NOT Exists users (
    id          INT           AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)   NOT NULL UNIQUE,
    email       VARCHAR(150)  NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,
    is_active   TINYINT(1)    NOT NULL DEFAULT 1,
    is_verified TINYINT(1)    NOT NULL DEFAULT 0,
    created_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login  TIMESTAMP     NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------
-- 2. categories
-- -------------------------------------------------------
CREATE TABLE IF NOT Exists categories (
    id         INT          AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(60)  NOT NULL UNIQUE,
    slug       VARCHAR(60)  NOT NULL UNIQUE,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------
-- 3. products
-- -------------------------------------------------------
CREATE TABLE IF NOT Exists products (
    id          INT            AUTO_INCREMENT PRIMARY KEY,
    category_id INT            NOT NULL,
    name        VARCHAR(150)   NOT NULL,
    brand       VARCHAR(100)   NOT NULL,
    description TEXT,
    price       DECIMAL(10,2)  NOT NULL,
    old_price   DECIMAL(10,2)  NULL,
    rating      DECIMAL(2,1)   NULL,
    image_url   VARCHAR(255)   NULL,
    in_stock    TINYINT(1)     NOT NULL DEFAULT 1,
    created_at  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES categories(id)
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------
-- 4. cart
-- -------------------------------------------------------
CREATE TABLE IF NOT Exists cart (
    id         INT       AUTO_INCREMENT PRIMARY KEY,
    user_id    INT       NOT NULL,
    product_id INT       NOT NULL,
    quantity   INT       NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
    CONSTRAINT fk_cart_product
        FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- -------------------------------------------------------
-- SEED DATA
-- -------------------------------------------------------

-- Categories  (names match the filter buttons in products.jsp)
INSERT INTO categories (id, name, slug) VALUES
  (1, 'Luxury',  'luxury'),
  (2, 'Sports',  'sports'),
  (3, 'Classic', 'classic'),
  (4, 'Smart',   'smart'),
  (5, 'Womens',  'womens');

-- Users  (BCrypt placeholder hashes — replace before production)
INSERT INTO users (id, username, email, password, is_active, is_verified) VALUES
  (1,  'sabin',  'sabin@example.com',  '$2a$10$dummyhashplaceholder0001', 1, 1),
  (2,  'ram',    'ram@example.com',    '$2a$10$dummyhashplaceholder0002', 1, 1),
  (3,  'hari',   'hari@example.com',   '$2a$10$dummyhashplaceholder0003', 1, 0),
  (4,  'sita',   'sita@example.com',   '$2a$10$dummyhashplaceholder0004', 1, 1),
  (5,  'gita',   'gita@example.com',   '$2a$10$dummyhashplaceholder0005', 1, 0),
  (6,  'mina',   'mina@example.com',   '$2a$10$dummyhashplaceholder0006', 1, 1),
  (7,  'dipesh', 'dipesh@example.com', '$2a$10$dummyhashplaceholder0007', 1, 1),
  (8,  'sunita', 'sunita@example.com', '$2a$10$dummyhashplaceholder0008', 1, 1),
  (9,  'rohan',  'rohan@example.com',  '$2a$10$dummyhashplaceholder0009', 1, 0),
  (10, 'priya',  'priya@example.com',  '$2a$10$dummyhashplaceholder0010', 1, 1);

-- Products
--   image_url is relative to context root so the JSP renders:
--   <img src="${pageContext.request.contextPath}${product.imageUrl}">
--   All prices in NPR (Nepali Rupees)
INSERT INTO products (id, category_id, name, brand, description, price, old_price, rating, image_url, in_stock) VALUES

  -- Luxury
  (1,  1, 'Royal Prestige Automatic',      'Rolex',          'Swiss-made automatic movement with sapphire crystal and 18K gold bezel. Water-resistant to 100m.',                       285000.00, 310000.00, 4.9, '/static/images/snow_leopard.png', 1),
  (2,  1, 'Submariner Heritage',           'Omega',          'Iconic diver watch with ceramic bezel and Co-Axial Master Chronometer movement. 300m water resistance.',                 195000.00, NULL,      4.8, '/static/images/snow_leopard.png', 1),
  (3,  1, 'Tourbillon Grand Complication', 'Patek Philippe', 'Ultra-thin tourbillon with perpetual calendar. Hand-finished movement with 72-hour power reserve.',                     520000.00, NULL,      5.0, '/static/images/snow_leopard.png', 1),
  (4,  1, 'Pilot Chronograph Elite',       'IWC',            'Aviation-inspired chronograph with flyback function, titanium case, and COSC-certified movement.',                       165000.00, 182000.00, 4.7, '/static/images/snow_leopard.png', 1),

  -- Sports
  (5,  2, 'ProDiver 300M',                 'Seiko',          'Professional diver with LumiBrite hands, screw-down crown, and ISO 6425 certified 300m water resistance.',               18500.00,  22000.00,  4.6, '/static/images/snow_leopard.png', 1),
  (6,  2, 'AquaRacer Superprofessional',   'TAG Heuer',      'High-performance sport watch with unidirectional rotating bezel and 300m water resistance.',                             75000.00,  NULL,      4.5, '/static/images/snow_leopard.png', 1),
  (7,  2, 'Speedmaster X-33 Matera',       'Omega',          'Multi-functional solar sports watch with GMT, countdown timer, and alarms.',                                              95000.00, 108000.00, 4.7, '/static/images/snow_leopard.png', 1),
  (8,  2, 'Enduro Trail Runner',           'Garmin',         'GPS multisport watch with heart-rate monitor, trail running metrics, and 7-day battery life.',                           42000.00,  NULL,      4.4, '/static/images/snow_leopard.png', 1),

  -- Classic
  (9,  3, 'Dress Slim Automatic',          'Tissot',         'Elegantly thin automatic with sapphire crystal, exhibition caseback, and genuine leather strap.',                        12500.00,  15000.00,  4.5, '/static/images/snow_leopard.png', 1),
  (10, 3, 'Heritage Presenter',            'Longines',       'Classic dress watch inspired by 1940s models. Self-winding movement with 64-hour power reserve.',                        35000.00,  NULL,      4.6, '/static/images/snow_leopard.png', 1),
  (11, 3, 'Carrera Calibre Heritage',      'TAG Heuer',      'Timeless chronograph reissue with Valjoux movement, tachymeter, and black leather strap.',                               68000.00,  75000.00,  4.7, '/static/images/snow_leopard.png', 1),
  (12, 3, 'Khaki Field Mechanical',        'Hamilton',       'Military-inspired field watch with hand-wound movement, domed crystal, and olive canvas strap.',                         14500.00,  NULL,      4.5, '/static/images/snow_leopard.png', 1),

  -- Smart
  (13, 4, 'Galaxy Watch Ultra',            'Samsung',        'Premium smartwatch with Wear OS, advanced health tracking, 60-hour battery, and titanium frame.',                        38000.00,  42000.00,  4.3, '/static/images/snow_leopard.png', 1),
  (14, 4, 'Apple Watch Series 10',         'Apple',          'Most advanced Apple Watch with Always-On display, ECG, crash detection, and 18-hour battery life.',                      55000.00,  NULL,      4.6, '/static/images/snow_leopard.png', 1),
  (15, 4, 'Fenix 8 Solar',                 'Garmin',         'Flagship outdoor smartwatch with solar charging, multi-band GPS, and 28-day battery in solar mode.',                     72000.00,  NULL,      4.7, '/static/images/snow_leopard.png', 1),
  (16, 4, 'Amazfit GTR 4',                 'Amazfit',        'Affordable smartwatch with 150+ sport modes, AMOLED display, and 14-day battery life.',                                   8500.00,  10000.00,  4.2, '/static/images/snow_leopard.png', 1),

  -- Womens
  (17, 5, 'Rose Diamond Elegance',         'Chopard',        'Rose gold case set with 48 brilliant-cut diamonds. Swiss quartz movement with mother-of-pearl dial.',                   145000.00,  NULL,     4.9, '/static/images/snow_leopard.png', 1),
  (18, 5, 'Ballon Bleu de Cartier',        'Cartier',        'Iconic curved sapphire crown, guilloché dial, and automatic movement in stainless steel.',                              235000.00,  NULL,     4.8, '/static/images/snow_leopard.png', 1),
  (19, 5, 'Ladymatic Aqua Terra',          'Omega',          'Feminine Co-Axial watch with diamond-set bezel, alligator strap, and 150m water resistance.',                           125000.00, 138000.00, 4.7, '/static/images/snow_leopard.png', 1),
  (20, 5, 'T-Wave Quartz',                 'Tissot',         'Elegant quartz watch with butterfly clasp, scratch-resistant sapphire, and sunray dial. Great for gifting.',               9500.00,  11500.00, 4.4, '/static/images/snow_leopard.png', 1);

-- Cart sample entries
INSERT INTO cart (user_id, product_id, quantity) VALUES
  (1,  1,  1),
  (1,  9,  1),
  (2,  5,  2),
  (3,  13, 1),
  (4,  17, 1),
  (5,  10, 1),
  (6,  6,  1),
  (7,  14, 1),
  (8,  20, 2),
  (9,  3,  1),
  (10, 8,  1);
