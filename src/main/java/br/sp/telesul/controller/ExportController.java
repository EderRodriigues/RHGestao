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

    @RequestMapping(value = "exportFile/{type}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public void exportFile(@PathVariable String type, HttpServletRequest request, HttpServletResponse response) {
        String[] columns = {"Nome", "Cargo", "Data de Admissao", "Área", "Gestor", "Email","Telefone","Celular"};
        String[] columnsFormacao ={"Nome","Curso","Instituicao","Nível","Cópia de Certificado"};
        String[] columnsIdiomas ={"Nome", "Idioma", "Nível"};
        String[] columnsCertificacoes ={"Nome","Código Exame","Certificado","Exame","Data de Exame","Data de Validade","Cópia de Certificado"};
    
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
    
    @RequestMapping(value = "exportSingleReport/{id}",method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody void exportSingleReport(@PathVariable Long id,HttpServletRequest request, HttpServletResponse response){
        this.exs.singleReport(id,request,response);
    }
}
