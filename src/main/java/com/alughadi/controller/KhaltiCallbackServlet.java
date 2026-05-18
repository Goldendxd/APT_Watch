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
 * GET /khalti-callback
 * Khalti redirects here after the user completes payment.
 * Verifies the transaction via Khalti lookup API, then forwards to success or fail view.
 */
@WebServlet("/khalti-callback")
public class KhaltiCallbackServlet extends HttpServlet {

    private static final String KHALTI_SECRET_KEY = "live_secret_key_68791341fdd94846a146f7b1cf9d9c47";
    private static final String LOOKUP_URL         = "https://dev.khalti.com/api/v2/epayment/lookup/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pidx          = request.getParameter("pidx");
        String status        = request.getParameter("status");
        String transactionId = request.getParameter("transaction_id");

        // Khalti sends status=Completed on success
        if (pidx == null || !"Completed".equalsIgnoreCase(status)) {
            request.setAttribute("failReason", "Payment was not completed. Status: " + status);
            request.setAttribute("pageTitle",  "Payment Failed | AluGhadi Watches");
            request.setAttribute("pageStyle",  "checkout");
            request.getRequestDispatcher("/WEB-INF/views/payment-fail.jsp").forward(request, response);
            return;
        }

        // Server-side verification via lookup
        JsonObject payload = new JsonObject();
        payload.addProperty("pidx", pidx);

        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest req = HttpRequest.newBuilder()
                    .uri(URI.create(LOOKUP_URL))
                    .header("Content-Type",  "application/json")
                    .header("Authorization", "key " + KHALTI_SECRET_KEY)
                    .POST(HttpRequest.BodyPublishers.ofString(payload.toString()))
                    .build();

            HttpResponse<String> res = client.send(req, HttpResponse.BodyHandlers.ofString());
            JsonObject json = new Gson().fromJson(res.body(), JsonObject.class);

            String verifiedStatus = json.has("status") ? json.get("status").getAsString() : "";

            if ("Completed".equalsIgnoreCase(verifiedStatus)) {
                int totalPaisa = json.has("total_amount") ? json.get("total_amount").getAsInt() : 0;

                // Clear cart after successful payment
                Object uid = request.getSession().getAttribute("authUserId");
                if (uid != null) {
                    new com.alughadi.dao.CartDaoImpl().clearCart((Integer) uid);
                }

                request.setAttribute("transactionId", transactionId != null ? transactionId : pidx);
                request.setAttribute("totalAmount",   totalPaisa / 100.0);
                request.setAttribute("pageTitle",     "Payment Successful | AluGhadi Watches");
                request.setAttribute("pageStyle",     "checkout");
                request.getRequestDispatcher("/WEB-INF/views/payment-success.jsp").forward(request, response);
            } else {
                request.setAttribute("failReason", "Payment verification failed. Status: " + verifiedStatus);
                request.setAttribute("pageTitle",  "Payment Failed | AluGhadi Watches");
                request.setAttribute("pageStyle",  "checkout");
                request.getRequestDispatcher("/WEB-INF/views/payment-fail.jsp").forward(request, response);
            }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            request.setAttribute("failReason", "Could not verify payment — please contact support.");
            request.setAttribute("pageTitle",  "Payment Error | AluGhadi Watches");
            request.setAttribute("pageStyle",  "checkout");
            request.getRequestDispatcher("/WEB-INF/views/payment-fail.jsp").forward(request, response);
        }
    }
}
