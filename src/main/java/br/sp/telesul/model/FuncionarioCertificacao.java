/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author ebranco
 */
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})

public class FuncionarioCertificacao implements Serializable {
    
    private int id;
   
    private int idFuncionario;
    
    private int idCertificacao;

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public int getIdCertificacao() {
        return idCertificacao;
    }

    public void setIdCertificacao(int idCertificacao) {
        this.idCertificacao = idCertificacao;
    }
    
    
    
}
