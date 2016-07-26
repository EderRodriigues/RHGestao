/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.Funcionario;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author ebranco
 */

@Service
public class ExportServiceImpl implements ExportService {

    private FuncionarioService funcionarioService;

    @Override
    public void generateReport(String formatType) {
        switch (formatType) {
            case "xls": {
//                logger.info("Generating xls report for {}", templateName);
//                excelReport.buildXLSDocument(templateName, visibleColumns, request, response, fullReport);
                break;
            }
            case "xlsx": {
//                logger.info("Generating xlsx report for {}", templateName);
//                excelReport.buildXLSXDocument(templateName, visibleColumns, request, response, fullReport);
                break;
            }
            default: {
//                logger.error("Format {} not supported", formatType);
                break;
            }
        }
    }
        @Override
        public void buildExcelDocument(String templateName, List<String> columns) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();
//            HttpSession httpSession = request.getSession();

            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet("Funcionarios");

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.size(); i++) {
                rowHeading.createCell(i).setCellValue(columns.get(i));
            }
            
            for (int i = 0; i < columns.size(); i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short)11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            
            int r =1;
            for (Funcionario f : funcionarios) {
                Row row = sheet.createRow(r);
                
                Cell Id = row.createCell(0);
                Id.setCellValue(f.getIdFuncionario());
                Cell Nome = row.createCell(1);
                Nome.setCellValue(f.getNome());
                Cell cargo = row.createCell(2);
                cargo.setCellValue(f.getCargo());
                
                Cell dtAdmissao = row.createCell(3);
                dtAdmissao.setCellValue(f.getDtAdmissao());
                
                CellStyle styleDate = workbook.createCellStyle();
                HSSFDataFormat dfAdmissao = workbook.createDataFormat();
                styleDate.setDataFormat(dfAdmissao.getFormat("d/m/yy"));
                dtAdmissao.setCellStyle(styleDate);
                
                Cell area = row.createCell(4);
                area.setCellValue(f.getArea());
                
                Cell gestor = row.createCell(5);
                gestor.setCellValue(f.getGestor());
                
//                Cell certificacoes = row.createCell(0);
//                certificacoes.setCellValue(f.getCertificacoes());
//                
//                Cell formacoes = row.createCell(0);
//                formacoes.setCellValue(f.getFormacoes());
//                Cell idiomas = row.createCell(0);
//                idiomas.setCellValue(f.getIdiomas());
                r++;
            }
            
            for (int i = 0; i < columns.size(); i++) {
                sheet.autoSizeColumn(i);
            }
            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
            FileOutputStream out = new FileOutputStream(new File(file));
            workbook.write(out);
            out.close();
            workbook.close();
            System.out.println("Excell write succesfully");
        } catch (Exception e) {

        }

    }
}
