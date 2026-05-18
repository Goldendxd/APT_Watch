package com.alughadi.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

public class ImageUtil {
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
        String uploadPath = servletContext.getRealPath("/static/images/products/"); // configurable
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()){
            uploadDir.mkdirs();
        }
        try{
            imagePart.write(uploadPath + File.separator + newFileName);

            return  "/static/images/products/" + newFileName;
        } catch (IOException e) {
            System.out.println("Could not save image '" + fileName +
                    "'. Please ensure the server's image folder exists and has write permissions.");
            return null;
        }
    }
}
