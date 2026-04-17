# AluGhadi Watches - Ecommerce Website Template

A premium ecommerce website template for selling watches, built with JSP and modern CSS. This project is a clean, standalone JSP-based template ready for backend integration.

## 📁 Project Structure

```
APT_Watch/
├── pom.xml                          # Maven configuration
├── src/
│   ├── main/
│   │   ├── java/com/alughadi/       # Java classes (ready for backend)
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   ├── views/           # JSP pages
│   │   │   │   │   ├── layout/
│   │   │   │   │   │   ├── header.jsp
│   │   │   │   │   │   └── footer.jsp
│   │   │   │   │   ├── index.jsp    # Homepage
│   │   │   │   │   └── products.jsp # Products page
│   │   │   │   └── web.xml          # Web configuration
│   │   │   ├── static/
│   │   │   │   ├── app.js           # JavaScript (client-side only)
│   │   │   │   ├── styles/
│   │   │   │   │   ├── global.css   # Main stylesheet
│   │   │   │   │   └── shared/      # CSS components
│   │   │   │   │       ├── base.css
│   │   │   │   │       ├── nav.css
│   │   │   │   │       ├── layout.css
│   │   │   │   │       ├── components.css
│   │   │   │   │       └── overlays.css
│   │   │   │   └── images/          # Static images
└── README.md
```

## 🎨 Features

- **Responsive Design**: Mobile-first approach, works on all screen sizes
- **Modern UI/UX**: Clean, minimalist design inspired by premium ecommerce sites
- **Navigation**: Sticky nav with mobile hamburger menu
- **Product Grid**: Filterable product display with cart functionality
- **Shopping Cart**: Frontend cart system using localStorage
- **Wishlist**: Save favorite products locally
- **Modals & Overlays**: Cart modal and other interactive elements
- **Smooth Animations**: Scroll-triggered reveal animations

## 🚀 Getting Started

### Prerequisites

- Java 25+
- Maven 3.8.0+
- Apache Tomcat 10.x (included via Maven Cargo plugin)

### Setup & Run

1. **Build the project:**

   ```bash
   cd d:\Github work\APT_Watch
   mvn clean package
   ```

2. **Run with embedded Tomcat:**

   ```bash
   mvn cargo:run
   ```

   The site will be available at: `http://localhost:9090/alughadi-watches-1.0-SNAPSHOT`

3. **Override the port:**
   ```bash
   mvn cargo:run -Dcargo.servlet.port=9000
   ```

### Pages

- **Home** (`/`) - Main landing page with hero section, featured collections, features grid
- **Products** (`/products`) - Full product catalog with filters and wishlist
- **Collections** (`/collections`) - Product categories (to be implemented)
- **About** (`/about`) - Company info (to be implemented)
- **Contact** (`/contact`) - Contact page (to be implemented)

## 📝 Template Features

### All JSP Pages Already Include:

- ✅ Page title and meta description (customizable)
- ✅ Active navigation highlighting
- ✅ Header with nav and mobile menu
- ✅ Footer with links and info
- ✅ Loading screen animation
- ✅ Responsive design

### Client-Side Features (No Backend Needed):

- ✅ LocalStorage cart system
- ✅ Wishlist management
- ✅ Product filtering
- ✅ Modal interactions
- ✅ Smooth scrolling

## 🎯 Customization Guide

### Change Colors

Edit `/static/styles/shared/base.css` - modify CSS variables:

```css
:root {
  --green: #1a6b38; /* Primary color */
  --green2: #258a4a; /* Secondary color */
  --green-light: #e7f4ec;
  --text: #0d1f12; /* Text color */
  --bg: #f4f7f4; /* Background */
  /* ... more colors ... */
}
```

### Add Navigation Links

Edit `/WEB-INF/views/layout/header.jsp`:

```jsp
<a href="${pageContext.request.contextPath}/your-page"
   ${activeNav == 'your-page' ? 'class="active"' : ''}>Your Page</a>
```

### Update Product Grid

Edit `/WEB-INF/views/products.jsp` - each product card follows this structure:

```jsp
<div class="product-card" data-cat="category" data-id="product-id">
  <!-- Image container -->
  <!-- Product info -->
  <!-- Price and button -->
</div>
```

### Add New Pages

1. Create a new JSP in `/WEB-INF/views/`
2. Include the header at top:
   ```jsp
   <% request.setAttribute("activeNav", "page-name"); %>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />
   ```
3. Add footer at bottom:
   ```jsp
   <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
   ```

## 🖼️ Using Images

### Placeholder Image

The project uses `snowleopard.png` from the APT project as a placeholder image for products.

To replace with your own:

1. Copy your images to: `/static/images/`
2. Update image URLs in JSP files:
   ```jsp
   <img src="${pageContext.request.contextPath}/static/images/your-image.png" alt="Description" />
   ```

### External Images

The template also references Unsplash images for hero sections. You can replace these with your own CDN URLs.

## 💻 Backend Integration Notes

This is a **frontend-only template**. To add backend functionality:

1. **Create Servlets** in `src/main/java/com/alughadi/`:
   - `HomeServlet.java` - Handle home page
   - `ProductServlet.java` - Handle product listings
   - `CartServlet.java` - Handle cart operations

2. **Add Dependencies** to `pom.xml`:
   - Database drivers (MySQL, PostgreSQL, etc.)
   - Frameworks (Spring, Hibernate)
   - JSON libraries (Jackson, Gson)

3. **Connect JSP Form Actions** to servlets:

   ```jsp
   <form action="${pageContext.request.contextPath}/products" method="get">
     <!-- form fields -->
   </form>
   ```

4. **Example Servlet Structure:**
   ```java
   @WebServlet("/products")
   public class ProductServlet extends HttpServlet {
     protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
       // Fetch products from DB
       req.setAttribute("products", productList);
       req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
     }
   }
   ```

## 🎨 Color Scheme

- **Primary Green**: `#1a6b38` - Used for buttons, links, highlights
- **Secondary Green**: `#258a4a` - Hover states, darker accents
- **Light Green**: `#e7f4ec` - Backgrounds, light accents
- **Text**: `#0d1f12` - Dark text
- **Background**: `#f4f7f4` - Light silvery-green background
- **Border**: `#d8e8dc` - Subtle borders
- **Accent**: `#3dba62` - Additional highlights

## 📱 Responsive Breakpoints

- **Desktop**: 1024px+
- **Tablet**: 768px - 1023px
- **Mobile**: < 768px

## 🔧 Development Tips

1. **Live Reload**: Use your IDE's live reload or browser sync for faster development
2. **Console Logging**: Check browser console for client-side debugging
3. **LocalStorage**: Check Application > Local Storage in DevTools to debug cart/wishlist
4. **CSS Variables**: All colors and sizes use CSS custom properties for easy editing

## 📦 Production Deployment

1. Build WAR file:

   ```bash
   mvn clean package
   ```

2. Deploy to Tomcat:
   - Copy `target/alughadi-watches-1.0-SNAPSHOT.war` to `/webapps/`
   - Or deploy via Tomcat Manager GUI

3. Change context path in `pom.xml` if needed:
   ```xml
   <cargo.war.path>/path/to/war</cargo.war.path>
   ```

## 🛠️ Troubleshooting

### Port Already in Use

```bash
mvn cargo:run -Dcargo.servlet.port=9091
```

### Build Fails

- Verify Java version: `java -version`
- Clear Maven cache: `mvn clean`
- Check internet connection for dependency download

### Styling Issues

- Make sure all CSS files are in `/static/styles/`
- Clear browser cache: Ctrl+Shift+Delete
- Check browser console for CSS errors

## 📄 License

This template is provided as-is for ecommerce website development.

---

**Built with precision. Designed for conversions. Ready for your vision.** ⌚
