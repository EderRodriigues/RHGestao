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
                <input ng-model="q2" id="search" class="form-control" placeholder="Filter text">
            </div>
            <!-- <div class="col-xs-4">
                 <label for="search">items per page:</label>
                 <input type="number" min="1" max="10" class="form-control" ng-model="pageSize">
             </div>-->
            <div class="col-xs-12 table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Selecionar</th>
                            <th>Nome</th>
                            <th>Setor</th>                        
                        </tr>
                    </thead>
                    <tbody>
                        <tr 
                            dir-paginate="employee in employees| filter:filtro | itemsPerPage: tamanhoPagina" 
                            total-items="total2" current-page="atualPagina" pagination-id="entityPagination2">
                            <td>
                                <input name="choosenEntity" type="radio" ng-click="isEmployeeSelected(employee)">
                            </td>
                            <td>
                                {{employee.nome}}
                            </td>
                            <td>{{employee.setor}}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-xs-6 pull-right">
                <div class="text-center">
                    <dir-pagination-controls boundary-links="true" pagination-id="entityPagination2"
                                             ruleset-url="resources/angularjs/directive/pagination/pagination.html"
                                             on-page-change="pageChanged(atualPagina,tamanhoPagina,filtro)"></dir-pagination-controls>
                </div>
            </div>
        </div>
    </body>
</html>
