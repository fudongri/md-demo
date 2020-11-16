package com.transsnet.sqllite;

import com.transsnet.sqllite.entity.Address;
import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author fdr
 */
public class SqliteToMysql {

    private static final String url = "jdbc:sqlite:D:\\IdeaProjects\\md-demo\\src\\main\\java\\com\\transsnet\\sqllite\\addressdb.db";

    static {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        String path = System.getProperty("user.dir") + "/sqlite/";
        System.out.println("文件输出路径:" + path);
        String fileName = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now()) + ".sql";
        start(path + fileName);

    }

    private static void start(String exportPath) throws Exception {
        Connection connection = getConnection();
        QueryRunner queryRunner = new QueryRunner();
        String sql = "SELECT *  FROM main.address";
        try {
            List<Address> addresses = queryRunner.query(connection, sql, new BeanListHandler<>(Address.class));
            System.out.println(addresses.size());
            write2File(addresses, exportPath);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        DbUtils.closeQuietly(connection);
    }

    private static void write2File(List<Address> addresses, String exportPath) throws IOException {
        StringBuilder outSb = new StringBuilder();
        addresses.forEach(address -> {
            StringBuilder sb = new StringBuilder();
            sb.append("insert into laf_address(id,state,town,area,street) values(");
            sb.append("\"").append(address.get_id()).append("\",");
            sb.append("\"").append(address.getState()).append("\",");
            sb.append("\"").append(address.getTown()).append("\",");
            sb.append("\"").append(address.getArea()).append("\",");
            sb.append("\"").append(address.getStreet()).append("\"");
            sb.append(");\n");
            outSb.append(sb);
        });

        FileUtils.writeStringToFile(new File(exportPath), outSb.toString(), "UTF-8");
    }

    private static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url);
    }

}
