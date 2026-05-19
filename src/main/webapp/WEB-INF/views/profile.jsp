<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="pg-body">
  <div class="profile-page">

    <%-- ===== SIDEBAR ===== --%>
    <aside class="profile-sidebar">

      <%-- Avatar card --%>
      <div class="profile-card">
        <div class="profile-avatar-block">
          <div class="profile-avatar">
            ${fn:toUpperCase(fn:substring(profileUser.username, 0, 1))}
          </div>
          <div class="profile-avatar-name">
            <c:choose>
              <c:when test="${not empty profileUser.full_name}">${profileUser.full_name}</c:when>
              <c:otherwise>${profileUser.username}</c:otherwise>
            </c:choose>
          </div>
          <div class="profile-avatar-user">@${profileUser.username}</div>
          <div class="profile-avatar-badge">&#9679; Customer</div>
        </div>

        <nav class="profile-nav">
          <button class="profile-nav-item active" data-target="info" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            </span>
            Personal Info
          </button>
          <button class="profile-nav-item" data-target="orders" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            </span>
            Order History
            <c:if test="${not empty userOrders}">
              <span style="margin-left:auto;background:var(--green);color:#fff;font-size:0.6rem;padding:0.1rem 0.45rem;border-radius:999px;">${fn:length(userOrders)}</span>
            </c:if>
          </button>
          <button class="profile-nav-item" data-target="security" onclick="switchPanel(this)">
            <span class="profile-nav-ico">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            </span>
            Password & Security
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
          <span class="profile-meta-val">${fn:length(userOrders)}</span>
        </div>
        <div class="profile-meta-row">
          <span class="profile-meta-label">Account Status</span>
          <span class="profile-meta-val" style="color:var(--green);">Active</span>
        </div>
      </div>

    </aside>

    <%-- ===== MAIN ===== --%>
    <main class="profile-main">

      <%-- ---- PERSONAL INFO PANEL ---- --%>
      <div class="profile-panel active" data-panel="info">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Personal Information</div>
            <div class="profile-panel-sub">Update your name, contact details, and address.</div>
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

          <form method="post" action="${pageContext.request.contextPath}/profile">
            <input type="hidden" name="action" value="updateProfile" />

            <div class="pf-row">
              <div class="fg">
                <label for="pf-username">Username</label>
                <input id="pf-username" type="text" value="${profileUser.username}" readonly />
              </div>
              <div class="fg">
                <label for="pf-email">Email Address</label>
                <input id="pf-email" name="email" type="email" value="${profileUser.email}" placeholder="you@example.com" />
              </div>
            </div>

            <div class="pf-row">
              <div class="fg">
                <label for="pf-fullname">Full Name</label>
                <input id="pf-fullname" name="fullName" type="text" value="${profileUser.full_name}" placeholder="Ram Bahadur Shrestha" />
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
                <label for="pf-dob">Date of Birth</label>
                <input id="pf-dob" name="dateOfBirth" type="date"
                  value="<c:if test='${not empty profileUser.date_of_birth}'><fmt:formatDate value='${profileUser.date_of_birth}' pattern='yyyy-MM-dd'/></c:if>" />
              </div>
            </div>

            <div class="pf-row single">
              <div class="fg">
                <label for="pf-address">Street Address</label>
                <input id="pf-address" name="address" type="text" value="${profileUser.address}" placeholder="Thamel, Ward 26" />
              </div>
            </div>

            <div class="pf-row triple">
              <div class="fg">
                <label for="pf-city">City</label>
                <input id="pf-city" name="city" type="text" value="${profileUser.city}" placeholder="Kathmandu" />
              </div>
              <div class="fg">
                <label for="pf-province">Province</label>
                <input id="pf-province" name="province" type="text" value="${profileUser.province}" placeholder="Bagmati" />
              </div>
              <div class="fg">
                <label for="pf-district">District</label>
                <input id="pf-district" name="district" type="text" value="${profileUser.district}" placeholder="Kathmandu" />
              </div>
            </div>

            <div class="pf-save-row">
              <button type="submit" class="pf-btn pf-btn-primary">Save Changes</button>
            </div>
          </form>
        </div>
      </div>

      <%-- ---- ORDER HISTORY PANEL ---- --%>
      <div class="profile-panel" data-panel="orders">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Order History</div>
            <div class="profile-panel-sub">All your past purchases.</div>
          </div>
        </div>
        <div class="profile-panel-body">
          <c:choose>
            <c:when test="${empty userOrders}">
              <div class="order-empty">
                <div class="order-empty-ico">&#128717;</div>
                <div class="order-empty-h">No orders yet</div>
                <div class="order-empty-p">Your order history will appear here once you make a purchase.</div>
              </div>
            </c:when>
            <c:otherwise>
              <div class="order-list">
                <c:forEach var="order" items="${userOrders}">
                  <div class="order-card">
                    <div class="order-card-head">
                      <div>
                        <div class="order-id">Order #${order.id}</div>
                        <div class="order-date"><fmt:formatDate value="${order.createdAt}" pattern="dd MMM yyyy, hh:mm a"/></div>
                      </div>
                      <c:choose>
                        <c:when test="${order.orderStatus == 'delivered'}">
                          <span class="order-status-badge order-status-delivered">Delivered</span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'processing'}">
                          <span class="order-status-badge order-status-processing">Processing</span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'cancelled'}">
                          <span class="order-status-badge order-status-cancelled">Cancelled</span>
                        </c:when>
                        <c:otherwise>
                          <span class="order-status-badge order-status-pending">${order.orderStatus}</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="order-card-body">
                      <div class="order-products">
                        <div class="order-products-label">Items (${order.totalItems})</div>
                        ${order.productNames}
                      </div>
                      <div class="order-meta">
                        <div class="order-meta-item">
                          <div class="order-meta-label">Payment</div>
                          <span class="order-pay-method">${fn:toUpperCase(order.paymentMethod)}</span>
                        </div>
                        <div class="order-meta-item">
                          <div class="order-meta-label">Total</div>
                          <div class="order-meta-val order-total-val">
                            Rs <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <%-- ---- SECURITY PANEL ---- --%>
      <div class="profile-panel" data-panel="security">
        <div class="profile-panel-head">
          <div>
            <div class="profile-panel-title">Password &amp; Security</div>
            <div class="profile-panel-sub">Change your password to keep your account secure.</div>
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

          <form method="post" action="${pageContext.request.contextPath}/profile" style="max-width:460px;">
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

  // Auto-open correct panel from URL hash or query param
  (function () {
    var hash = window.location.hash.replace('#', '');
    var params = new URLSearchParams(window.location.search);
    var panel = hash || (params.has('pwChanged') ? 'security' : null);
    if (panel) {
      var btn = document.querySelector('.profile-nav-item[data-target="' + panel + '"]');
      if (btn) switchPanel(btn);
    }
  })();
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
