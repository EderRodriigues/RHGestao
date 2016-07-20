/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.Formacao;
import java.util.List;

/**
 *
 * @author Eder Rodrigues
 */
public interface FormacaoService {

    public void save(Formacao f);

    public void change(Formacao f);

    public void delete(Formacao f);

    public Formacao searchById(Long id);

    public List<Formacao> search();
}
