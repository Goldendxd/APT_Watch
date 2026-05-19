<%@ page contentType="text/html;charset=UTF-8" language="java" %><%
  request.setAttribute("pageTitle", "Contact Us | AluGhadi");
  request.setAttribute("pageDesc", "Get in touch with AluGhadi — Nepal's premium watch destination. Ask about products, orders, partnerships or anything else.");
  request.setAttribute("activeNav", "contact");
  request.setAttribute("pageStyle", "contact");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<jsp:include page="/WEB-INF/views/layout/head.jsp" />

<%-- ======== PAGE HERO ======== --%>
<section class="page-hero contact-hero">
  <div class="ph-img">
    <img src="${pageContext.request.contextPath}/static/images/hero_contact.png"
         alt="AluGhadi Watch Boutique"
         style="object-position: center;" />
  </div>
  <div class="ph-ov"></div>
  <div class="ph-body">
    <span class="ph-chip">Reach Us</span>
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
      <div class="cis-ico">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
      </div>
      <div>
        <div class="cis-label">Our Location</div>
        <div class="cis-val">Pokhara, Nepal</div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 1.11h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8 8.09a16 16 0 0 0 6 6l.77-.77a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21.73 16z"/></svg>
      </div>
      <div>
        <div class="cis-label">Phone</div>
        <div class="cis-val"><a href="tel:+977XXXXXXXX">+977-1-XXXX-XXXX</a></div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
      </div>
      <div>
        <div class="cis-label">Email</div>
        <div class="cis-val"><a href="mailto:support@alughadi.com">support@alughadi.com</a></div>
      </div>
    </div>
    <div class="cis-divider"></div>
    <div class="cis-item">
      <div class="cis-ico">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
      </div>
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
                  <span class="input-ico-l">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                  </span>
                  <input type="text" id="cf-name" name="name" class="input-pl"
                         placeholder="Shisir Lamsal" required autocomplete="name" />
                </div>
              </div>
              <div class="fg">
                <label for="cf-email">Email Address *</label>
                <div class="input-wrap">
                  <span class="input-ico-l">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                  </span>
                  <input type="email" id="cf-email" name="email" class="input-pl"
                         placeholder="you@example.com" required autocomplete="email" />
                </div>
              </div>
            </div>

            <div class="fg-row">
              <div class="fg">
                <label for="cf-phone">Phone (optional)</label>
                <div class="input-wrap">
                  <span class="input-ico-l">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 1.11h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8 8.09a16 16 0 0 0 6 6l.77-.77a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21.73 16z"/></svg>
                  </span>
                  <input type="tel" id="cf-phone" name="phone" class="input-pl"
                         placeholder="+977-98XX-XXXXXX" autocomplete="tel" />
                </div>
              </div>
              <div class="fg">
                <label for="cf-subject">Subject *</label>
                <select id="cf-subject" name="subject" required>
                  <option value="" disabled selected>Select a topic...</option>
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
              <div class="fg-note">We'll never share your details with third parties.</div>
            </div>

            <div class="contact-form-foot">
              <button type="submit" class="btn btn-g btn-lg" id="cf-submit-btn">
                <span id="cf-btn-text">Send Message</span>
              </button>
              <p class="contact-form-note">Typical reply time: under 24 hours</p>
            </div>

          </form>

          <div id="cf-success" class="info-banner" style="display:none;margin-top:1.5rem;">
            <div class="ib-ico">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div>
              <div class="ib-h">Message Sent!</div>
              <div class="ib-p">Thank you for reaching out. We'll be in touch within one business day.</div>
            </div>
          </div>
          <div id="cf-error" class="info-banner error-banner" style="display:none;margin-top:1.5rem;">
            <div class="ib-ico">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            </div>
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
          <div class="csc-ico" style="background:var(--green-light);color:var(--green);">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
          </div>
          <div>
            <div class="csc-h">Visit Our Store</div>
            <p class="csc-p">
              Lakeside, Baidam, Pokhara<br />
              Ground Floor, Timepiece Plaza<br />
              Open Sun – Fri, 9 AM – 6 PM
            </p>
          </div>
        </div>

        <div class="contact-side-card">
          <div class="csc-ico" style="background:var(--gold-light);color:var(--gold2);">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 1.11h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8 8.09a16 16 0 0 0 6 6l.77-.77a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 21.73 16z"/></svg>
          </div>
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
          <div class="csc-ico" style="background:#eff6ff;color:#1e40af;">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
          </div>
          <div>
            <div class="csc-h">Returns &amp; Warranty</div>
            <p class="csc-p">
              Hassle-free 7-day returns on all<br />
              orders. All watches come with a<br />
              minimum 1-year service warranty.
            </p>
          </div>
        </div>

        <div class="contact-socials">
          <div class="csc-h" style="margin-bottom:0.8rem;">Follow Us</div>
          <div class="contact-social-links">
            <a href="#" class="contact-social-btn" aria-label="Facebook">Facebook</a>
            <a href="#" class="contact-social-btn" aria-label="Instagram">Instagram</a>
            <a href="#" class="contact-social-btn" aria-label="TikTok">TikTok</a>
          </div>
        </div>

      </div>

    </div>
  </div>
</section>

<script>
  function handleContactSubmit(e) {
    e.preventDefault();
    var btn  = document.getElementById('cf-submit-btn');
    var txt  = document.getElementById('cf-btn-text');
    var form = document.getElementById('contact-form');

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

    btn.disabled = true;
    txt.textContent = 'Sending...';

    setTimeout(function () {
      btn.disabled = false;
      txt.textContent = 'Send Message';
      form.reset();
      var ok = document.getElementById('cf-success');
      ok.style.display = 'flex';
      setTimeout(function(){ ok.style.display = 'none'; }, 6000);
    }, 1800);
  }
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
