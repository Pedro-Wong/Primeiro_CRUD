
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de produto</title>
    </head>
    <body>
        <%
            //Recebendo os dados digitados do formulário cadpro.html
            int codigo;
            String nome, marca;
            double preco;
            
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));
            
            try{
                // fazer conexão com o banco de dados (import do Connection, PreparedStetament e DriverManager)
                Connection conecta;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");
                //inserir os dados na tabela produto do banco de dados aberto
                PreparedStatement st;
                st = conecta.prepareStatement("INSERT INTO produto VALUES(?,?,?,?)");
                st.setInt(1, codigo);
                st.setString(2, nome);
                st.setString(3, marca);
                st.setDouble(4, preco);
                st.executeUpdate(); // executa o comando insert
                out.print("Produto cadastrado com sucesso");
            }catch(Exception x){
                String erro = x.getMessage();
                if(erro.contains("Duplicate entry")){
                    out.print("<span style='color: blue; font-size: 16px'>Já existe um produto cadastrado com o código: </span>" + codigo);
                }else{
                    out.print("<p style='color: red; font-size: 16px'> Erro: " + erro + "</p>");
                }
                
            }
        %>
    </body>
</html>
