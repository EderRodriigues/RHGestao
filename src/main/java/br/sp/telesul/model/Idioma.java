/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.model;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author ebranco
 */
@Entity
@Table(name="Idioma")
public class Idioma implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="idIdioma")
    private Long idIdioma;
    @Column(name="nome")
    @Enumerated(EnumType.STRING)
    private Language nome;
    @Column(name="nivel")
    @Enumerated(EnumType.STRING)
    private Nivel nivel;

    

    public Idioma() {
    
    }
    public Idioma(Language nome, Nivel nivel) {
        this.nome = nome;
        this.nivel = nivel;
    }

    public Long getId() {
        return idIdioma;
    }

    public void setId(Long idIdioma) {
        this.idIdioma = idIdioma;
    }
    
    public Language getNome() {
        return nome;
    }

    public void setNome(Language nome) {
        this.nome = nome;
    }

    public Nivel getNivel() {
        return nivel;
    }

    public void setNivel(Nivel nivel) {
        this.nivel = nivel;
    }    
    
    @Override
    public String toString(){
        return "nome"+nome+"nivel"+nivel;
    }
    
}
