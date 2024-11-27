package controller;

import dal.VegetableDAO;
import entities.Vegetable;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet(name = "AddVegetableServlet", urlPatterns = {"/addVegetable"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1 MB
    maxFileSize = 1024 * 1024 * 10,      // 10 MB
    maxRequestSize = 1024 * 1024 * 15   // 15 MB
)
public class AddVegetable extends HttpServlet {

    private VegetableDAO vDao = new VegetableDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Lấy dữ liệu từ form
            String name = request.getParameter("name");
            float price = Float.parseFloat(request.getParameter("price"));
            String description = request.getParameter("description");
            boolean status = request.getParameter("status") != null;
            
            // Tạo đối tượng Vegetable trước
            Vegetable vegetable = new Vegetable();
            vegetable.setName(name);
            vegetable.setPrice(price);
            vegetable.setDescription(description);
            vegetable.setStatus(status);
            
            // Xử lý file upload
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String fileName = UUID.randomUUID().toString() + fileExtension;
                
                String uploadPath = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                
                // Set đường dẫn ảnh cho vegetable
                vegetable.setImgSrc("uploads/" + fileName);
            }
            
            // Thêm vào database
            boolean success = vDao.insertVegetable(vegetable);
            
            if (success) {
                response.sendRedirect("LoadAllVegetables");
            } else {
                request.setAttribute("error", "Không thể thêm sản phẩm");
                request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage()); // Thêm log
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
        }
    }
}
