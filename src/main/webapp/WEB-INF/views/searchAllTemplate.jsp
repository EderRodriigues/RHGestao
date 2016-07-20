<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

    </head>
    <body>
        <div class="row">
            <div class="col-xs-4">
                <label for="search">Search:</label>
                <input ng-model="fltr" id="search" class="form-control" placeholder="Filter text">
            </div>
            <div class="col-xs-12 table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Selecionar</th>
                            <th>Nome</th>
                            <th>Empresa</th>                        
                        </tr>
                    </thead>
                    <tbody>
                        <tr 
                            dir-paginate="certificacao in certificacoes| filter:fltr | itemsPerPage: tamPagina" 
                            total-items="completo" current-page="atPagina" pagination-id="entityPagination3">
                            <td>
                                <input name="choosenEntity" type="radio" ng-click="isCertificateSelected(certificacao,$index)">
                            </td>
                            <td>
                                {{certificacao.nome}}
                            </td>
                            <td>{{certificacao.empresa}}</td>
                        </tr>


                    </tbody>
                </table>
            </div>
            <div class="col-xs-6 pull-right">
                <div class="text-center">
                    <dir-pagination-controls boundary-links="true" pagination-id="entityPagination3"
                                             ruleset-url="resources/angularjs/directive/pagination/pagination.html"
                                             on-page-change="pageChanged(atPagina,tamPagina,fltr)"></dir-pagination-controls>
                </div>
            </div>
        </div>


    </body>
</html>
