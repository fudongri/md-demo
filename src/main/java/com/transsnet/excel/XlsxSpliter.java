//package com.transsnet.excel;
//
//import org.apache.poi.hssf.usermodel.HSSFCell;
//import org.apache.poi.openxml4j.opc.OPCPackage;
//import org.apache.poi.ss.usermodel.*;
//import org.apache.poi.xssf.usermodel.XSSFCell;
//import org.apache.poi.xssf.usermodel.XSSFRow;
//import org.apache.poi.xssf.usermodel.XSSFSheet;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//
//import java.io.*;
//import java.util.*;
//
///**
// * @author fdr
// */
//public class XlsxSpliter {
//
//    public static List<List<String>> read(String path, int index) throws Exception {
//        OPCPackage pkg = OPCPackage.open(path);
//        Workbook workbook = new XSSFWorkbook(pkg);
//        Sheet sheet = workbook.getSheetAt(index);
//        List<List<String>> result = new ArrayList<>();
//        for (int i = 0; i < sheet.getLastRowNum(); i++) {
//            Row row = sheet.getRow(i);
//            List<String> list = new ArrayList<>();
//            Iterator<Cell> cells = row.cellIterator();
//            Cell cell = cells.next();
//            System.out.println("Cell #" + cell.getColumnIndex());
//            switch (cell.getCellType()) {
//                case HSSFCell.CELL_TYPE_NUMERIC:
//                    System.out.println(cell.getNumericCellValue());
//                    break;
//                case HSSFCell.CELL_TYPE_STRING:
//                    System.out.println(cell.getStringCellValue());
//                    break;
//                case HSSFCell.CELL_TYPE_BOOLEAN:
//                    System.out.println(cell.getBooleanCellValue());
//                    break;
//                case HSSFCell.CELL_TYPE_FORMULA:
//                    System.out.println(cell.getCellFormula());
//                    break;
//                default:
//                    System.out.println("unsuported cell type");
//                    break;
//            }
//            result.add(list);
//        }
//        return result;
//    }
//
//
//    //读取Xlsx
//    public static List<Row> readXlsx(String fileName) throws Exception {
//        InputStream is = new FileInputStream(fileName);
//        XSSFWorkbook workbook = new XSSFWorkbook(is);
//        XSSFSheet xssfSheet = workbook.getSheetAt(1);
//        List<Row> rows = new ArrayList<>();
//        XSSFRow title = xssfSheet.getRow(0);
//        rows.add(title);
//        for (int row = 1; row <= xssfSheet.getLastRowNum(); row++) {
//            XSSFRow xssfRow = xssfSheet.getRow(row);
//            if (xssfRow == null) {
//                continue;
//            }
//            rows.add(xssfRow);
//            if(row == 1000)
//        }
//    }
//
//
//    //写入Xlsx
//    public static void writeXlsx(String fileName, List<Row> rows) {
//        try {
//            XSSFWorkbook wb = new XSSFWorkbook();
//            XSSFSheet sheet = wb.createSheet("" + 1);
//            for (int i = 0; i < rows.size(); i++) {
//                XSSFRow row = sheet.createRow(i);
//                Row cells = rows.get(i);
//                for (int j = 0; j < cells.getLastCellNum(); j++) {
//                    XSSFCell cell = row.createCell(j);
//                    cell.setCellType(Cell.CELL_TYPE_STRING);
//                    cell.setCellValue(cells.getCell(j, Row.CREATE_NULL_AS_BLANK).getStringCellValue());
//                }
//            }
//            FileOutputStream outputStream = new FileOutputStream(fileName);
//            wb.write(outputStream);
//            outputStream.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//
//
//}
