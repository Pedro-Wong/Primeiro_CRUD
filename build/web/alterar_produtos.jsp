<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salvando as alterações no banco</title>
    </head>
    <body>
        <%
           //pegando os dados do formulário em carregaprod.jsp
           int codigo;
           String nome, marca;
           double preco;
           codigo = Integer.parseInt(request.getParameter("codigo"));
           nome = request.getParameter("nome");
           marca = request.getParameter("marca");
           preco = Double.parseDouble(request.getParameter("preco"));
           //Fazendo conexão com o banco de dados
           Connection conexao;
           Class.forName("com.mysql.cj.jdbc.Driver");// caminho do drive que faz a conexão com o banco
           conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123"); //gerenciador do drive que faz a conexão com o banco (URL, usuário, senha)
           //Preparando comando SQL no java para 
           PreparedStatement st;
           st = conexao.prepareStatement("UPDATE produto SET nome= ?,marca= ?, preco= ? WHERE codigo= ?"); //código SQL, a interrogação serve para passar o valor depois , no caso st.setString()...
          
           st.setString(1,nome);
           st.setString(2,marca);
           st.setDouble(3,preco);
           st.setInt(4,codigo);
           st.executeUpdate();
           out.print("Produto com código "+codigo+" alterado com sucesso");
           
           

        %>
    </body>
</html>
