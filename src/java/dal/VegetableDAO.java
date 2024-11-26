/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

//import format.DescriptionFormatter;
import entities.Vegetable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class VegetableDAO extends DBContext {

    public static void main(String[] args) {
        VegetableDAO dao = new VegetableDAO();
//        System.out.println(dao.getVegetableById(7));
        List<Vegetable> v = dao.getAllVegatable();
        for (Vegetable vegetable : v) {
            System.out.println(vegetable);
            System.out.println("---------------------------------------");
        }

    }

    public List<Vegetable> getAllVegatable() {
        List<Vegetable> list = new ArrayList<>();
        String sql = "SELECT [Id]\n"
                + "      ,[Name]\n"
                + "      ,[Price]\n"
                + "      ,[Description]\n"
                + "      ,[Status]\n"
                + "      ,[Img_Src]\n"
                + "  FROM [dbo].[tblVegetables]";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Vegetable v = new Vegetable();
                v.setId(rs.getInt("Id"));
                v.setName(rs.getString("Name"));
                v.setPrice(rs.getFloat("Price"));
                v.setDescription(rs.getString("Description"));
                v.setStatus(rs.getBoolean("Status"));
                v.setImgSrc(rs.getString("Img_Src"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertVegetable(Vegetable vegetable) {
        String sql = "INSERT INTO [dbo].[tblVegetables] ([Name], [Price], [Description], [Status], [Img_Src]) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, vegetable.getName());
            pre.setFloat(2, vegetable.getPrice());
            pre.setString(3, vegetable.getDescription());
            pre.setBoolean(4, vegetable.isStatus());
            pre.setString(5, vegetable.getImgSrc());
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteVegetable(int id) {
        String sql = "DELETE FROM [dbo].[tblVegetables] WHERE [Id] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVegetable(Vegetable vegetable) {
        String sql = "UPDATE [dbo].[tblVegetables] SET [Name] = ?, [Price] = ?, [Description] = ?, [Status] = ?, [Img_Src] = ? "
                + "WHERE [Id] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, vegetable.getName());
            pre.setFloat(2, vegetable.getPrice());
            pre.setString(3, vegetable.getDescription());
            pre.setBoolean(4, vegetable.isStatus());
            pre.setString(5, vegetable.getImgSrc());
            pre.setInt(6, vegetable.getId());
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Vegetable> getVegetableByName(String name) {
        List<Vegetable> list = new ArrayList<>();
        String sql = "SELECT [Id], [Name], [Price], [Description], [Status], [Img_Src] "
                + "FROM [dbo].[tblVegetables] "
                + "WHERE [Name] COLLATE SQL_Latin1_General_CP1_CI_AI LIKE ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, "%" + name + "%");
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Vegetable v = new Vegetable();
                v.setId(rs.getInt("Id"));
                v.setName(rs.getString("Name"));
                v.setPrice(rs.getFloat("Price"));
                v.setDescription(rs.getString("Description"));
                v.setStatus(rs.getBoolean("Status"));
                v.setImgSrc(rs.getString("Img_Src"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Vegetable getVegetableById(int id) {
        String sql = "SELECT [Id], [Name], [Price], [Description], [Status], [Img_Src] "
                + "FROM [dbo].[tblVegetables] WHERE [Id] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id); // Tìm kiếm theo ID
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                Vegetable v = new Vegetable();
                v.setId(rs.getInt("Id"));
                v.setName(rs.getString("Name"));
                v.setPrice(rs.getFloat("Price"));
                v.setDescription(rs.getString("Description"));
                v.setStatus(rs.getBoolean("Status"));
                v.setImgSrc(rs.getString("Img_Src"));
                return v;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
