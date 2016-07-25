/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import br.sp.telesul.jackson.CustomDateDeserializer;
import br.sp.telesul.jackson.CustomDateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Eder Rodrigues
 */
@Entity
@Table(name = "CERTIFICACAO")
public class Certificacao implements Serializable {

    @Id
    @Column(name = "idCertificacao")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int idCertificacao;
    @Column
    private int codigo;
    @Column(name = "nome")
    private String nome;
    @Column(name = "empresa")
    private String empresa;
    
    @Column(name="dtExame")
    @Temporal(TemporalType.DATE)
    @JsonSerialize(using = CustomDateSerializer.class)
    @JsonDeserialize(using = CustomDateDeserializer.class)
    private Date dtExame;
    
    @Column(name="dtValidade")
    @Temporal(TemporalType.DATE)
    @JsonSerialize(using = CustomDateSerializer.class)
    @JsonDeserialize(using = CustomDateDeserializer.class)
    private Date dtValidade;

    @Column(name="copia")
    private String copia;

    public Certificacao() {

    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getIdCertificacao() {
        return idCertificacao;
    }

    public void setIdCertificacao(int idCertificacao) {
        this.idCertificacao = idCertificacao;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getCopia() {
        return copia;
    }

    public void setCopia(String copia) {
        this.copia = copia;
    }
    
    public Date getDtExame() {
        return dtExame;
    }

    public void setDtExame(Date dtExame) {
        this.dtExame = dtExame;
    }

    public Date getDtValidade() {
        return dtValidade;
    }

    public void setDtValidade(Date dtValidade) {
        this.dtValidade = dtValidade;
    }

    public String getEmpresa() {
        return empresa;
    }

    public void setEmpresa(String empresa) {
        this.empresa = empresa;
    }

    @Override
    public String toString() {
        return "Certificacao{" + "idCertificacao=" + idCertificacao + ", codigo=" + codigo + ", nome=" + nome + ", empresa=" + empresa + ", dtExame=" + dtExame + ", dtValidade=" + dtValidade + ", copia=" + copia + '}';
    }  

}
