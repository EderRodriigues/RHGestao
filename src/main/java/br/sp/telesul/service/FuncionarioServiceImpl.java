/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.dao.FuncionarioDAO;
import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.model.Funcionario;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Eder Rodrigues
 */
@Service
public class FuncionarioServiceImpl implements FuncionarioService {

    private FuncionarioDAO funcionarioDAO;

    public FuncionarioDAO getFuncionarioDAO() {
        return funcionarioDAO;
    }

    public void setFuncionarioDAO(FuncionarioDAO funcionarioDAO) {
        this.funcionarioDAO = funcionarioDAO;
    }

    @Override
    @Transactional
    public void salve(Funcionario funcionario) {
        this.funcionarioDAO.save(funcionario);
    }

    @Override
    @Transactional
    public void change(Funcionario funcionario) {
        this.funcionarioDAO.change(funcionario);
    }

    @Override
    @Transactional
    public void delete(Funcionario funcionario) {
        this.funcionarioDAO.delete(funcionario);
    }

    @Override
    @Transactional
    public List<Funcionario> search() {
        return this.funcionarioDAO.search();
    }

    @Override
    @Transactional
    public Funcionario searchById(Long id) {
        return this.funcionarioDAO.searchById(id);
    }

    @Override
    @Transactional
    public List<Funcionario> buscarFuncionariosPorNome(String name) {
        return this.funcionarioDAO.listLikeProdutos(name);
    }

    @Override
    @Transactional
    public FilterReturn searchPage(int pageNumber, int pageSize, String filter) {
        return this.funcionarioDAO.searchPage(pageNumber, pageSize, filter);
    }

}
