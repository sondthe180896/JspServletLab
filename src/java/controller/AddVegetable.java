package controller;

import dal.VegetableDAO;
import entities.Vegetable;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
//import format.DescriptionFormatter;

@WebServlet(name = "AddVegetableServlet", urlPatterns = {"/addVegetable"})
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
            String imgSrc = request.getParameter("imgSrc");
            boolean status = request.getParameter("status") != null;
            
            // Tạo đối tượng Vegetable mới
            Vegetable vegetable = new Vegetable();
            vegetable.setName(name);
            vegetable.setPrice(price);
            vegetable.setDescription(description);
            vegetable.setImgSrc(imgSrc);
            vegetable.setStatus(status);
            
            // Thêm vào database
            boolean success = vDao.insertVegetable(vegetable);
            
            if (success) {
                response.sendRedirect("LoadAllVegetables");
            } else {
                request.setAttribute("error", "Không thể thêm sản phẩm");
                request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá không hợp lệ");
            request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("addVegetable.jsp").forward(request, response);
        }
    }
}