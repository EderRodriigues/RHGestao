<%-- 
    Document   : index
    Created on : 21/06/2016, 21:35:58
    Author     : Eder Rodrigues
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RH Gestão</title>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>  
        <script src="<c:url value="/resources/angularjs/external/angular.min.js"/>" type="text/javascript"></script>
        <script src="resources/bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <link href="resources/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/estilo.css" rel="stylesheet" type="text/css"/>
    </head>
    <style>
        body{
            background-image: url("resources/imgs/fabric-of-squares.png");
            background-repeat: repeat; 
           

        }
        
    </style>
    <body>
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#"><img id="img" src="resources/imgs/Telesul.png"></a>
                </div>
                <ul class="nav navbar-nav">

                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="index">Funcionários
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a class="op" href="cadastrarFuncionario">Cadastrar</a></li>
                            <li><a class="op" href="atualizarFuncionario">Atualizar</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Certificações
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a class="op" href="cadastrarCertificacao">Cadastrar</a></li>
                            <li><a class="op" href="atualizarCertificacao">Atualizar</a></li>
                        </ul>
                    </li>

                </ul>
            </div>
        </nav>
        <section>
            <!--<img id="home" src="resources/imgs/blue-light.jpg"/>-->
            

        </section>
    </body>
</html>
