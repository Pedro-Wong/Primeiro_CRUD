
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int codigo;
            String nome, marca;
            double preco;
            //Recebendo os dados digitados do formulário cadpro.html
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));
            try{
                // fazer conexão com o banco de dados (import do Connection e PreparedStetament)
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");
                //inserir os dados na tabela produto do banco de dados aberto
                st = conecta.prepareStatement("INSERT INTO produto VALUES(?,?,?,?)");
                st.setInt(1, codigo);
                st.setString(2, nome);
                st.setString(3, marca);
                st.setDouble(4, preco);
                st.executeUpdate(); // executa o comando insert
                out.print("Produto cadastrado com sucesso");
            }catch(Exception x){
                x.getMessage();
                out.print("Erro na conexão com banco de dados");
                
            }
        %>
    </body>
</html>
