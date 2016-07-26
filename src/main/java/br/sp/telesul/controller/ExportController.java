/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.controller;

import br.sp.telesul.generators.ExcelReport;
import br.sp.telesul.service.ExportService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author ebranco
 */
@RequestMapping(value = "export")
@Controller
public class ExportController {
    @Autowired
    private ExportService exs;
    @RequestMapping(value="exportFile/{type}/{columns}",method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody String exportFile(@PathVariable String type, @PathVariable List<String> columns){
        String t ="es";
       exs.buildExcelDocument(type, columns);
       return "Ok";
    } 
}
