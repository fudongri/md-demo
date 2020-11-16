package com.transsnet.db;

import com.transsnet.entity.Table;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author: fdr
 */
public class JooqDbFileGenerator {

    //datasource
//    private static final String url = "jdbc:mysql://10.240.36.211:3306/test?useUnicode=true&characterEncoding=utf8&&useSSL=false";
//    private static final String username = "root";
//    private static final String pwd = "Transsnet_123";
    //根据需要修改，数据库schema
//    private static final String DB_SCHEMA = "`laf`";
    private static final String url = "jdbc:mysql://10.200.120.100:3306/cncs?useUnicode=true&characterEncoding=utf8&&useSSL=false";
    private static final String username = "root";
    private static final String pwd = "123456";
    private static final String DB_SCHEMA = "`cncs`";


    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        String path = System.getProperty("user.dir") + "/db/";
        System.out.println("文件输出路径:" + path);
        String fileName = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now()) + ".sql";
        //表必须有主键
        start(path + fileName);
    }


    public static void start(String exportPath) throws Exception {
        //需要转换的表
        List<Table> tables = getTableList();
//        System.out.println(tables);

        setDdl(tables);
        System.out.println(tables);
        System.out.println(tables.size());
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
        String sql = "SHOW TABLES";
        List<String> tableNameList = queryRunner.query(connection, sql, new ColumnListHandler<>());
        DbUtils.closeQuietly(connection);
        return tableNameList.stream().map(Table::new).collect(Collectors.toList());
    }

    private static void setDdl(List<Table> tables) throws Exception {
        Connection connection = getConnection();
        QueryRunner queryRunner = new QueryRunner();
        tables.forEach(table -> {
            String sql = "SHOW CREATE TABLE " + table.getName();
            try {
                Map<String, Object> map = queryRunner.query(connection, sql, new MapHandler());
                table.setDdl(map.get("CREATE TABLE") + "");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
        DbUtils.closeQuietly(connection);
    }

    private static void write2File(List<Table> tables, String exportPath) throws Exception {
        StringBuilder outSb = new StringBuilder();
        tables.forEach(table -> {
            StringBuilder sb = new StringBuilder();
            sb.append("\n-- ----------------------------");
            sb.append("\n-- Table structure for ").append(table.getName());
            sb.append("\n-- ----------------------------");
            sb.append("\nDROP TABLE IF EXISTS " + DB_SCHEMA + ".`").append(table.getName()).append("`;\n");
            String ddl = table.getDdl();
            ddl = ddl.replace("CREATE TABLE ", "CREATE TABLE " + DB_SCHEMA + ".");
            ddl = ddl.replaceAll("(PRIMARY KEY.*?\\))[\\s\\S]*", "$1\n);");
            sb.append(ddl).append("\n");
            outSb.append(sb);
        });

        FileUtils.writeStringToFile(new File(exportPath), outSb.toString(), "UTF-8");
    }
}
