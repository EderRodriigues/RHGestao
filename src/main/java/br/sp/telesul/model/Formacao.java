/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import java.io.Serializable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Eder Rodrigues
 */
@Entity
@Table(name = "Formacao")
public class Formacao implements Serializable {

    @Id
    @Column(name = "idFormacao")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idFormacao;
    @Column(name = "curso")
    private String curso;
    @Column(name = "instituicao")
    private String instituicao;
    @Column(name = "nivel")
    private String nivel;
    @Column(name = "copiaCertificado")
    private String copiaCertificado;

    public Formacao() {

    }

    public Long getIdFormacao() {
        return idFormacao;
    }

    public void setIdFormacao(Long idFormacao) {
        this.idFormacao = idFormacao;
    }

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    public String getInstituicao() {
        return instituicao;
    }

    public void setInstituicaoo(String instituicao) {
        this.instituicao = instituicao;
    }

    public String getCopiaCertificado() {
        return copiaCertificado;
    }

    public void setCopiaCertificado(String CopiaCertificado) {
        this.copiaCertificado = CopiaCertificado;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

}
