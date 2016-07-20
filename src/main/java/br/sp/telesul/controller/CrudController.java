/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.controller;

import br.sp.telesul.model.FilterReturn;
import br.sp.telesul.model.Funcionario;
import br.sp.telesul.service.FuncionarioService;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@RequestMapping("/crud")
@Controller
public class CrudController {

    FuncionarioService funcionarioService;

    @Autowired
    @Qualifier(value = "funcionarioService")
    public void setFuncionarioService(FuncionarioService funcionarioService) {
        this.funcionarioService = funcionarioService;
    }

    @RequestMapping(value = "save", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    ResponseEntity<Funcionario> save(@RequestBody Funcionario funcionario) throws ParseException {

        if(funcionario.getIdFuncionario()> 0){
          this.funcionarioService.change(funcionario);
        }else { 
             this.funcionarioService.salve(funcionario);  
        }

        return new ResponseEntity<>(funcionario, HttpStatus.OK);
    }
    @RequestMapping(value = "remove", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody void remove(@RequestBody Funcionario funcionario){
        this.funcionarioService.delete(funcionario);
    }

    @RequestMapping(value = "search", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    List<Funcionario> listEmployees() {

        List<Funcionario> employees = this.funcionarioService.search();

        return employees;
    }
    @RequestMapping(value = "search/{pageNumber}/{pageSize}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    FilterReturn searchForPagination(@PathVariable int pageNumber, @PathVariable int pageSize, @RequestParam String filter) {

        FilterReturn employees = this.funcionarioService.searchPage(pageNumber, pageSize, filter);

        return employees;
    }
    
//    @RequestMapping(value = "searchByNome/{nome}")
//    public @ResponseBody List<Funcionario> searchByNome(@PathVariable String nome){
//        List<Funcionario> lista = this.funcionarioService.buscarFuncionariosPorNome(nome);
//        return  lista;
//    }

}
