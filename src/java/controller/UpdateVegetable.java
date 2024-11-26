package controller;

import dal.VegetableDAO;
import entities.Vegetable;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateVegetableServlet", urlPatterns = {"/updateVegetable"})
public class UpdateVegetable extends HttpServlet {
    
    private VegetableDAO vDao = new VegetableDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Vegetable vegetable = vDao.getVegetableById(id);
            
            if (vegetable != null) {
                request.setAttribute("vegetable", vegetable);
                request.getRequestDispatcher("updateVegetable.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Lấy dữ liệu từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            float price = Float.parseFloat(request.getParameter("price"));
            String description = request.getParameter("description");
            String imgSrc = request.getParameter("imgSrc");
            boolean status = request.getParameter("status") != null;
            
            // Tạo đối tượng Vegetable
            Vegetable vegetable = new Vegetable();
            vegetable.setId(id);
            vegetable.setName(name);
            vegetable.setPrice(price);
            vegetable.setDescription(description);
            vegetable.setImgSrc(imgSrc);
            vegetable.setStatus(status);
            
            // Cập nhật vào database
            boolean success = vDao.updateVegetable(vegetable);
            
            if (success) {
                response.sendRedirect("ViewDetails?id=" + id);
            } else {
                request.setAttribute("error", "Không thể cập nhật sản phẩm");
                request.setAttribute("vegetable", vegetable);
                request.getRequestDispatcher("updateVegetable.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            request.getRequestDispatcher("updateVegetable.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("updateVegetable.jsp").forward(request, response);
        }
    }
}