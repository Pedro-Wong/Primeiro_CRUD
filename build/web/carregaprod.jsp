<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alteração de produtos</title>
        <link rel="stylesheet" href="cadastro.css"/>
    </head>
    <body>
        <%
          // Recebendo dados do campo código do formulário altpro.html
          int c;
          c = Integer.parseInt(request.getParameter("codigo"));
          //Conexão com o banco
          Connection conecta;
          Class.forName("com.mysql.cj.jdbc.Driver"); // Mostra onde está o driver para conectar com o banco
          conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123"); // Faz a conexão com o banco e precisa dos parametros url, usuario e senha do banco
          // Buscar o produto pelo o código recebido
          PreparedStatement st;
          st = conecta.prepareStatement("SELECT * FROM produto WHERE codigo = ?");// interrogação é para passar o valor a ser pesquisado depois
          st.setInt(1, c);//Valor que irá para a interrogação
          ResultSet resultado = st.executeQuery();// executa o comando SQL, no caso o SELECT do st e guarda os dados do produto selecionado
          //tratamento da variavel resultado e verifica se o produto de código informado foi encontrado
          if(!resultado.next()){
            out.print("Produto não encontrado");
          }else{//alterando o produto
        %>
            <form method="post" action="alterar_produtos.jsp">
                <p>
                    <label for="codigo">Código do produto: </label>
                    <input class="input-form" type="number" name="codigo" id="codigo" value="<%= resultado.getString("codigo") %>" readonly >
                </p>
                <p>
                    <label for="nome">Nome  </label>
                    <input class="input-form" type="text" name="nome" id="nome" value="<%= resultado.getString("nome")%>">
                </p>
                <p>
                    <label for="marca">Marca  </label>
                    <input class="input-form" type="text" name="marca" id="marca" maxlength="50" value="<%= resultado.getString("marca")%>">
                </p>
                <p>
                    <label for="preco">Preço  </label>
                    <input class="input-form" type="number" step="0.5" name="preco" id="preco" value="<%= resultado.getString("preco") %>">
                </p>
                <p class="botao-flex">
                    <input class="botao-input" type="submit" value="Salvar alterações">
                </p>
            </form>
        <% 
          }
        %>
    </body>
</html>
