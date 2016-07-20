/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import java.util.List;


/**
 *
 * @author ebranco
 */
public class FilterReturn {

    private Long totalEntities;
    private List<Funcionario> employees;

    public Long getTotalEntities() {
        return totalEntities;
    }

    public void setTotalEntities(Long totalEntities) {
        this.totalEntities = totalEntities;
    }

    public List<Funcionario> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Funcionario> employees) {
        this.employees = employees;
    }

}
