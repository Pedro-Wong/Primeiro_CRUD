<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excluir produtos</title>
    </head>
    <body>
        <%
            //recebe o dado digitado do formulário em excpro.html
                int cod;
                cod = Integer.parseInt(request.getParameter("codigo"));
   
            try{
                //Conexao com banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");
                // Exclui o produto do código informado
                st = conecta.prepareStatement("DELETE FROM produto WHERE codigo=?");// coloca interrogação, pois não vai ser passado o valor agora
                st.setInt(1, cod); // nessa linha é onde coloca a informação que irá entrar na interrogação
                int resultado = st.executeUpdate(); // Aqui é executado o comando DELETE
                //Verificacao se o produto foi excluido ou não
                if(resultado == 0){
                    out.print("Produto não cadastrado");
                }else{
                    out.print("O produto de código " + cod + " foi excluido com sucesso");
                }
            }catch(Exception x){
                String erro = x.getMessage();
                out.print("Erro na exclusão do produto: " + erro);
            }
                
        %>
    </body>
</html>
