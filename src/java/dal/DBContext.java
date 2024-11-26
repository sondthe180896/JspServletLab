package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123";
            // Sửa connection string và thêm các tham số bảo mật
            String url = "jdbc:sqlserver://localhost:1433;"
                    + "databaseName=JspServlet_Lab;"
                    + "encrypt=true;"
                    + "trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        try {
            DBContext db = new DBContext();
            if (db.connection != null && !db.connection.isClosed()) {
                System.out.println("Kết nối database thành công!");
                // Test thêm bằng cách thực hiện một truy vấn đơn giản
                java.sql.Statement stmt = db.connection.createStatement();
                java.sql.ResultSet rs = stmt.executeQuery("SELECT 1");
                if (rs.next()) {
                    System.out.println("Test query thành công!");
                }
            } else {
                System.out.println("Kết nối database thất bại!");
            }
        } catch (Exception e) {
            System.out.println("Lỗi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
