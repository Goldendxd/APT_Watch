<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
  request.setAttribute("pageTitle", "My Profile | AluGhadi Admin");
  request.setAttribute("pageDesc", "Manage your admin account details and security settings.");
  request.setAttribute("activeNav", "");
  request.setAttribute("pageStyle", "profile");
%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body">
  <div class="profile-page">

    <%-- ===== SIDEBAR ===== --%>
    <aside class="profile-sidebar">

      <%-- Avatar card --%>
      <div class="profile-card">
        <div class="profile-avatar-block">
          <div class="profile-avatar" style="${not empty profileUser.profile_image ? 'padding:0;overflow:hidden;' : ''}">
            <c:choose>
              <c:when test="${not empty profileUser.profile_image}">
                <img src="${pageContext.request.contextPath}${profileUser.profile_image}?v=${profileUser.updated_At.time}" alt="Profile" style="width:100%;height:100%;object-fit:cover;display:block;" />
              </c:when>
              <c:otherwise>
                ${fn:toUpperCase(fn:substring(profileUser.username, 0, 1))}
              </c:otherwise>
            </c:choose>
          </div>

          <form method="post" action="${pageContext.request.contextPath}/admin-profile" enctype="multipart/form-data" style="margin-top:0.6rem;">
            <input type="hidden" name="action" value="uploadAvatar" />
            <label for="avatarFile" style="display:inline-block;cursor:pointer;font-size:0.75rem;color:var(--green);font-weight:600;border:1.5px solid var(--green);border-radius:999px;padding:0.25rem 0.85rem;transition:background 0.15s;">
              Change Photo
              <input type="file" id="avatarFile" name="avatarFile" accept=".jpg,.jpeg,.png,.webp" style="display:none;" onchange="this.form.submit()" />
            </label>
          </form>
          <c:if test="${param.avatarUpdated == '1'}">
            <div style="font-size:0.72rem;color:var(--green);margin-top:0.3rem;">Photo updated!</div>
          </c:if>
          <c:if test="${not empty param.avatarError}">
            <div style="font-size:0.72rem;color:var(--red);margin-top:0.3rem;">
              <c:choose>
                <c:when test="${param.avatarError == 'type'}">Only JPG, PNG, or WEBP allowed.</c:when>
                <c:otherwise>Upload failed. Try again.</c:otherwise>
              </c:choose>
            </div>
          </c:if>

          <div class="profile-avatar-name">
            <c:choose>
              <c:when test="${not empty profileUser.full_name}">${profileUser.full_name}</c:when>
              <c:otherwise>${profileUser.username}</c:otherwise>
            </c:choose>
          </div>
          <div class="profile-avatar-user">@${profileUser.username}</div>
          <div class="profile-avatar-badge" style="color:var(--gold2);background:rgba(201,164,82,0.12);border-color:rgba(201,164,82,0.3);">&#9733; Administrator</div>
        </div>

        <nav class="profile-nav">
          <button class="profile-nav-item active" data-target="info" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            </span>
            Personal Info
          </button>
          <button class="profile-nav-item" data-target="stats" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
            </span>
            Store Overview
          </button>
          <button class="profile-nav-item" data-target="security" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            </span>
            Password &amp; Security
          </button>
        </nav>
      </div>

      <%-- Meta card --%>
      <div class="profile-card profile-meta-card">
        <div class="profile-meta-row">
          <span class="profile-meta-label">Member Since</span>
          <span class="profile-meta-val">
            <fmt:formatDate value="${profileUser.created_At}" pattern="MMM yyyy"/>
          </span>
        </div>
        <div class="profile-meta-row">
          <span class="profile-meta-label">Total Orders</span>
          <span class="profile-meta-val">${totalOrders}</span>
        </div>
        <div class="profile-meta-row">
          <span class="profile-meta-label">Role</span>
          <span class="profile-meta-val" style="color:var(--gold2);">Administrator</span>
        </div>
        <div class="profile-meta-row">
          <span class="profile-meta-label">Account Status</span>
          <span class="profile-meta-val" style="color:var(--green);">Active</span>
        </div>
      </div>

      <div style="text-align:center;margin-top:0.5rem;">
        <a href="${pageContext.request.contextPath}/admin"
           class="pf-btn pf-btn-primary"
           style="display:inline-block;text-decoration:none;font-size:0.8rem;padding:0.55rem 1.25rem;">
          &#8592; Back to Dashboard
        </a>
      </div>

    </aside>

    <%-- ===== MAIN ===== --%>
    <main class="profile-main">

      <%-- ---- PERSONAL INFO PANEL ---- --%>
      <div class="profile-panel active" data-panel="info">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Personal Information</div>
            <div class="profile-panel-sub">Update your admin account details.</div>
          </div>
        </div>
        <div class="profile-panel-body">

          <c:if test="${not empty param.updated}">
            <div class="pf-alert pf-alert-success">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
              Profile updated successfully.
            </div>
          </c:if>
          <c:if test="${not empty profileError}">
            <div class="pf-alert pf-alert-error">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
              ${profileError}
            </div>
          </c:if>

          <form method="post" action="${pageContext.request.contextPath}/admin-profile">
            <input type="hidden" name="action" value="updateProfile" />

            <div class="pf-row">
              <div class="fg">
                <label for="pf-username">Username</label>
                <input id="pf-username" type="text" value="${profileUser.username}" readonly />
              </div>
              <div class="fg">
                <label for="pf-email">Email Address</label>
                <input id="pf-email" name="email" type="email" value="${profileUser.email}" placeholder="admin@example.com" />
              </div>
            </div>

            <div class="pf-row">
              <div class="fg">
                <label for="pf-fullname">Full Name</label>
                <input id="pf-fullname" name="fullName" type="text" value="${profileUser.full_name}" placeholder="Full name" />
              </div>
              <div class="fg">
                <label for="pf-phone">Phone Number</label>
                <input id="pf-phone" name="phone" type="tel" value="${profileUser.phone}" placeholder="98XXXXXXXX" />
              </div>
            </div>

            <div class="pf-row">
              <div class="fg">
                <label for="pf-gender">Gender</label>
                <select id="pf-gender" name="gender">
                  <option value="">Select gender</option>
                  <option value="Male"   ${profileUser.gender == 'Male'   ? 'selected' : ''}>Male</option>
                  <option value="Female" ${profileUser.gender == 'Female' ? 'selected' : ''}>Female</option>
                  <option value="Other"  ${profileUser.gender == 'Other'  ? 'selected' : ''}>Other</option>
                </select>
              </div>
              <div class="fg">
                <label for="pf-city">City</label>
                <input id="pf-city" name="city" type="text" value="${profileUser.city}" placeholder="Pokhara" />
              </div>
            </div>

            <div class="pf-save-row">
              <button type="submit" class="pf-btn pf-btn-primary">Save Changes</button>
            </div>
          </form>
        </div>
      </div>

      <%-- ---- STORE OVERVIEW PANEL ---- --%>
      <div class="profile-panel" data-panel="stats">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Store Overview</div>
            <div class="profile-panel-sub">Key metrics for the AluGhadi platform.</div>
          </div>
        </div>
        <div class="profile-panel-body">
          <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:1rem;margin-bottom:1.5rem;">
            <div style="background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:16px;padding:1.5rem 1.25rem;text-align:center;">
              <div style="font-size:1.7rem;font-weight:900;color:var(--green);letter-spacing:-0.04em;margin-bottom:0.25rem;">
                Rs <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
              </div>
              <div style="font-size:0.7rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:0.06em;">Total Revenue</div>
            </div>
            <div style="background:var(--surface);border:1.5px solid var(--border);border-radius:16px;padding:1.5rem 1.25rem;text-align:center;">
              <div style="font-size:1.7rem;font-weight:900;color:var(--text);letter-spacing:-0.04em;margin-bottom:0.25rem;">${totalOrders}</div>
              <div style="font-size:0.7rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:0.06em;">Total Orders</div>
            </div>
            <div style="background:rgba(201,164,82,0.08);border:1.5px solid rgba(201,164,82,0.3);border-radius:16px;padding:1.5rem 1.25rem;text-align:center;">
              <div style="font-size:1.7rem;font-weight:900;color:var(--gold2);letter-spacing:-0.04em;margin-bottom:0.25rem;">Admin</div>
              <div style="font-size:0.7rem;font-weight:700;color:var(--muted);text-transform:uppercase;letter-spacing:0.06em;">Account Role</div>
            </div>
          </div>
          <div style="background:var(--surface);border:1.5px solid var(--border);border-radius:14px;padding:1.25rem 1.5rem;">
            <div style="font-size:0.78rem;font-weight:700;color:var(--text);margin-bottom:0.75rem;">Quick Links</div>
            <div style="display:flex;flex-wrap:wrap;gap:0.6rem;">
              <a href="${pageContext.request.contextPath}/admin" style="padding:0.45rem 1rem;background:var(--green-light);border:1.5px solid var(--green-mid);border-radius:999px;font-size:0.78rem;font-weight:600;color:var(--green);text-decoration:none;">Dashboard</a>
              <a href="${pageContext.request.contextPath}/admin#products" style="padding:0.45rem 1rem;background:var(--white);border:1.5px solid var(--border);border-radius:999px;font-size:0.78rem;font-weight:600;color:var(--text);text-decoration:none;">Manage Products</a>
              <a href="${pageContext.request.contextPath}/products" style="padding:0.45rem 1rem;background:var(--white);border:1.5px solid var(--border);border-radius:999px;font-size:0.78rem;font-weight:600;color:var(--text);text-decoration:none;">View Shop</a>
            </div>
          </div>
        </div>
      </div>

      <%-- ---- SECURITY PANEL ---- --%>
      <div class="profile-panel" data-panel="security">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Password &amp; Security</div>
            <div class="profile-panel-sub">Change your administrator password.</div>
          </div>
        </div>
        <div class="profile-panel-body">

          <c:if test="${not empty param.pwChanged}">
            <div class="pf-alert pf-alert-success">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><polyline points="20 6 9 17 4 12"/></svg>
              Password changed successfully.
            </div>
          </c:if>
          <c:if test="${not empty pwError}">
            <div class="pf-alert pf-alert-error">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
              ${pwError}
            </div>
          </c:if>

          <form method="post" action="${pageContext.request.contextPath}/admin-profile" style="max-width:460px;">
            <input type="hidden" name="action" value="changePassword" />
            <div class="pf-row single">
              <div class="fg">
                <label for="pw-current">Current Password</label>
                <input id="pw-current" name="currentPassword" type="password" placeholder="Enter current password" required />
              </div>
            </div>
            <div class="pf-row single">
              <div class="fg">
                <label for="pw-new">New Password</label>
                <input id="pw-new" name="newPassword" type="password" placeholder="Min. 8 characters" required />
              </div>
            </div>
            <div class="pf-row single">
              <div class="fg">
                <label for="pw-confirm">Confirm New Password</label>
                <input id="pw-confirm" name="confirmPassword" type="password" placeholder="Repeat new password" required />
              </div>
            </div>
            <div class="pf-save-row">
              <button type="submit" class="pf-btn pf-btn-primary">Change Password</button>
            </div>
          </form>
        </div>
      </div>

    </main>
  </div>
</div>

<script>
  function switchPanel(btn) {
    document.querySelectorAll('.profile-nav-item').forEach(function(b) { b.classList.remove('active'); });
    document.querySelectorAll('.profile-panel[data-panel]').forEach(function(p) { p.classList.remove('active'); });
    btn.classList.add('active');
    var target = document.querySelector('.profile-panel[data-panel="' + btn.dataset.target + '"]');
    if (target) target.classList.add('active');
  }

  (function() {
    var params = new URLSearchParams(window.location.search);
    if (params.has('pwChanged')) {
      var btn = document.querySelector('.profile-nav-item[data-target="security"]');
      if (btn) switchPanel(btn);
    }
  })();
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
