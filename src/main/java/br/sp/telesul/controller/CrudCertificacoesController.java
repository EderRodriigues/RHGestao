/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.controller;

import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.service.CertificacaoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Eder Rodrigues
 */
@RequestMapping("/crudCertificacoes")
@Controller
public class CrudCertificacoesController {

    CertificacaoService certificacaoService;

    @Autowired
    @Qualifier(value = "certificacaoService")
    public void setCertificacaoService(CertificacaoService certificacaoService) {
        this.certificacaoService = certificacaoService;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    List<Certificacao> listarCertificacoes() {

        List<Certificacao> certificacoes = this.certificacaoService.search();
        return certificacoes;
    }

    @RequestMapping(value = "search/{pageNumber}/{pageSize}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    FilterReturn searchForPagination(@PathVariable int pageNumber, @PathVariable int pageSize, @RequestParam String filter) {

        FilterReturn employees = this.certificacaoService.searchPage(pageNumber, pageSize, filter);

        return employees;
    }

    @RequestMapping(value = "salvar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    ResponseEntity<Certificacao> save(@RequestBody Certificacao certificacao) {

        if (certificacao.getId() == 0) {
            this.certificacaoService.salve(certificacao);
        }else{
            this.certificacaoService.change(certificacao);
        }

        return new ResponseEntity<>(certificacao, HttpStatus.OK);
    }
    
    
    @RequestMapping(value = "deletar", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody void remove(@RequestBody Certificacao certificacao){
        this.certificacaoService.delete(certificacao);
    }

}
