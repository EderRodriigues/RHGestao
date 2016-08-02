/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.Funcionario;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

/**
 *
 * @author ebranco
 */
@Service
public interface ExportService {

    public void buildExcelDocument(String type, List<String> columns, List<String> columnsFormacao, List<String> columnsIdiomas, List<String> columnsCertificacoes, HttpServletRequest request, HttpServletResponse response);
    public List<Funcionario> readExcelDocument();

}
