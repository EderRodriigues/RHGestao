/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.Formacao;
import br.sp.telesul.model.Funcionario;
import br.sp.telesul.model.Idioma;
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
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 *
 * @author ebranco
 */
@Service
public class ExportServiceImpl implements ExportService {

    @Autowired
    @Qualifier(value = "funcionarioService")
    private FuncionarioService funcionarioService;
    private final HSSFWorkbook workbook = new HSSFWorkbook();

    public FuncionarioService getFuncionarioService() {
        return funcionarioService;
    }

    public void setFuncionarioService(FuncionarioService funcionarioService) {
        this.funcionarioService = funcionarioService;
    }

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
    public void buildExcelDocument(String type, List<String> columns, List<String> columnsFormacao, List<String> columnsIdiomas, List<String> columnsCertificacoes) {

        writeExcel("Funcionarios", columns);
        writeExcelFormacao("Formações", columnsFormacao);
        writeExcelIdiomas("Idiomas", columnsIdiomas);
        writeExcelCertificacoes("Certificações", columnsCertificacoes);
    }

    public void writeExcel(String templateHead, List<String> columns) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

//            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.size(); i++) {
                rowHeading.createCell(i).setCellValue(columns.get(i));
            }

            for (int i = 0; i < columns.size(); i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }

            int r = 1;
            for (Funcionario f : funcionarios) {
                Row row = sheet.createRow(r);

               
                Cell Nome = row.createCell(0);
                Nome.setCellValue(f.getNome());
                Cell cargo = row.createCell(1);
                cargo.setCellValue(f.getCargo());

                Cell dtAdmissao = row.createCell(2);
                dtAdmissao.setCellValue(f.getDtAdmissao());

                CellStyle styleDate = workbook.createCellStyle();
                HSSFDataFormat dfAdmissao = workbook.createDataFormat();
                styleDate.setDataFormat(dfAdmissao.getFormat("dd/mm/yyyy"));
                dtAdmissao.setCellStyle(styleDate);

                Cell area = row.createCell(3);
                area.setCellValue(f.getArea());

                Cell gestor = row.createCell(4);
                gestor.setCellValue(f.getGestor());

                r++;
            }

            for (int i = 0; i < columns.size(); i++) {
                sheet.autoSizeColumn(i);
            }
            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
            FileOutputStream out = new FileOutputStream(file);
            workbook.write(out);
            out.close();
            workbook.close();
            System.out.println("Excell write succesfully");
        } catch (Exception e) {

        }
    }

    public void writeExcelFormacao(String templateHead, List<String> columns) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.size(); i++) {
                rowHeading.createCell(i).setCellValue(columns.get(i));
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.size(); i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            //Preencher linhas
            int r = 1;
            for (Funcionario f : funcionarios) {

                if (!f.getFormacoes().isEmpty()) {

                    for (Formacao fmc : f.getFormacoes()) {
                        Row row = sheet.createRow(r);

                        Cell Nome = row.createCell(0);
                        Nome.setCellValue(f.getNome());
                        Cell curso = row.createCell(1);
                        curso.setCellValue(fmc.getCurso());
                        Cell instituicao = row.createCell(2);
                        instituicao.setCellValue(fmc.getInstituicao());
                        Cell nivel = row.createCell(3);
                        nivel.setCellValue(fmc.getNivel());
                        Cell copia = row.createCell(4);
                        copia.setCellValue(fmc.getCopiaCertificado());

                        r++;
                    }

                }

            }

            for (int i = 0; i < columns.size(); i++) {
                sheet.autoSizeColumn(i);
            }
            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
            FileOutputStream out = new FileOutputStream(file);
            workbook.write(out);
            out.close();
            workbook.close();
            System.out.println("Excell write succesfully");
        } catch (Exception e) {

        }
    }

    public void writeExcelCertificacoes(String templateHead, List<String> columns) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.size(); i++) {
                rowHeading.createCell(i).setCellValue(columns.get(i));
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.size(); i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            //Preencher linhas
            int r = 1;
            for (Funcionario f : funcionarios) {

                if (!f.getCertificacoes().isEmpty()) {

                    for (Certificacao ct : f.getCertificacoes()) {
                        Row row = sheet.createRow(r);

                        Cell Nome = row.createCell(0);
                        Nome.setCellValue(f.getNome());

                        Cell cod = row.createCell(1);
                        cod.setCellValue(ct.getCodigo());
                        Cell nome = row.createCell(2);
                        nome.setCellValue(ct.getNome());
                        Cell empresa = row.createCell(3);
                        empresa.setCellValue(ct.getEmpresa());
                        Cell dtExame = row.createCell(4);
                        dtExame.setCellValue(ct.getDtExame());
                        Cell dtValidade = row.createCell(5);
                        dtValidade.setCellValue(ct.getDtValidade());
                        Cell copia = row.createCell(6);
                        copia.setCellValue(ct.getCopia());

                        CellStyle styleDate = workbook.createCellStyle();
                        HSSFDataFormat dfExame = workbook.createDataFormat();
                        styleDate.setDataFormat(dfExame.getFormat("dd/mm/yyyy"));
                        dtExame.setCellStyle(styleDate);
                        dtValidade.setCellStyle(styleDate);

                        r++;
                    }

                }

            }

            for (int i = 0; i < columns.size(); i++) {
                sheet.autoSizeColumn(i);
            }
            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
            FileOutputStream out = new FileOutputStream(file);
            workbook.write(out);
            out.close();
            workbook.close();
            System.out.println("Excell write succesfully");
        } catch (Exception e) {

        }
    }

    public void writeExcelIdiomas(String templateHead, List<String> columns) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.size(); i++) {
                rowHeading.createCell(i).setCellValue(columns.get(i));
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.size(); i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            //Preencher linhas
            int r = 1;
            for (Funcionario f : funcionarios) {

                if (!f.getIdiomas().isEmpty()) {

                    for (Idioma idm : f.getIdiomas()) {
                        Row row = sheet.createRow(r);
                        Cell Nome = row.createCell(0);
                        Nome.setCellValue(f.getNome());

                        Cell language = row.createCell(1);
                        language.setCellValue(idm.getNome().toString());

                        Cell nivel = row.createCell(2);
                        nivel.setCellValue(idm.getNivel().toString());
                        r++;
                    }

                }

            }

            for (int i = 0; i < columns.size(); i++) {
                sheet.autoSizeColumn(i);
            }
            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
            FileOutputStream out = new FileOutputStream(file);
            workbook.write(out);
            out.close();
            workbook.close();
            System.out.println("Excell write succesfully");
        } catch (Exception e) {

        }
    }
    
    public void saveExcel(HSSFWorkbook wbk){
        
    };
}
