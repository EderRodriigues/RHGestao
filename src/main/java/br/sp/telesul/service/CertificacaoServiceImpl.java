/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.dao.CertificacaoDAO;
import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.FilterReturn;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Eder Rodrigues
 */
@Service
public class CertificacaoServiceImpl implements CertificacaoService{
    private CertificacaoDAO certificacaoDAO;

    public CertificacaoDAO getCertificacaoDAO() {
        return certificacaoDAO;
    }

    public void setCertificacaoDAO(CertificacaoDAO certificacaoDAO) {
        this.certificacaoDAO = certificacaoDAO;
    }
    
    
    @Override
    @Transactional
    public void salve(Certificacao certificacao) {
        this.certificacaoDAO.save(certificacao);
    }

    @Override
    @Transactional
    public void change(Certificacao Certificacao) {
        this.certificacaoDAO.change(Certificacao);
    }

    @Override
    @Transactional
    public void delete(Certificacao Certificacao) {
        this.certificacaoDAO.delete(Certificacao);
    }

    @Override
    @Transactional
    public List<Certificacao> search() {
        return this.certificacaoDAO.search();
    }

    @Override
    @Transactional
    public Certificacao searchById(Long id) {
        return this.certificacaoDAO.searchById(id);
    }

    @Override
    @Transactional
    public FilterReturn searchPage(int pageNumber, int pageSize, String filter) {
     return this.certificacaoDAO.searchPage(pageNumber, pageSize, filter);
    }
    
}
