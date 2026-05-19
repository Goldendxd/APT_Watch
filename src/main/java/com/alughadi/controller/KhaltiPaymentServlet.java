package com.alughadi.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

/**
 * POST /khalti-pay
 * Receives shipping details + grand total from checkout form,
 * initiates a Khalti e-payment, and redirects the user to Khalti's hosted page.
 */
@WebServlet("/khalti-pay")
public class KhaltiPaymentServlet extends HttpServlet {

    private static final String KHALTI_SECRET_KEY = "live_secret_key_68791341fdd94846a146f7b1cf9d9c47";
    private static final String INITIATE_URL       = "https://dev.khalti.com/api/v2/epayment/initiate/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Grab shipping fields for customer_info
        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String email    = request.getParameter("email");

        // Amount comes from checkout as paisa (grandTotal * 100)
        String amountPaisa = request.getParameter("amountPaisa");

        String baseUrl   = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String returnUrl = baseUrl + request.getContextPath() + "/khalti-callback";
        String websiteUrl = baseUrl + request.getContextPath() + "/";

        // Build JSON payload
        JsonObject customerInfo = new JsonObject();
        customerInfo.addProperty("name",  fullName != null ? fullName : "Customer");
        customerInfo.addProperty("email", email    != null ? email    : "");
        customerInfo.addProperty("phone", phone    != null ? phone    : "");

        JsonObject payload = new JsonObject();
        payload.addProperty("return_url",           returnUrl);
        payload.addProperty("website_url",          websiteUrl);
        payload.addProperty("amount",               amountPaisa);
        payload.addProperty("purchase_order_id",    "AG-" + System.currentTimeMillis());
        payload.addProperty("purchase_order_name",  "AluGhadi Watch Order");
        payload.add("customer_info",                customerInfo);

        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest req = HttpRequest.newBuilder()
                    .uri(URI.create(INITIATE_URL))
                    .header("Content-Type",  "application/json")
                    .header("Authorization", "key " + KHALTI_SECRET_KEY)
                    .POST(HttpRequest.BodyPublishers.ofString(payload.toString()))
                    .build();

            HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());

            System.out.println("[Khalti Initiate] HTTP " + res.statusCode() + " | " + res.body());

            if (res.statusCode() == 200) {
                JsonObject json = new Gson().fromJson(res.body(), JsonObject.class);
                String paymentUrl = json.get("payment_url").getAsString();
                response.sendRedirect(paymentUrl);
            } else {
                String detail = res.body();
                try {
                    JsonObject err = new Gson().fromJson(res.body(), JsonObject.class);
                    if (err.has("detail")) detail = err.get("detail").getAsString();
                } catch (Exception ignored) {}
                request.setAttribute("payError", "Khalti error (HTTP " + res.statusCode() + "): " + detail);
                request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            request.setAttribute("payError", "Payment service unavailable. Please try Cash on Delivery.");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        }
    }
}
