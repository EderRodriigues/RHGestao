/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.model.Funcionario;
import java.util.List;

/**
 *
 * @author Eder Rodrigues
 */
public interface FuncionarioService {

    public void save(Funcionario funcionario);

    public void update(Funcionario funcionario);

    public void delete(Funcionario funcionario);

    public List<Funcionario> search();
    
    public Funcionario searchById(Long id);

    public FilterReturn searchPage(int pageNumber, int pageSize, String filter);
}
