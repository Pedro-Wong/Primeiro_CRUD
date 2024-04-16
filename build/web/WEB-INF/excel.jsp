<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResulSet" %>
<%@page import="java.io.BufferedReader" %> <!-- Ferramenta utilizada para transferir o arquivo para o java  -->
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
            PreparedStatement st;
            try{   
                // conectando com o banco 
                Connection conecta;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco", "root", "trojan123");

                //lendo arquivo csv/excel
                FileReader arquivo = new FileReader("Entra o caminho do arquivo"); // caminho onde está o arquivo para ser lido
                BufferedReader br = new BufferedReader(arquivo);
                String linha;
                while((linha = br.readLine()) != null){
                    //pegam os valores da linha do arquvio excel e joga em variáveis
                    String [] dados = linha.split(",");
                    //limpa o valor contido em dados[0] de caracteres ocultos
                    String cod = dados[0].replaceAll("[^0-9]", "");
                    int c = Integer.parseInt(cod);
                    String n = dados[1];
                    String m = dados[2];
                    double p = dados[3];
                    
                    //Verificando se há produtos já cadastrados
                    
                    st = conecta.prepareStatement("SELECT * FROM produto WHERE codigo=?");
                    st.setInt(1, c);
                    ResulSet resultado = st.executeQuery();
                    
                    if(!resultado.next()){                  
                        //preparando código sql
                        st = conecta.prepareStatement("INSERT INTO produto VALUES(?,?,?,?)");
                        st.setInt(1,c);
                        st.setString(2,n);
                        st.setString(3,m);
                        st.setDouble(4,p);
                        st.executeUpdate();
                        out.println("O produto "+c+" foi cadastrado com sucesso");
                    }else{
                        out.println("O produto "+c+" já está cadastrado ");
                    }
                                    
                }
                br.close();
            }catch(Exception erro){
                out.print("Erro: " + erro.getMessage());
            }        






            
            
        
        %>
    </body>
</html>
