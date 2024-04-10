<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem dos produtos</title>
        <link rel="stylesheet" href="tabela.css"/>
    </head>
    <body>
        <%
            try{
                 // fazer conexão com o banco de dados (import do Connection, PreparedStetament e DriverManager)
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");
                //listar os dados na tabela produto do banco de dados aberto
                st = conecta.prepareStatement("SELECT * FROM produto ORDER By preco"); // comando para consultar todos os dados da tabela produto
                ResultSet rs = st.executeQuery(); // ResultSet serve para guardar os dados vindo do banco para aplicação java
        %>  
                <table>
                        <tr>
                            <th>Código</th><th>Nome</th><th>Marca</th><th>Preço</th><th>Exclusão</th>    
                        </tr>
        <%       
                while(rs.next()){  
        %>
                    
                        <tr>
                            <td><%= rs.getString("codigo")%></td>
                            <td><%= rs.getString("nome")%></td>
                            <td><%= rs.getString("marca")%></td>
                            <td><%= rs.getString("preco")%></td>
                            <td><a href="excpro.jsp?codigo=<%=rs.getString("codigo")%>">Excluir</a></td>
                        </tr>    
                  
        <%
                }
        %>
                  </table> 
        <%
            }catch(Exception x){
                out.print("Erro na conexão com banco de dados" + x.getMessage());
            }
        %>
    </body>
</html>
