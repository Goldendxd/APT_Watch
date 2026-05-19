# AluGhadi Watches — E-commerce Platform

A full-stack e-commerce web application for a premium watch store based in Pokhara, Nepal. Built with Jakarta EE (JSP/Servlets), MySQL, and embedded Tomcat.

## Tech Stack

- **Backend**: Java, Jakarta Servlet 6.1, JSP 4.0, JSTL 3.0
- **Frontend**: Vanilla JS, CSS custom properties, Chart.js
- **Database**: MySQL (XAMPP) on port 3306
- **Build**: Maven with Cargo plugin (embedded Tomcat 10.x on port 9090)
- **Payment**: eSewa payment gateway integration

## Features

### Customer Side
- Browse full product catalogue with category filters and search
- Product detail pages
- Shopping cart (server-side, per session)
- Wishlist (localStorage)
- User registration and login with session management
- Profile management (name, address, phone)
- Gifting section with For Him / For Her collections
- Checkout with eSewa online payment or Cash on Delivery
- Payment success / failure handling

### Admin Side
- Dashboard with KPI cards (total products, stock, customers, revenue, orders)
- Monthly sales revenue chart (real DB data)
- Products by category and stock doughnut charts
- Top performing products (by units sold)
- Full product management — add, edit, delete with image upload
- Customer count and growth chart
- Analytics section with price range distribution
- Admin profile management

## Project Structure

```
APT_Watch/
├── pom.xml
└── src/main/
    ├── java/com/alughadi/
    │   ├── controller/
    │   │   ├── HomeServlet.java
    │   │   ├── ProductServlet.java
    │   │   ├── ProductDetailsServlet.java
    │   │   ├── CartServlet.java
    │   │   ├── CheckoutServlet.java (COD: CodOrderServlet)
    │   │   ├── EsewaPaymentServlet.java
    │   │   ├── EsewaCallbackServlet.java
    │   │   ├── GiftingServlet.java
    │   │   ├── ForHimServlet.java
    │   │   ├── ForHerServlet.java
    │   │   ├── LoginServlet.java
    │   │   ├── RegisterServlet.java
    │   │   ├── LogoutServlet.java
    │   │   ├── ProfileServlet.java
    │   │   ├── AdminServlet.java
    │   │   ├── AdminProfileServlet.java
    │   │   └── filter/AuthenticationFilter.java
    │   ├── dao/          # DAO interfaces and implementations
    │   ├── entity/       # Model classes
    │   └── utils/        # PasswordUtil, SessionUtil
    └── webapp/
        ├── WEB-INF/views/
        │   ├── layout/
        │   │   ├── header.jsp    # Shared nav, cart modal
        │   │   └── footer.jsp    # Shared footer, toast, scripts
        │   ├── index.jsp
        │   ├── products.jsp
        │   ├── product-details.jsp
        │   ├── gifting.jsp
        │   ├── for-him.jsp
        │   ├── for-her.jsp
        │   ├── cart.jsp
        │   ├── checkout.jsp
        │   ├── payment-success.jsp
        │   ├── payment-fail.jsp
        │   ├── login.jsp
        │   ├── register.jsp
        │   ├── profile.jsp
        │   ├── admin.jsp
        │   ├── admin-profile.jsp
        │   ├── about.jsp
        │   ├── contact.jsp
        │   └── error.jsp
        └── static/
            ├── css/
            │   ├── global.css
            │   └── pages/        # Per-page CSS files
            ├── js/app.js         # Shared JS (nav, cart, toast, wishlist, auth)
            └── images/
```

## Pages & Routes

| Route | Description |
|---|---|
| `/` | Homepage — hero, featured products, store info |
| `/products` | Full catalogue with search and category filter |
| `/products?id=X` | Product detail page |
| `/gifting` | Gifting hub |
| `/gifting/for-him` | For Him collection |
| `/gifting/for-her` | For Her collection |
| `/cart` | Cart page |
| `/checkout` | Checkout — eSewa or COD |
| `/esewa-pay` | eSewa payment initiation |
| `/esewa-callback` | eSewa callback handler |
| `/login` | Login |
| `/register` | Register |
| `/logout` | Logout |
| `/profile` | User profile |
| `/admin` | Admin dashboard |
| `/admin-profile` | Admin profile |
| `/contact` | Contact page |
| `/about` | About page |

## Getting Started

### Prerequisites

- Java 17+
- Maven 3.8+
- XAMPP (MySQL running on port 3306)

### Setup

1. Start XAMPP and ensure MySQL is running.

2. Import the database schema (create the `alughadi` database and run the SQL setup script).

3. Build and run:

```bash
mvn clean package
mvn cargo:run
```

4. Open: `http://localhost:9090/alughadi`

### Run on a different port

```bash
mvn cargo:run -Dcargo.servlet.port=9091
```

## Color Scheme

| Variable | Value | Usage |
|---|---|---|
| `--green` | `#1a6b38` | Primary — buttons, links |
| `--green2` | `#258a4a` | Hover states |
| `--accent` | `#3dba62` | Highlights |
| `--gold` | `#c9a452` | Price, ratings |
| `--text` | `#0b1c10` | Body text |
| `--bg` | `#f2f6f2` | Page background |

## Contributors

- [Goldendxd](https://github.com/Goldendxd)
- [Sabin062](https://github.com/Sabin062)
- [ashishthapa1414-bit](https://github.com/ashishthapa1414-bit)
- [dikxu237](https://github.com/dikxu237)
