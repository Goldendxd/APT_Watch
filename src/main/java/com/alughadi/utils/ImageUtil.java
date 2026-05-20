package com.alughadi.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

/**
 * ImageUtil — handles product image uploads.
 *
 * uploadImage(imagePart, servletContext):
 *   1. Get the original filename from the uploaded Part.
 *   2. Check the extension — only .jpg, .jpeg, .png, .webp are allowed.
 *      Returns null if the file type is invalid (caller shows an error).
 *   3. Generate a unique filename using the current timestamp + original name
 *      to avoid collisions.
 *   4. Save the file to TWO places:
 *      a) The deployed Tomcat path  (so the image works immediately in the browser)
 *      b) src/main/webapp/static/images/products/ (so it survives a project rebuild)
 *   5. Return the web-relative path (/static/images/products/filename) to store in the DB.
 */
public class ImageUtil {
    private static final String REL_PATH = "src/main/webapp/static/images/products/";

    public static String uploadImage(Part imagePart, ServletContext servletContext){
        String fileName = imagePart.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()){
            return null;
        }
        String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".png") && !extension.equals(".webp")){
            return null;
        }
        String newFileName = System.currentTimeMillis() + "_" + fileName;

        // Save to the deployed runtime path so the image is immediately accessible
        String deployedPath = servletContext.getRealPath("/static/images/products/");
        File deployedDir = new File(deployedPath);
        if (!deployedDir.exists()) deployedDir.mkdirs();

        // Also save to src/main/webapp so the image persists across rebuilds (dev mode)
        File sourceDir = new File(System.getProperty("user.dir"), REL_PATH);
        if (!sourceDir.exists()) sourceDir.mkdirs();

        try {
            File destDeployed = new File(deployedDir, newFileName);
            imagePart.write(destDeployed.getAbsolutePath());

            File destSource = new File(sourceDir, newFileName);
            if (!destSource.exists()) {
                java.nio.file.Files.copy(destDeployed.toPath(), destSource.toPath());
            }

            return "/static/images/products/" + newFileName;
        } catch (IOException e) {
            System.out.println("Could not save image '" + fileName + "': " + e.getMessage());
            return null;
        }
    }
}
