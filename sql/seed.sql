-- AluGhadi Watches — full database setup + seed data
-- Run once to (re)create the entire database schema and load sample data.
-- Safe to re-run: drops and recreates the alughadi database each time.
-- -------------------------------------------------------

DROP DATABASE IF EXISTS alughadi;
CREATE DATABASE alughadi;
USE alughadi;

-- -------------------------------------------------------
-- 1. users
-- -------------------------------------------------------
CREATE TABLE IF NOT Exists users (
    id          INT           AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)   NOT NULL UNIQUE,
    email       VARCHAR(150)  NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,
    role        varchar(20)   NOT NULL DEFAULT 'customer',
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
INSERT INTO users (id, username, email, password, role, is_active, is_verified) VALUES
  (1,  'sabin',  'sabin@example.com',  '$2a$10$dummyhashplaceholder0001', 'admin', 1, 1),
  (2,  'ram',    'ram@example.com',    '$2a$10$dummyhashplaceholder0002', 'customer', 1, 1),
  (3,  'hari',   'hari@example.com',   '$2a$10$dummyhashplaceholder0003', 'customer',1, 0),
  (4,  'sita',   'sita@example.com',   '$2a$10$dummyhashplaceholder0004', 'customer',1, 1),
  (5,  'gita',   'gita@example.com',   '$2a$10$dummyhashplaceholder0005', 'customer',1, 0),
  (6,  'mina',   'mina@example.com',   '$2a$10$dummyhashplaceholder0006', 'customer',1, 1),
  (7,  'dipesh', 'dipesh@example.com', '$2a$10$dummyhashplaceholder0007', 'customer',1, 1),
  (8,  'sunita', 'sunita@example.com', '$2a$10$dummyhashplaceholder0008', 'customer',1, 1),
  (9,  'rohan',  'rohan@example.com',  '$2a$10$dummyhashplaceholder0009', 'customer',1, 0),
  (10, 'priya',  'priya@example.com',  '$2a$10$dummyhashplaceholder0010', 'customer',1, 1);

-- Products
--   image_url is relative to context root so the JSP renders:
--   <img src="${pageContext.request.contextPath}${product.imageUrl}">
--   Product images are organized under /static/images/products/watch_*/
--   All prices in NPR (Nepali Rupees)
INSERT INTO products (id, category_id, name, brand, description, price, old_price, rating, image_url, in_stock) VALUES

  -- Luxury
  (1,  1, 'Royal Prestige Automatic',      'Rolex',          'Swiss-made automatic movement featuring a scratch-resistant sapphire crystal and stunning 18K gold bezel. The 41mm stainless steel case houses a precision COSC-certified caliber with a 72-hour power reserve. Water-resistant to 100m with a smooth sweep second hand and luminescent hour markers. Comes with an Oyster bracelet and folding clasp. Ideal for the discerning gentleman who values heritage, precision, and understated luxury on the wrist.',                       285000.00, 310000.00, 4.9, '/static/images/products/watch_luxury/watch_luxury_1.webp', 1),
  (2,  1, 'Submariner Heritage',           'Omega',          'An iconic diver watch engineered for the depths. Features a ceramic bezel with liquidmetal scale, Co-Axial Master Chronometer movement certified at 15,000 gauss, and a helium escape valve for saturation diving. The 42mm case is crafted from grade 5 titanium with a black ceramic dial. 300m water resistance, unidirectional rotating bezel, and a Super-LumiNova coated hands and indices ensure legibility in any condition. Includes a titanium bracelet with micro-adjust clasp.',                 195000.00, NULL,      4.8, '/static/images/products/watch_luxury/watch_luxury_2.webp', 1),
  (3,  1, 'Tourbillon Grand Complication', 'Patek Philippe', 'The pinnacle of haute horlogerie. This ultra-thin tourbillon features a perpetual calendar displaying day, date, month, and moon phase. The hand-finished movement consists of 342 components assembled by master watchmakers over 800 hours. 72-hour power reserve with twin barrels, housed in an 18K white gold case measuring 39mm. The guilloché dial is hand-engraved with a grain d\'orge pattern. Crocodile leather strap with 18K gold deployant buckle. Limited to 25 pieces worldwide.',                     520000.00, NULL,      5.0, '/static/images/products/watch_luxury/watch_luxury_3.webp', 1),
  (4,  1, 'Pilot Chronograph Elite',       'IWC',            'Aviation-inspired chronograph with a rich heritage dating back to the original Pilot watches of the 1930s. Features a flyback chronograph function allowing instant reset and restart, a soft-iron inner case for magnetic protection, and a COSC-certified in-house movement. The 43mm titanium case keeps the weight down while the sapphire crystal with anti-reflective coating ensures perfect legibility. Day-date display, 60-hour power reserve, and a riveted calfskin strap complete this pilot essential.',                       165000.00, 182000.00, 4.7, '/static/images/products/watch_luxury/watch_luxury_4.webp', 1),

  -- Sports
  (5,  2, 'ProDiver 300M',                 'Seiko',          'A professional-grade dive watch built to ISO 6425 standards. The 44mm stainless steel case features a screw-down crown at 4 o''clock, a unidirectional rotating bezel with luminous marker, and LumiBrite hands and indices for deep-water visibility. Powered by Seiko''s reliable 6R35 automatic movement with 70-hour power reserve and hacking seconds. The hardlex crystal is coated for superior scratch resistance. Comes with a stainless steel bracelet featuring a diver''s extension clasp. Perfect for serious divers and water sports enthusiasts.',               18500.00,  22000.00,  4.6, '/static/images/products/watch_sport/watch_sport_1.webp', 1),
  (6,  2, 'AquaRacer Superprofessional',   'TAG Heuer',      'High-performance sport watch designed for extreme aquatic conditions. The 43mm stainless steel case houses a Calibre 5 automatic movement with 38-hour power reserve. Features a unidirectional rotating bezel with ceramic insert, double security clasp, and screw-down caseback for 300m water resistance. The sunray-brushed blue dial with applied luminescent indices provides excellent readability. Sapphire crystal with anti-reflective treatment on both sides. An ideal companion for diving, sailing, and water sports.',                             75000.00,  NULL,      4.5, '/static/images/products/watch_sport/watch_sport_2.webp', 1),
  (7,  2, 'Speedmaster X-33 Matera',       'Omega',          'A multi-functional solar-powered sports watch designed in collaboration with the European Space Agency. Features GMT dual time zone, mission elapsed time, countdown timer, three alarms, and perpetual calendar. The 45mm grade 2 titanium case is lightweight yet incredibly durable. The digital-analog display combines quartz precision with analog charm. Sapphire crystal with anti-reflective coating, 100m water resistance, and a titanium bracelet with micro-adjust. Used by astronauts and pilots worldwide for mission-critical timekeeping.',                                              95000.00, 108000.00, 4.7, '/static/images/products/watch_sport/watch_sport_3.webp', 1),
  (8,  2, 'Enduro Trail Runner',           'Garmin',         'The ultimate GPS multisport watch for trail runners and outdoor athletes. Features multi-band GPS with SatIQ technology for superior positioning accuracy, a wrist-based heart rate monitor with Pulse Ox, and advanced trail running dynamics including ground contact time, stride length, and vertical oscillation. The 1.4-inch sunlight-readable MIP display is protected by Power Glass solar charging lens. Up to 34 days battery life in smartwatch mode. Includes preloaded TopoActive maps, ClimbPro ascent planner, and weather alerts.',                           42000.00,  NULL,      4.4, '/static/images/products/watch_sport/watch_sport_4.webp', 1),

  -- Classic
  (9,  3, 'Dress Slim Automatic',          'Tissot',         'An elegantly thin automatic dress watch that embodies Swiss watchmaking tradition. The ultra-slim 40mm stainless steel case measures just 9.6mm thick, housing the Powermatic 80 movement with an impressive 80-hour power reserve. The exhibition caseback reveals the beautifully decorated oscillating weight. Scratch-resistant sapphire crystal protects the silver sunray dial with Roman numeral indices. Paired with a genuine Italian leather strap and butterfly deployment clasp. Perfect for formal occasions and everyday sophistication.',                        12500.00,  15000.00,  4.5, '/static/images/products/watch_classic/watch_classic_1.webp', 1),
  (10, 3, 'Heritage Presenter',            'Longines',       'A classic dress watch inspired by the elegant timepieces of the 1940s. The 40mm stainless steel case houses Longines'' exclusive L888 self-winding movement with silicon hairspring and 64-hour power reserve. The cream-colored sector dial features blued steel hands and Arabic numerals in a vintage typography. Domed sapphire crystal adds a retro aesthetic while providing scratch protection. Alligator leather strap with pin buckle. Water resistant to 30m. A timeless piece that bridges heritage and modern reliability.',                        35000.00,  NULL,      4.6, '/static/images/products/watch_classic/watch_classic_2.webp', 1),
  (11, 3, 'Carrera Calibre Heritage',      'TAG Heuer',      'A timeless chronograph reissue that pays homage to the original 1963 Carrera. The 42mm stainless steel case houses the legendary Valjoux 7750 automatic movement with column wheel chronograph, 48-hour power reserve, and date function. The black dial features a tachymeter scale on the flange, three sub-dials with snailed finish, and luminescent applied indices. Domed sapphire crystal with anti-reflective coating. Black alligator leather strap with folding clasp. 100m water resistance makes it versatile for any occasion.',                               68000.00,  75000.00,  4.7, '/static/images/products/watch_classic/watch_classic_3.webp', 1),
  (12, 3, 'Khaki Field Mechanical',        'Hamilton',       'A military-inspired field watch with roots in Hamilton''s World War II heritage. The 38mm stainless steel case houses the hand-wound H-50 movement with an exceptional 80-hour power reserve, rare for a mechanical field watch. The matte black dial features bold Arabic numerals at all hours, railroad minute track, and Super-LumiNova coated hands for nighttime legibility. Domed sapphire crystal with anti-reflective coating, screw-down caseback, and olive NATO canvas strap. 50m water resistance. A rugged, no-nonsense timepiece for everyday adventures.',                         14500.00,  NULL,      4.5, '/static/images/products/watch_classic/watch_classic_4.webp', 1),

  -- Smart
  (13, 4, 'Galaxy Watch Ultra',            'Samsung',        'Samsung''s most premium smartwatch featuring a cushion-shaped 47mm titanium case with sapphire crystal. Runs Wear OS with One UI Watch for seamless integration with Android devices. Advanced health suite includes BioActive Sensor for heart rate, blood pressure, ECG, body composition, and skin temperature monitoring. The 590mAh battery delivers up to 60 hours on a single charge with fast wireless charging. Features dual-frequency GPS, LTE connectivity, 10ATM + IP68 water resistance, and a customizable Quick Button for instant app access.',                        38000.00,  42000.00,  4.3, '/static/images/products/watch_smart/watch_smart_1.webp', 1),
  (14, 4, 'Apple Watch Series 10',         'Apple',          'The most advanced Apple Watch ever made with the thinnest design and largest display in Apple Watch history. The stunning Always-On Retina LTPO3 OLED display reaches up to 2000 nits for outdoor visibility. Features S10 chip for on-device Siri processing, Double Tap gesture, ECG app, blood oxygen monitoring, crash detection, and fall detection. Up to 18 hours of battery life with fast charging — reach 80% in just 30 minutes. Swimproof with WR50 rating, built-in compass, and precision dual-frequency GPS.',                      55000.00,  NULL,      4.6, '/static/images/products/watch_smart/watch_smart_2.webp', 1),
  (15, 4, 'Fenix 8 Solar',                 'Garmin',         'Garmin''s flagship outdoor smartwatch engineered for extreme adventures. The 47mm fiber-reinforced polymer case with solar charging lens extends battery life up to 48 days in expedition mode. Features multi-band GPS with SatIQ, ABC sensors (altimeter, barometer, compass), preloaded TopoActive maps with turn-by-turn navigation, and Garmin''s full health monitoring suite including sleep tracking, HRV status, and training readiness score. The sunlight-readable 1.4-inch MIP display works in any condition. 100m water resistance and MIL-STD-810 tested.',                     72000.00,  NULL,      4.7, '/static/images/products/watch_smart/watch_smart_3.webp', 1),
  (16, 4, 'Amazfit GTR 4',                 'Amazfit',        'An affordable smartwatch that punches above its weight with a stunning 1.43-inch AMOLED display at 466x466 resolution and up to 14 days of battery life. Features 150+ sport modes with automatic recognition, a BioTracker 4.0 PPG sensor for heart rate and SpO2 monitoring, Zepp OS with mini-app support, and Bluetooth calling capability. The aluminum alloy case is paired with a fluoroelastomer strap for all-day comfort. 50m water resistance, built-in GPS with route import, and Alexa voice assistant. Exceptional value for the feature set.',                                   8500.00,  10000.00,  4.2, '/static/images/products/watch_smart/watch_smart_4.webp', 1),

  -- Womens
  (17, 5, 'Rose Diamond Elegance',         'Chopard',        'A breathtaking expression of feminine luxury. The 36mm 18K rose gold case is adorned with 48 brilliant-cut diamonds totaling 0.76 carats, each hand-set by Chopard''s master jewelers. The mother-of-pearl dial shimmers with iridescent hues, featuring diamond hour markers and delicate dauphine hands. Powered by a Swiss quartz movement for precise timekeeping. The bracelet is crafted from 18K rose gold with a butterfly clasp. 30m water resistance. Presented in Chopard''s signature green box with certificate of authenticity.',                   145000.00,  NULL,     4.9, '/static/images/products/watch_womens/watch_womens_1.webp', 1),
  (18, 5, 'Ballon Bleu de Cartier',        'Cartier',        'One of Cartier''s most iconic designs, the Ballon Bleu captivates with its distinctive rounded case and signature blue sapphire cabochon crown. The 33mm stainless steel case houses an automatic movement visible through the sapphire caseback. The silvered guilloché dial features Roman numeral hour markers, blued steel sword-shaped hands, and a date window at 3 o''clock. The fluted crown guard integrates seamlessly into the case design. Stainless steel bracelet with concealed folding clasp. 30m water resistance. A modern classic for the elegant woman.',                              235000.00,  NULL,     4.8, '/static/images/products/watch_womens/watch_womens_2.webp', 1),
  (19, 5, 'Ladymatic Aqua Terra',          'Omega',          'A feminine masterpiece from Omega''s prestigious Aqua Terra collection. The 34mm stainless steel case features a diamond-set bezel with 30 brilliant-cut diamonds. Powered by the Co-Axial Master Chronometer Caliber 8520, certified for magnetic resistance up to 15,000 gauss. The white mother-of-pearl dial displays a wave pattern inspired by the ocean, with diamond hour markers and luminescent hands. Alligator leather strap with stainless steel buckle. 150m water resistance makes it equally at home at a gala or on the beach.',                           125000.00, 138000.00, 4.7, '/static/images/products/watch_womens/watch_womens_3.webp', 1),
  (20, 5, 'T-Wave Quartz',                 'Tissot',         'An elegant Swiss quartz watch designed for the modern woman who appreciates refined simplicity. The distinctive tonneau-shaped 30mm stainless steel case creates a graceful silhouette on the wrist. Features a scratch-resistant sapphire crystal protecting a silver sunray dial with slim baton indices and Tissot''s signature "T" at the crown. The stainless steel bracelet has a jewelry-style butterfly clasp for secure and comfortable wear. Water resistant to 30m. An ideal gift for birthdays, anniversaries, or as a treat for yourself.',               9500.00,  11500.00, 4.4, '/static/images/products/watch_womens/watch_womens_4.webp', 1);

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
