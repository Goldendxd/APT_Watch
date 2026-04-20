<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
  request.setAttribute("pageTitle", "Contact Us | AluGhadi");
  request.setAttribute("pageDesc", "Get in touch with AluGhadi — Nepal's premium watch destination. Ask about products, orders, partnerships or anything else.");
  request.setAttribute("activeNav", "contact");
  request.setAttribute("pageStyle", "contact");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<%-- ======== PAGE HERO ======== --%>
<section class="page-hero contact-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/alughadiweblogo.png"
         alt="Contact AluGhadi"
         style="filter: blur(1px) brightness(0.3);" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <span class="ph-chip">&#9993; Reach Us</span>
    <h1 class="ph-h">We'd love to <span>hear</span><br>from you.</h1>
    <p class="ph-sub">
      Whether you have a question about a watch, an order, or a partnership —
      our team is ready to help.
    </p>
  </div>
</section>

<%-- ======== CONTACT INFO STRIP ======== --%>
<div class="contact-info-strip">
  <div class="cis-inner">
    <div class="cis-item">
      <div class="cis-ico">&#128205;</div>
      <div>
        <div class="cis-label">Our Location</div>
        <div class="cis-val">Kathmandu, Nepal</div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">&#128222;</div>
      <div>
        <div class="cis-label">Phone</div>
        <div class="cis-val"><a href="tel:+977XXXXXXXX">+977-1-XXXX-XXXX</a></div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">&#128140;</div>
      <div>
        <div class="cis-label">Email</div>
        <div class="cis-val"><a href="mailto:support@alughadi.com">support@alughadi.com</a></div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">&#128336;</div>
      <div>
        <div class="cis-label">Business Hours</div>
        <div class="cis-val">Sun – Fri &nbsp;9 AM – 6 PM</div>
      </div>
    </div>
  </div>
</div>

<%-- ======== MAIN CONTENT: FORM + SIDE INFO ======== --%>
<section class="sec">
  <div class="sec-inner">
    <div class="contact-layout">

      <%-- LEFT: Contact Form --%>
      <div class="contact-form-wrap reveal">
        <div class="gc">
          <div class="gc-tag">Send a Message</div>
          <h2 class="gc-h">Drop us a line</h2>
          <p class="gc-sub">Fill in the form and we'll get back to you within one business day.</p>

          <form id="contact-form" class="contact-form" onsubmit="handleContactSubmit(event)" novalidate>

            <div class="fg-row">
              <div class="fg">
                <label for="cf-name">Full Name *</label>
                <div class="input-wrap">
                  <span class="input-ico-l">&#128100;</span>
                  <input type="text" id="cf-name" name="name" class="input-pl"
                         placeholder="Shisir Lamsal" required autocomplete="name" />
                </div>
              </div>
              <div class="fg">
                <label for="cf-email">Email Address *</label>
                <div class="input-wrap">
                  <span class="input-ico-l">&#64;</span>
                  <input type="email" id="cf-email" name="email" class="input-pl"
                         placeholder="you@example.com" required autocomplete="email" />
                </div>
              </div>
            </div>

            <div class="fg-row">
              <div class="fg">
                <label for="cf-phone">Phone (optional)</label>
                <div class="input-wrap">
                  <span class="input-ico-l">&#128222;</span>
                  <input type="tel" id="cf-phone" name="phone" class="input-pl"
                         placeholder="+977-98XX-XXXXXX" autocomplete="tel" />
                </div>
              </div>
              <div class="fg">
                <label for="cf-subject">Subject *</label>
                <select id="cf-subject" name="subject" required>
                  <option value="" disabled selected>Select a topic…</option>
                  <option value="product-query">Product Enquiry</option>
                  <option value="order-support">Order Support</option>
                  <option value="returns">Returns &amp; Warranty</option>
                  <option value="partnership">Partnership / Wholesale</option>
                  <option value="general">General Question</option>
                </select>
              </div>
            </div>

            <div class="fg">
              <label for="cf-message">Your Message *</label>
              <textarea id="cf-message" name="message" rows="6"
                        placeholder="Tell us what's on your mind — we read every message carefully." required></textarea>
              <div class="fg-note">&#9432;&nbsp; We'll never share your details with third parties.</div>
            </div>

            <div class="contact-form-foot">
              <button type="submit" class="btn btn-g btn-lg" id="cf-submit-btn">
                <span id="cf-btn-text">&#9993; Send Message</span>
              </button>
              <p class="contact-form-note">Typical reply time: &lt; 24 hours</p>
            </div>

          </form>

          <%-- Success / Error feedback --%>
          <div id="cf-success" class="info-banner" style="display:none;margin-top:1.5rem;">
            <div class="ib-ico">&#10003;</div>
            <div>
              <div class="ib-h">Message Sent!</div>
              <div class="ib-p">Thank you for reaching out. We'll be in touch within one business day.</div>
            </div>
          </div>
          <div id="cf-error" class="info-banner error-banner" style="display:none;margin-top:1.5rem;">
            <div class="ib-ico">&#9888;</div>
            <div>
              <div class="ib-h">Something went wrong</div>
              <div class="ib-p">Please check your inputs and try again.</div>
            </div>
          </div>

        </div>
      </div>

      <%-- RIGHT: Info Cards --%>
      <div class="contact-side reveal reveal-delay-2">

        <div class="contact-side-card">
          <div class="csc-ico" style="background:var(--green-light);color:var(--green);">&#128205;</div>
          <div>
            <div class="csc-h">Visit Our Store</div>
            <p class="csc-p">
              Asan Chowk, Kathmandu<br />
              Ground Floor, Timepiece Plaza<br />
              Open Sun – Fri, 9 AM – 6 PM
            </p>
          </div>
        </div>

        <div class="contact-side-card">
          <div class="csc-ico" style="background:var(--gold-light);color:var(--gold2);">&#128171;</div>
          <div>
            <div class="csc-h">Customer Support</div>
            <p class="csc-p">
              Our watch experts are available on<br />
              chat, phone and email. Average<br />
              response time is under 2 hours.
            </p>
          </div>
        </div>

        <div class="contact-side-card">
          <div class="csc-ico" style="background:#eff6ff;color:#1e40af;">&#128230;</div>
          <div>
            <div class="csc-h">Returns &amp; Warranty</div>
            <p class="csc-p">
              Hassle-free 7-day returns on all<br />
              orders. All watches come with a<br />
              minimum 1-year service warranty.
            </p>
          </div>
        </div>

        <%-- Social links --%>
        <div class="contact-socials">
          <div class="csc-h" style="margin-bottom:0.8rem;">Follow Us</div>
          <div class="contact-social-links">
            <a href="#" class="contact-social-btn" aria-label="Facebook">&#128526; Facebook</a>
            <a href="#" class="contact-social-btn" aria-label="Instagram">&#128247; Instagram</a>
            <a href="#" class="contact-social-btn" aria-label="TikTok">&#127926; TikTok</a>
          </div>
        </div>

      </div>

    </div>
  </div>
</section>

<%-- ======== CONTACT FORM SCRIPT ======== --%>
<script>
  function handleContactSubmit(e) {
    e.preventDefault();
    var btn  = document.getElementById('cf-submit-btn');
    var txt  = document.getElementById('cf-btn-text');
    var form = document.getElementById('contact-form');

    /* basic validation */
    var name    = document.getElementById('cf-name').value.trim();
    var email   = document.getElementById('cf-email').value.trim();
    var subject = document.getElementById('cf-subject').value;
    var message = document.getElementById('cf-message').value.trim();

    if (!name || !email || !subject || !message) {
      var errEl = document.getElementById('cf-error');
      errEl.style.display = 'flex';
      setTimeout(function(){ errEl.style.display = 'none'; }, 4000);
      return;
    }

    /* loading state */
    btn.disabled = true;
    txt.textContent = '&#8987; Sending…';

    /* simulate async send — replace with real fetch() later */
    setTimeout(function () {
      btn.disabled = false;
      txt.textContent = '&#9993; Send Message';
      form.reset();
      var ok = document.getElementById('cf-success');
      ok.style.display = 'flex';
      setTimeout(function(){ ok.style.display = 'none'; }, 6000);
    }, 1800);
  }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
