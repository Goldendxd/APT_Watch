# AluGhadi Watches - Setup Instructions

## 🎯 Quick Setup Guide

### Step 1: Copy Placeholder Image

The product pages use a placeholder image (snow_leopard.png from the APT project).

**To add the placeholder:**

1. Copy `snowleopard.png` from:

   ```
   d:\Github work\APT\src\main\webapp\static\images\species_protected\snowleopard.png
   ```

2. Paste it to:

   ```
   d:\Github work\APT_Watch\src\main\webapp\static\images\
   ```

3. Rename it (optional):
   ```
   snowleopard.png → watch-placeholder.png
   ```

**Current Status:** The products.jsp file already references this image for the first product. The path is:

```jsp
${pageContext.request.contextPath}/static/images/snowleopard.png
```

### Step 2: Add More Product Images

The products.jsp currently has 6 products. To add more:

1. **Get images** from Unsplash or your own collection
2. **Save to** `/static/images/`
3. **Update product cards** in products.jsp:

```jsp
<div class="product-card" data-cat="your-category" data-id="product-id">
  <div class="prod-img-container">
    <img src="${pageContext.request.contextPath}/static/images/your-image.jpg"
         alt="Product Name" class="prod-img" />
    <!-- ... rest of card ... -->
  </div>
</div>
```

### Step 3: Build and Run

```bash
# Navigate to project
cd "d:\Github work\APT_Watch"

# Build
mvn clean package

# Run on default port 9090
mvn cargo:run

# Or run on custom port
mvn cargo:run -Dcargo.servlet.port=9000
```

Visit: `http://localhost:9090/alughadi-watches-1.0-SNAPSHOT`

### Step 4: Customize Brand & Content

Edit these files to make it your own:

**Logo & Branding:**

- Header (`/WEB-INF/views/layout/header.jsp`) - Change "⌚ AluGhadi" logo
- Footer (`/WEB-INF/views/layout/footer.jsp`) - Update company name
- CSS (`/static/styles/shared/base.css`) - Change color scheme

**Product Content:**

- Edit `/WEB-INF/views/products.jsp` - Update product names, prices, descriptions
- Edit `/WEB-INF/views/index.jsp` - Update hero text and collections

**Navigation:**

- Update links in header.jsp for Collections, About, Contact pages
- Create new JSP pages for these sections

## 📂 File Organization

```
Current Template Files:
✅ index.jsp         - Homepage (ready to use)
✅ products.jsp      - Product catalog (ready to use)
❌ collections.jsp   - Need to create
❌ about.jsp         - Need to create
❌ contact.jsp       - Need to create
```

## 🖼️ Image Sizes & Recommendations

- **Hero Image (Homepage)**: 1200x600px or larger (Unsplash works well)
- **Product Images**: 400x400px or square (better for grids)
- **Category Images**: 600x400px
- **Thumbnail Images**: 200x200px

**Format**: JPG for photos, PNG for graphics with transparency

## 🎨 Customization Checklist

- [ ] Copy snowleopard.png placeholder image
- [ ] Build project with Maven
- [ ] Run on local Tomcat
- [ ] Access at http://localhost:8080
- [ ] Change logo/branding text
- [ ] Update color scheme (CSS variables)
- [ ] Replace hero images with your own
- [ ] Update product names & prices
- [ ] Add product images
- [ ] Create additional pages (about, contact, collection)
- [ ] Set up backend database (optional)

## 💡 Frontend-Only vs Full Stack

**Current State (Frontend Only):**

- ✅ Shopping cart (localStorage only - browser memory)
- ✅ Wishlist (localStorage only - browser memory)
- ❌ No database integration
- ❌ No user accounts
- ❌ No order processing

**To Add Backend (Optional):**

1. Create Java Servlets in `src/main/java/com/alughadi/`
2. Add database dependencies to pom.xml
3. Connect JSP forms to servlet endpoints
4. Implement database logic

Example servlet files to create:

```
src/main/java/com/alughadi/
├── HomeServlet.java
├── ProductServlet.java
├── CartServlet.java
├── WishlistServlet.java
└── CheckoutServlet.java
```

## 🆘 Common Issues & Solutions

### Issue: Port 9090 already in use

**Solution:**

```bash
mvn cargo:run -Dcargo.servlet.port=9091
```

### Issue: Maven not found

**Solution:** Make sure Maven is installed and added to system PATH

```bash
mvn -version  # Check installation
```

### Issue: CSS not loading properly

**Solution:**

- Clear browser cache (Ctrl+Shift+Delete)
- Check that `/static/styles/` folder has all CSS files
- Verify file permissions

### Issue: Images not showing

**Solution:**

- Check image path in JSP: `${pageContext.request.contextPath}/static/images/filename`
- Ensure image file exists in `/static/images/`
- Verify filename matches exactly (case-sensitive on Linux)

## 📝 Next Steps

1. ✅ Template created - AluGhadi ecommerce website
2. 📋 Copy placeholder image (snowleopard.png)
3. 🎨 Customize with your branding
4. 📸 Add your own product images
5. 🔧 Optionally add backend (database, user accounts)
6. 🚀 Deploy to production

---

**Questions or running into issues?**
All template files are in `/WEB-INF/views/` and `/static/` directories.
Feel free to edit and customize everything!
