/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.controller;

import br.sp.telesul.model.Funcionario;
import br.sp.telesul.service.ExportService;
import br.sp.telesul.service.FuncionarioService;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author ebranco
 */
@RequestMapping(value = "export")
@Controller
public class ExportController {

    @Autowired
    @Qualifier(value = "exportService")
    private ExportService exs;

    FuncionarioService funcionarioService;

    @Autowired
    @Qualifier(value = "funcionarioService")
    public void setFuncionarioService(FuncionarioService funcionarioService) {
        this.funcionarioService = funcionarioService;
    }

    @RequestMapping(value = "exportFile/{type}/{columns}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public void exportFile(@PathVariable String type, @PathVariable List<String> columns, HttpServletRequest request, HttpServletResponse response) {
        List<String> columnsFormacao = new ArrayList<>();
        columnsFormacao.add("Nome");
        columnsFormacao.add("Curso");
        columnsFormacao.add("Instituicao");
        columnsFormacao.add("Nível");
        columnsFormacao.add("Cópia de Certificado");
        List<String> columnsIdiomas = new ArrayList<>();
        columnsIdiomas.add("Nome");
        columnsIdiomas.add("Idioma");
        columnsIdiomas.add("Nível");
        List<String> columnsCertificacoes = new ArrayList<>();
        columnsCertificacoes.add("Nome");
        columnsCertificacoes.add("Código Exame");
        columnsCertificacoes.add("Certificado");
        columnsCertificacoes.add("Exame");

        columnsCertificacoes.add("Data de Exame");
        columnsCertificacoes.add("Data de Validade");
        columnsCertificacoes.add("Cópia de Certificado");
        exs.buildExcelDocument(type, columns, columnsFormacao, columnsIdiomas, columnsCertificacoes, request, response);

    }

    @RequestMapping(value = "readExcel", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    void readExcel() {
        List<Funcionario> funcionarios = exs.readExcelDocument();
        for (Funcionario f : funcionarios ) {
            funcionarioService.save(f);
        }
    }
}
