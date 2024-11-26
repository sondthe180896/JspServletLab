/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.VegetableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
public class DeleteVegetable extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        VegetableDAO vDao = new VegetableDAO();
         try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Thực hiện xóa
            boolean success = vDao.deleteVegetable(id);
            
            if (success) {
                request.getSession().setAttribute("success", "Xóa sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa sản phẩm!");
            }
            
            // Redirect về trang chủ
            response.sendRedirect("LoadAllVegetables");
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID sản phẩm không hợp lệ!");
            response.sendRedirect("LoadAllVegetables");
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("LoadAllVegetables");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
