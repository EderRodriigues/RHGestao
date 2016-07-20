/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.FilterReturn;
import java.util.List;


/**
 *
 * @author Eder Rodrigues
 */

public interface CertificacaoService {

    public void salve(Certificacao c);

    public void change(Certificacao c);

    public void delete(Certificacao c);

    public Certificacao searchById(Long id);

    public List<Certificacao> search();
    
    public FilterReturn searchPage(int pageNumber, int pageSize, String filter);
}
