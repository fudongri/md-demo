package com.transsnet.md;

import com.transsnet.md.entity.Column;
import com.transsnet.md.entity.Table;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

/**
 * mysql表转换成markdown文档
 *
 * @author fdr
 */
public class MdGenerator {

    //datasource
    private static final String url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8&&useSSL=false";
    private static final String username = "root";
    private static final String pwd = "123456";

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        String path = System.getProperty("user.dir") + "/genFiles/";
        System.out.println("文件输出路径:" + path);
        String fileName = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now()) + ".md";
        start(path + fileName);
    }


    public static void start(String exportPath) throws Exception {
        //需要转换的表
        List<Table> tables = getTableList();
//        System.out.println(tables);

        setTableColumns(tables);
        System.out.println(tables);
        //输出
        write2File(tables, exportPath);
        System.out.println("执行完毕...");
    }

    private static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url, username, pwd);
    }

    private static List<Table> getTableList() throws Exception {
        Connection connection = getConnection();
        QueryRunner queryRunner = new QueryRunner();
        List<String> tableNameList = queryRunner.query(connection, "SHOW TABLES", new ColumnListHandler<>());
        DbUtils.closeQuietly(connection);
        return tableNameList.stream().map(Table::new).collect(Collectors.toList());
    }


    private static void setTableColumns(List<Table> tables) throws Exception {
        Connection connection = getConnection();
        QueryRunner queryRunner = new QueryRunner();
        tables.forEach(table -> {
            String sql = "SHOW FULL COLUMNS FROM " + table.getName();
            try {
                List<Column> columns = queryRunner.query(connection, sql, new BeanListHandler<>(Column.class));
                table.setColumns(columns);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
        DbUtils.closeQuietly(connection);
    }

    private static void write2File(List<Table> tables, String exportPath) throws Exception {
        StringBuilder outSb = new StringBuilder();
        String outStr = tables.stream().map(table -> {
            StringBuilder sb = new StringBuilder();
            sb.append("\n***表名：*** ").append(table.getName()).append("\n\n");
            sb.append("|字段|类型|说明|\n");
            sb.append("|:------|:------|:------|\n");
            List<Column> columns = table.getColumns();
            String columnStr = columns.stream().map(column ->
                    sb.append("|").append(column.getField()).append("|").append(column.getType())
                            .append("|").append(column.getComment()).append("|\n").toString()
            ).collect(Collectors.joining());

            outSb.append(columnStr);
            return outSb.toString();
        }).collect(Collectors.joining());

        FileUtils.writeStringToFile(new File(exportPath), outStr, "UTF-8");
    }

}
