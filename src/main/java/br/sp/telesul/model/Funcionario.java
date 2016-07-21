/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import br.sp.telesul.jackson.CustomDateDeserializer;
import br.sp.telesul.jackson.CustomDateSerializer;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Eder Rodrigues
 */
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "FUNCIONARIO")
public class Funcionario implements Serializable {

    @Id
    @Column(name = "idFuncionario")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idFuncionario;
    @Column(name = "nome")
    private String nome;

    @Column(name = "cargo")
    private String cargo;

    @Column(name = "dtAdmissão")
    @Temporal(TemporalType.DATE)
    @JsonSerialize(using = CustomDateSerializer.class)
    @JsonDeserialize(using = CustomDateDeserializer.class)
    private Date dtAdmissao;

    @OneToMany(mappedBy = "funcionario", fetch = FetchType.EAGER, cascade = CascadeType.REFRESH)
    private List<Formacao> formacoes;

    @Column(name = "area")
    private String area;

    private String gestor;

    @OneToMany(mappedBy = "funcionarios", fetch = FetchType.EAGER, cascade = CascadeType.REFRESH)
    private List<Certificacao> certificacoes;

    @OneToMany(mappedBy = "idioma", fetch = FetchType.EAGER, cascade = CascadeType.REFRESH)
    List<Idioma> idiomas;
    // Idioma class idioma e nivel

    public Funcionario() {

    }

    public Funcionario(int idFuncionario, String nome, String cargo, Date dtAdmissao, List<Formacao> formacao, String area, String gestor) {
        this.idFuncionario = idFuncionario;
        this.nome = nome;
        this.cargo = cargo;
        this.dtAdmissao = dtAdmissao;
        this.formacoes = formacao;
        this.area = area;
        this.gestor = gestor;
    }

    public Date getDtAdmissao() {
        return dtAdmissao;
    }

    public void setDtAdmissao(Date dtAdmissao) {
        this.dtAdmissao = dtAdmissao;
    }

    public List<Formacao> getFormacoes() {
        return formacoes;
    }

    public void setFormacoes(List<Formacao> formacoes) {
        this.formacoes = formacoes;
    }

    public int getIdFuncionario() {
        return idFuncionario;
    }

    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public Date getDtAdmissão() {
        return dtAdmissao;
    }

    public void setDtAdmissão(Date dtAdmissão) {
        this.dtAdmissao = dtAdmissão;
    }

    public List<Formacao> getFormacao() {
        return formacoes;
    }

    public void setFormacao(List<Formacao> formacao) {
        this.formacoes = formacao;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getGestor() {
        return gestor;
    }

    public void setGestor(String gestor) {
        this.gestor = gestor;
    }

    public List<Certificacao> getCertificacoes() {
        return certificacoes;
    }

    public void setCertificacoes(List<Certificacao> certificacoes) {
        this.certificacoes = certificacoes;
    }

    public List<Idioma> getIdiomas() {
        return idiomas;
    }

    public void setIdiomas(List<Idioma> idiomas) {
        this.idiomas = idiomas;
    }

    @Override
    public String toString() {
        return "Funcionario{" + "idFuncionario=" + idFuncionario + ", nome=" + nome + ", cargo=" + cargo + ", dtAdmiss\u00e3o=" + dtAdmissao + ", formacao=" + formacoes + ", area=" + area + ", gestor=" + gestor + ", certificacoes=" + certificacoes + ", idiomas=" + idiomas + '}';
    }

}
