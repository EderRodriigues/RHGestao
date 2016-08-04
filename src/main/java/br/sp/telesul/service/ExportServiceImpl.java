/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.sp.telesul.service;

import br.sp.telesul.controller.CrudController;
import br.sp.telesul.model.Certificacao;
import br.sp.telesul.model.Formacao;
import br.sp.telesul.model.Funcionario;
import br.sp.telesul.model.Idioma;
import br.sp.telesul.model.Language;
import br.sp.telesul.model.Nivel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdk.nashorn.internal.runtime.Undefined;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
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

    private final org.slf4j.Logger logger = LoggerFactory.getLogger(ExportServiceImpl.class);

    public FuncionarioService getFuncionarioService() {
        return funcionarioService;
    }

    public void setFuncionarioService(FuncionarioService funcionarioService) {
        this.funcionarioService = funcionarioService;
    }

    @Override
    public void buildExcelDocument(String type, String[] columns, String[] columnsFormacao, String[] columnsIdiomas, String[] columnsCertificacoes, HttpServletRequest request, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        writeExcel("Funcionarios", columns, workbook);
        writeExcelFormacao("Formações", columnsFormacao, workbook);
        writeExcelIdiomas("Idiomas", columnsIdiomas, workbook);
        writeExcelCertificacoes("Certificações", columnsCertificacoes, workbook);

        downloadExcel(request, response, workbook);
    }

    public void writeExcel(String templateHead, String[] columns, HSSFWorkbook workbook) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                rowHeading.createCell(i).setCellValue(columns[i]);
            }

            for (int i = 0; i < columns.length; i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                stylerowHeading.setFillForegroundColor(HSSFColor.ROYAL_BLUE.index);
                stylerowHeading.setFillPattern(CellStyle.SOLID_FOREGROUND);
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

                try {
                    Cell email = row.createCell(5);
                    email.setCellValue(f.getEmail());
                } catch (NullPointerException ne) {

                }
                try {
                    Cell telefone = row.createCell(6);
                    telefone.setCellValue(f.getTelefone());

                } catch (NullPointerException e) {

                }
                try {
                    Cell celular = row.createCell(7);
                    celular.setCellValue(f.getCelular());
                } catch (NullPointerException e) {

                }

                r++;
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

        } catch (Exception e) {
            logger.error("Error gerate Report: " + e);
            System.out.println("Error" + e);
        }
    }

    public void writeExcelFormacao(String templateHead, String[] columns, HSSFWorkbook workbook) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                rowHeading.createCell(i).setCellValue(columns[i]);
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.length; i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                stylerowHeading.setFillForegroundColor(HSSFColor.ROYAL_BLUE.index);
                stylerowHeading.setFillPattern(CellStyle.SOLID_FOREGROUND);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            //Preencher linhas
            int r = 1;
            for (Funcionario f : funcionarios) {

                if (!f.getFormacoes().isEmpty()) {

                    for (Formacao fmc : f.getFormacoes()) {
                        if (!fmc.getInstituicao().isEmpty() || !fmc.getCurso().isEmpty() || !fmc.getNivel().isEmpty()) {
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

            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }
    }

    public void writeExcelCertificacoes(String templateHead, String[] columns, HSSFWorkbook workbook) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                rowHeading.createCell(i).setCellValue(columns[i]);
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.length; i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                stylerowHeading.setFillForegroundColor(HSSFColor.ROYAL_BLUE.index);
                stylerowHeading.setFillPattern(CellStyle.SOLID_FOREGROUND);
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

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }
//            String file = "C:/Users/ebranco.TELESULCORP/new.xls";
//            FileOutputStream out = new FileOutputStream(file);
//            workbook.write(out);
//            out.close();
//            workbook.close();
//            System.out.println("Excell write succesfully");
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
    }

    public void writeExcelIdiomas(String templateHead, String[] columns, HSSFWorkbook workbook) {
        try {
            List<Funcionario> funcionarios = funcionarioService.search();

            HSSFSheet sheet = workbook.createSheet(templateHead);

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                rowHeading.createCell(i).setCellValue(columns[i]);
            }
            //Estilizar o Cabeçalho - Stylesheet the heading
            for (int i = 0; i < columns.length; i++) {
                CellStyle stylerowHeading = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                font.setFontName(HSSFFont.FONT_ARIAL);
                font.setFontHeightInPoints((short) 11);
                stylerowHeading.setFont(font);
                stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
                stylerowHeading.setFillForegroundColor(HSSFColor.ROYAL_BLUE.index);
                stylerowHeading.setFillPattern(CellStyle.SOLID_FOREGROUND);
                rowHeading.getCell(i).setCellStyle(stylerowHeading);
            }
            //Preencher linhas
            int r = 1;
            for (Funcionario f : funcionarios) {

                if (!f.getIdiomas().isEmpty()) {

                    for (Idioma idm : f.getIdiomas()) {
                        try {
                            if (idm.getNivel() != null || idm.getNome() != null) {
                                Row row = sheet.createRow(r);
                                Cell Nome = row.createCell(0);
                                Nome.setCellValue(f.getNome());

                                Cell language = row.createCell(1);
                                language.setCellValue(idm.getNome().toString());

                                Cell nivel = row.createCell(2);
                                nivel.setCellValue(idm.getNivel().toString());
                                r++;
                            }
                        } catch (NullPointerException ne) {
                            System.out.println("Error " + ne);
                            break;
                        }

                    }

                }

            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

        } catch (Exception e) {
            System.out.println("Error" + e);
        }
    }

    public void downloadExcel(HttpServletRequest request, HttpServletResponse response, HSSFWorkbook wb) {
        ServletOutputStream stream = null;
        String fileName = "relatorio" + " " + new Date().getTime();
        fileName = fileName.replace(" ", "_");
        try {
            stream = response.getOutputStream();
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls");
            response.setContentType("application/vnd.ms-excel");
            wb.write(stream);
            System.out.println("Excel saved!!!!!");
        } catch (Exception e) {
            System.out.println("Error write excel" + e);
        } finally {
            if (stream != null) {
                try {
                    stream.close();
                    wb.close();
                } catch (IOException io) {
                    System.out.println("Error close Steram" + io);
                }

            }
        }

    }

    @Override
    public List<Funcionario> readExcelDocument() {
        try {
            List<Funcionario> funcionariosExcel = new ArrayList<>();
            FileInputStream fl = new FileInputStream(new File("C:\\Matriz1.xlsx"));
            Workbook wb = new XSSFWorkbook(fl);
            Sheet firstSheet = wb.getSheetAt(0);
            Iterator<Row> iterator = firstSheet.iterator();

            while (iterator.hasNext()) {
                Row nextRow = iterator.next();
                int row = nextRow.getRowNum();
                System.out.println("Row start" + row);
                Iterator<Cell> cellIterator = nextRow.cellIterator();
                Funcionario f = new Funcionario();
                Formacao fm = new Formacao();
                Idioma id = new Idioma();
                int column = 0;
                while (cellIterator.hasNext()) {
                    Cell nextCell = cellIterator.next();
                    int columnIndex = nextCell.getColumnIndex();
                    column = columnIndex;
                    System.out.println("Valor" + getCellValue(nextCell));
                    System.out.println("Index: " + columnIndex);
                    if (row > 0) {
                        switch (columnIndex) {
                            case 1:
                                f.setArea((String) getCellValue(nextCell));
                                break;
                            case 2:
                                Date dt = new Date();
                                if (!getCellValue(nextCell).toString().isEmpty()) {
                                    try {
                                        dt = DateUtil.getJavaDate((Double) getCellValue(nextCell));
                                    } catch (ClassCastException cce) {
                                        SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");

                                        dt = formatter.parse((String) getCellValue((nextCell)));
                                    };
                                }

                                f.setDtAdmissao(dt);
                                break;
                            case 3:
                                f.setCargo((String) getCellValue(nextCell));
                                break;
                            case 4:
                                f.setNome((String) getCellValue(nextCell));
                                break;
                            case 5:
                                f.setGestor((String) getCellValue(nextCell));
                                break;
                            case 9:
                                fm.setNivel((String) getCellValue(nextCell));
                                break;
                            case 10:
                                fm.setCurso((String) getCellValue(nextCell));
                                break;
                            case 11:
                                fm.setInstituicaoo((String) getCellValue(nextCell));
                                break;
                            case 12:
                                String typeEnum = (String) getCellValue(nextCell);
                                if (!typeEnum.isEmpty()) {
                                    id.setNome(Language.valueOf(typeEnum.trim()));
                                }

                                break;
                            case 13:
                                String typeEnumNivel = (String) getCellValue(nextCell);
                                if (!typeEnumNivel.isEmpty()) {
                                    id.setNivel(Nivel.valueOf(typeEnumNivel.trim()));
                                }

                                break;
                        }
                    }

                }

                List<Formacao> listFm = new ArrayList<>();
                listFm.add(fm);
                f.setFormacoes(listFm);

                List<Idioma> listId = new ArrayList<>();
                listId.add(id);
                f.setIdiomas(listId);

                if (row > 0) {
                    funcionariosExcel.add(f);
                }

            }
            wb.close();
            fl.close();
//            for (Funcionario fc : funcionariosExcel) {
//                System.out.println(fc.getNome());
//            }
            return funcionariosExcel;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    private Object getCellValue(Cell cell) {
        Object o = "";
        try {
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING:
                    o = cell.getStringCellValue();
                    break;
                case Cell.CELL_TYPE_BOOLEAN:
                    o = cell.getBooleanCellValue();
                    break;
                case Cell.CELL_TYPE_NUMERIC:
                    o = cell.getNumericCellValue();
                    break;
                case Cell.CELL_TYPE_BLANK:
                    o = "";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getMessage());
        }
        return o;
    }

    @Override
    public void singleReport(Long id, HttpServletRequest request, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        writeExcelSingle(id, workbook);
        downloadExcel(request, response, workbook);
    }

    public void writeExcelSingle(Long id, HSSFWorkbook workbook) {
        String[] columns = {"Nome", "Cargo", "Data de Admissao", "Área", "Gestor", "Email", "Telefone", "Celular"};
        String[] colFormacao = {"Formação", "Curso", "Instituição", "Cópia de Certificação"};
        String[] colIdioma = {"Idioma", "Nível"};
        String[] colCertificacao = {"Certificadora", "Exame", "Código", "Data de Exame", "Data de Validade", "Cópia de Certificado"};
        try {
            Funcionario funcionario = this.funcionarioService.searchById(id);

            HSSFSheet sheet = workbook.createSheet("Funcionário");

            Row rowHeading = sheet.createRow(0);
            for (int i = 0; i < columns.length; i++) {
                rowHeading.createCell(i).setCellValue(columns[i]);
            }
            stylizeHeader(rowHeading, workbook, columns);

            int r = 1;

            Row row = sheet.createRow(r);

            Cell Nome = row.createCell(0);
            Nome.setCellValue(funcionario.getNome());
            Cell cargo = row.createCell(1);
            cargo.setCellValue(funcionario.getCargo());

            Cell dtAdmissao = row.createCell(2);
            dtAdmissao.setCellValue(funcionario.getDtAdmissao());

            CellStyle styleDate = workbook.createCellStyle();
            HSSFDataFormat dfAdmissao = workbook.createDataFormat();
            styleDate.setDataFormat(dfAdmissao.getFormat("dd/mm/yyyy"));
            dtAdmissao.setCellStyle(styleDate);

            Cell area = row.createCell(3);
            area.setCellValue(funcionario.getArea());

            Cell gestor = row.createCell(4);
            gestor.setCellValue(funcionario.getGestor());

            try {
                Cell email = row.createCell(5);
                email.setCellValue(funcionario.getEmail());

            } catch (NullPointerException ne) {

            }
            try {
                Cell telefone = row.createCell(6);
                telefone.setCellValue(funcionario.getTelefone());

            } catch (NullPointerException ne) {

            }
            try {
                Cell celular = row.createCell(7);
                celular.setCellValue(funcionario.getCelular());
            } catch (NullPointerException ne) {

            }

            int auxRow = 12;
            for (Formacao form : funcionario.getFormacoes()) {
                if (!form.getCurso().isEmpty() || !form.getNivel().isEmpty() || !form.getInstituicao().isEmpty()) {
                    int headerFormacao = 11;
                    Row rowHeadingForm = sheet.createRow(headerFormacao);
                    for (int i = 0; i < colFormacao.length; i++) {
                        rowHeadingForm.createCell(i).setCellValue(colFormacao[i]);
                    }
                    stylizeHeader(rowHeadingForm, workbook, colFormacao);
                    int rowFormacao = 12;
                    Row rowFormacaoDatas = sheet.createRow(rowFormacao);
                    Cell formacao = rowFormacaoDatas.createCell(0);
                    Cell curso = rowFormacaoDatas.createCell(1);
                    Cell instituicao = rowFormacaoDatas.createCell(2);
                    Cell copy = rowFormacaoDatas.createCell(3);
                    for (Formacao f : funcionario.getFormacoes()) {
                        formacao.setCellValue(f.getNivel());
                        curso.setCellValue(f.getCurso());
                        instituicao.setCellValue(f.getInstituicao());
                        copy.setCellValue(f.getCopiaCertificado());
                        rowFormacao++;
                        auxRow = rowFormacao;
                    }
                    autoSizeColum(sheet, colFormacao);
                }
            }
            for (Idioma i : funcionario.getIdiomas()) {
                try {
                    if (!i.getNome().toString().isEmpty() && !i.getNivel().toString().isEmpty()) {
                        int headerIdiomas = auxRow + 9;
                        Row rowHeadingIdioma = sheet.createRow(headerIdiomas);
                        for (int j = 0; j < colIdioma.length; j++) {
                            rowHeadingIdioma.createCell(j).setCellValue(colIdioma[j]);
                        }
                        stylizeHeader(rowHeadingIdioma, workbook, colIdioma);
                        int rowIdioma = headerIdiomas + 1;
                        Row rowIdiomasDatas = sheet.createRow(rowIdioma);
                        Cell nivelIdm = rowIdiomasDatas.createCell(0);
                        Cell language = rowIdiomasDatas.createCell(1);
                        for (Idioma j : funcionario.getIdiomas()) {
                            nivelIdm.setCellValue(j.getNivel().toString());
                            language.setCellValue(j.getNome().toString());
                            rowIdioma++;
                            auxRow = rowIdioma;
                        }
                        autoSizeColum(sheet, colIdioma);
                    }
                } catch (NullPointerException ne) {
                    logger.error("Idiomas" + ne);
                    break;
                }

            }

            if (funcionario.getCertificacoes().size() > 0) {
                int headerCertificacao = auxRow + 9;
                Row rowHeadingCert = sheet.createRow(headerCertificacao);
                for (int j = 0; j < colCertificacao.length; j++) {
                    rowHeadingCert.createCell(j).setCellValue(colCertificacao[j]);
                }
                stylizeHeader(rowHeadingCert, workbook, colCertificacao);
                int rowCert = headerCertificacao + 1;
                Row rowCertDatas = sheet.createRow(rowCert);
                Cell certificadora = rowCertDatas.createCell(0);
                Cell exame = rowCertDatas.createCell(1);
                Cell codigo = rowCertDatas.createCell(2);
                Cell dtExame = rowCertDatas.createCell(3);
                dtExame.setCellStyle(styleDate);
                Cell dtValidade = rowCertDatas.createCell(4);
                dtValidade.setCellStyle(styleDate);
                Cell copia = rowCertDatas.createCell(5);

                for (Certificacao c : funcionario.getCertificacoes()) {
                    certificadora.setCellValue(c.getEmpresa());
                    exame.setCellValue(c.getNome());
                    codigo.setCellValue(c.getCodigo());
                    dtExame.setCellValue(c.getDtExame());
                    dtValidade.setCellValue(c.getDtValidade());
                    copia.setCellValue(c.getCopia());

                }
                autoSizeColum(sheet, colCertificacao);
            }

            //r++;
        } catch (Exception e) {
            logger.error("Error Writing Single Report: " + e);
            System.out.println("rror Writing Single Report: " + e);
        }
    }

    public void stylizeHeader(Row rowHeading, HSSFWorkbook workbook, String[] columns) {
        for (int i = 0; i < columns.length; i++) {
            CellStyle stylerowHeading = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            font.setFontName(HSSFFont.FONT_ARIAL);
            font.setFontHeightInPoints((short) 11);
            stylerowHeading.setFont(font);
            stylerowHeading.setVerticalAlignment(CellStyle.ALIGN_CENTER);
            stylerowHeading.setFillForegroundColor(HSSFColor.ROYAL_BLUE.index);
            stylerowHeading.setFillPattern(CellStyle.SOLID_FOREGROUND);
            rowHeading.getCell(i).setCellStyle(stylerowHeading);
        }
    }

    public void autoSizeColum(HSSFSheet sheet, String[] columns) {
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }
    }

    public String blank() {
        return "";
    }
}
