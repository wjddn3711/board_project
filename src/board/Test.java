package board;

import java.sql.*;

public class Test {
    public static void main(String[] args) {
        String driver = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:XE";
        String user = "jung";
        String password = "1234";

        String sql_selectAll = "select * from board";

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, user, password);
            pstmt = conn.prepareStatement(sql_selectAll);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                System.out.println("\nID: "+rs.getInt("bid")+"\n작성자: "+rs.getString("writer")+ "\n내용 : "+rs.getString("content"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
}
