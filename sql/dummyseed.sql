-- Database: alughadi
CREATE DATABASE IF NOT EXISTS alughadi;
USE alughadi;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

-- ----------------------------
-- Table: categories
-- ----------------------------
CREATE TABLE categories (
                            id INT(11) NOT NULL AUTO_INCREMENT,
                            name VARCHAR(60) NOT NULL,
                            slug VARCHAR(60) NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            PRIMARY KEY (id),
                            UNIQUE KEY name (name),
                            UNIQUE KEY slug (slug)
) ENGINE=InnoDB;

INSERT INTO categories (id, name, slug) VALUES
                                            (1,'Electronics','electronics'),
                                            (2,'Clothing','clothing'),
                                            (3,'Books','books'),
                                            (4,'Home Appliances','home-appliances'),
                                            (5,'Sports','sports'),
                                            (6,'Beauty','beauty'),
                                            (7,'Toys','toys'),
                                            (8,'Groceries','groceries'),
                                            (9,'Furniture','furniture'),
                                            (10,'Footwear','footwear');

-- ----------------------------
-- Table: users
-- ----------------------------
CREATE TABLE users (
                       id INT(11) NOT NULL AUTO_INCREMENT,
                       username VARCHAR(50) NOT NULL,
                       email VARCHAR(150) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       is_active INT(1) DEFAULT 1,
                       is_verified INT(1) DEFAULT 0,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       last_login TIMESTAMP NULL,
                       PRIMARY KEY (id),
                       UNIQUE KEY username (username),
                       UNIQUE KEY email (email)
) ENGINE=InnoDB;

INSERT INTO users (id, username, email, password, is_active, is_verified) VALUES
                                                                              (1,'sabin','sabin@example.com','pass123',1,1),
                                                                              (2,'ram','ram@example.com','pass123',1,1),
                                                                              (3,'hari','hari@example.com','pass123',1,0),
                                                                              (4,'sita','sita@example.com','pass123',1,1),
                                                                              (5,'gita','gita@example.com','pass123',1,0),
                                                                              (6,'mina','mina@example.com','pass123',1,1),
                                                                              (7,'rita','rita@example.com','pass123',1,0),
                                                                              (8,'john','john@example.com','pass123',1,1),
                                                                              (9,'alex','alex@example.com','pass123',1,0),
                                                                              (10,'rohan','rohan@example.com','pass123',1,1);

-- ----------------------------
-- Table: products
-- ----------------------------
CREATE TABLE products (
                          id INT(11) NOT NULL AUTO_INCREMENT,
                          category_id INT(11) NOT NULL,
                          name VARCHAR(150) NOT NULL,
                          brand VARCHAR(100) NOT NULL,
                          description TEXT,
                          price DECIMAL(10,2) NOT NULL,
                          old_price DECIMAL(10,2),
                          rating DECIMAL(2,1),
                          image_url VARCHAR(255),
                          in_stock TINYINT(1) DEFAULT 1,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          PRIMARY KEY (id),
                          KEY fk_products_category (category_id),
                          CONSTRAINT fk_products_category FOREIGN KEY (category_id)
                              REFERENCES categories(id)
) ENGINE=InnoDB;

INSERT INTO products VALUES
                         (1,1,'Smartphone','Samsung','Latest Android phone',500,550,4.5,'img1.jpg',1,NOW()),
                         (2,1,'Laptop','Dell','Core i7 Laptop',900,1000,4.7,'img2.jpg',1,NOW()),
                         (3,2,'T-Shirt','Nike','Cotton T-shirt',20,25,4.2,'img3.jpg',1,NOW()),
                         (4,3,'Novel Book','Penguin','Fiction novel',15,18,4.3,'img4.jpg',1,NOW()),
                         (5,4,'Microwave','LG','800W Microwave',120,150,4.4,'img5.jpg',1,NOW()),
                         (6,5,'Football','Adidas','Standard football',25,30,4.6,'img6.jpg',1,NOW()),
                         (7,6,'Face Cream','Nivea','Moisturizer',10,12,4.1,'img7.jpg',1,NOW()),
                         (8,7,'Toy Car','Hot Wheels','Mini toy',5,7,4.5,'img8.jpg',1,NOW()),
                         (9,8,'Rice 5kg','Local','Premium rice',20,22,4.0,'img9.jpg',1,NOW()),
                         (10,9,'Sofa','IKEA','3-seater sofa',300,350,4.6,'img10.jpg',1,NOW());

-- ----------------------------
-- Table: cart
-- ----------------------------
CREATE TABLE cart (
                      id INT(11) NOT NULL AUTO_INCREMENT,
                      user_id INT(11) NOT NULL,
                      product_id INT(11) NOT NULL,
                      quantity INT(11) DEFAULT 1,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      PRIMARY KEY (id),
                      KEY fk_cart_user (user_id),
                      KEY fk_cart_product (product_id),
                      CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                      CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO cart (id,user_id,product_id,quantity) VALUES
                                                      (1,1,1,2),
                                                      (2,2,2,1),
                                                      (3,3,3,3),
                                                      (4,4,4,1),
                                                      (5,5,5,2),
                                                      (6,6,6,1),
                                                      (7,7,7,4),
                                                      (8,8,8,2),
                                                      (9,9,9,1),
                                                      (10,10,10,1);

COMMIT;