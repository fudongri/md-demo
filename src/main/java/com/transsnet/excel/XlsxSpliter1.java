package com.transsnet.excel;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @author fdr
 */
public class XlsxSpliter1 {

    public static void main(String[] args) throws Exception {
//        String fileName = "F:/aaa/easybuy-tb_black_list.xlsx";
        String fileName = "F:/aaa/palmcredit-tb_black_list.xlsx";
        splitXlsx(fileName);
    }


    //读取Xlsx
    public static void splitXlsx(String fileName) throws Exception {
        InputStream is = new FileInputStream(fileName);
        XSSFWorkbook workbook = new XSSFWorkbook(is);
        XSSFSheet xssfSheet = workbook.getSheetAt(0);
        List<List<String>> rows = new ArrayList<>();
        XSSFRow title = xssfSheet.getRow(0);
        List<String> titles = new ArrayList<>();
        for (int t = 0; t < title.getLastCellNum(); t++) {
            titles.add(title.getCell(t).getStringCellValue());
        }
        rows.add(titles);
        for (int row = 1; row <= xssfSheet.getLastRowNum(); row++) {
//            System.out.println("row:" + row);
            Row xssfRow = xssfSheet.getRow(row);
            if (xssfRow == null) {
                continue;
            }
            List<String> rowList = new ArrayList<>();
            for (int t = 0; t < title.getLastCellNum(); t++) {
                switch (xssfRow.getCell(t, Row.CREATE_NULL_AS_BLANK).getCellType()) {
                    case HSSFCell.CELL_TYPE_NUMERIC:
                        rowList.add(Double.valueOf(xssfRow.getCell(t).getNumericCellValue()).intValue() + "");
                        break;
                    case HSSFCell.CELL_TYPE_STRING:
                        rowList.add(xssfRow.getCell(t).getStringCellValue());
                        break;
                    case HSSFCell.CELL_TYPE_BOOLEAN:
                        rowList.add(xssfRow.getCell(t).getBooleanCellValue() + "");
                        break;
         /*           case HSSFCell.CELL_TYPE_FORMULA:

                        break;*/
                    default:
                        System.out.println("unsuported cell type");
                        break;
                }
            }
            rows.add(rowList);
            if (row % 1000 == 0) {
                writeXlsx(fileName.substring(0, fileName.lastIndexOf(".")) + "-" + (row / 1000) + ".xlsx", rows);
                rows.clear();
                rows.add(titles);
                System.out.println("row a:" + row);
            } else if (row == xssfSheet.getLastRowNum()) {
                writeXlsx(fileName.substring(0, fileName.lastIndexOf(".")) + "-" + (row / 1000 + 1) + ".xlsx", rows);
                System.out.println("row b:" + row);
            }
        }
    }


    //写入Xlsx
    public static void writeXlsx(String fileName, List<List<String>> rows) {
        try {
            System.out.println(fileName + "=========================================================");

            XSSFWorkbook wb = new XSSFWorkbook();
            XSSFSheet sheet = wb.createSheet();
            for (int i = 0; i < rows.size(); i++) {
                XSSFRow row = sheet.createRow(i);
                List<String> rowList = rows.get(i);
                for (int j = 0; j < rowList.size(); j++) {
                    XSSFCell cell = row.createCell(j);
                    cell.setCellValue(rowList.get(j));
                }
            }
            FileOutputStream outputStream = new FileOutputStream(fileName);
            wb.write(outputStream);
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
