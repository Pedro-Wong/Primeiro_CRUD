<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>

<%@page import="java.io.BufferedReader" %> <!-- Ferramenta utilizada para ler arquivos csv  -->
<%@page import="java.io.FileReader" %> <!-- Ferramenta utilizada para ler arquivos csv  -->




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro via Excel</title>
    </head>
    <body>
        <% 
            try{   
                // conectando com o banco 
                Connection conecta;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");

                //lendo arquivo csv/excel
                FileReader arquivo = new FileReader(); // caminho onde está o arquivo para ser lido
                BufferReader br = new BufferReader(arquivo);
                String linha;
                while((linha = br.readline()) != null){
                    //pegam os valores da linha do arquvio excel e joga em variáveis
                    String [] dados = linha.split(",");
                    int c = Integer.parseInt(dados[0]);
                    String n = dados[1];
                    String m = dados[2];
                    double p = dados[3];
                    //preparando código sql
                    PreparedStatement st;
                    st = conecta.prepareStatement("INSERT INTO produto VALUES(?,?,?,?)");
                    st.setInt(1,c);
                    st.setString(2,n);
                    st.setString(3,m);
                    st.setDouble(4,p);
                    st.executeUpdate();

                }
                br.close();
            }catch(Exception erro){
                out.print("Erro: " + erro.getMessage());
            }        






            
            
        
        %>
    </body>
</html>
