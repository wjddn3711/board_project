<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: jungwoo
  Date: 2021/11/25
  Time: 3:30 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String driver = "oracle.jdbc.driver.OracleDriver";
  String url = "jdbc:oracle:thin:@localhost:1521:XE";
  String user = "jung";
  String password = "1234";

  String sql_selectAll = "select * from board";
  String sql_insert="insert into board values((select nvl(max(bid),0)+1 from board),?,?)"; // pstmt

  String writer = request.getParameter("writer");
  String content = request.getParameter("content");

  Connection conn = null;
  PreparedStatement pstmt = null;
  try {
    Class.forName(driver);
    conn = DriverManager.getConnection(url, user, password);
    if(writer!=null){ // 만약 추가할 대상이 있다면
      pstmt = conn.prepareStatement(sql_insert); // insert 문 수행할 pstmt
      pstmt.setString(1,writer);
      pstmt.setString(2,content);
      pstmt.executeUpdate();
    }
%>

<html>
  <head>
    <title>게시판</title>
  </head>
  <body>
  <form action="" method="post">
    <table border="1">
      <tr>
        <th>작성자</th>
        <th>입력</th>
      </tr>
      <tr>
        <td><input type="text" name="writer"></td>
        <td><textarea placeholder="내용을 입력하세요" name="content"></textarea></td>
      </tr>
      <tr>
        <td colspan="2" align="right"><input type="submit" value="글게시"></td>
      </tr>
    </table>
  </form>
  <hr>
<%--  현재 DB 에 있는 내용 출력--%>
  <%
      pstmt = conn.prepareStatement(sql_selectAll);
      ResultSet rs = pstmt.executeQuery();
      while(rs.next()){
        out.println("\nID: "+rs.getInt("bid")+" 작성자: "+rs.getString("writer")+ " 내용 : "+rs.getString("content")+"<br>");
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
  %>
  </body>
</html>
