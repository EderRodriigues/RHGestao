<%-- 
    Document   : modalTemplate
    Created on : 01/07/2016, 13:47:04
    Author     : ebranco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .panel-heading{
                background: #337ab7;
            }
            h2{
                color: white;
            }

        </style>
    </head>
    <body>
        <div class='panel-heading'><h2>Selecione Certificações</h2></div>
        <div class='panel-body'>
            <div class="col-xs-4">
                <label for="search">Search:</label>
                <input ng-model="q" id="search" class="form-control" placeholder="Filter text">
            </div>
            <table class='table'>
                <thead>
                <td>Selecionar</td> 
                <td>Nome</td>
                </thead>
                <tbody>
                    <tr dir-paginate="certificacao in certificacaoBd| filter:q | itemsPerPage: pageSize" 
                        total-items="total" current-page="currentPage" pagination-id="entityPagination">
                        <td>
                            <input name="choosenEntity" type="checkbox" ng-click='selecionarCertificacao(certificacao)' ng-checked="certificacao.checked === true">
                        </td>
                        <td>
                            {{certificacao.nome}}
                        </td>
                        <td>{{certificacao.empresa}}</td>
                    </tr>
                </tbody>
            </table>
            <div class="col-xs-6 pull-right">
                <div class="text-center">
                    <dir-pagination-controls boundary-links="true" pagination-id="entityPagination"
                                             ruleset-url="resources/angularjs/directive/pagination/pagination.html"
                                             on-page-change="pageChanged(currentPage,pageSize,q)"></dir-pagination-controls>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class='btn btn-primary' ng-click='ok()'>OK</button>
            <button class='btn btn-danger' ng-click='cancel()'>Cancelar</button>
        </div>
    </body>
</html>
