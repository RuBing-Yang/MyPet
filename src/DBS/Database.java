package DBS;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;

public class Database {

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://bj-cynosdbmysql-grp-6pt17ydw.sql.tencentcdb.com:25522/users?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static Connection connection = null;
    private static Statement statement = null;

    public Statement getStatement() {
        return statement;
    }

    public Connection getConnection() {
        return connection;
    }

    public static void connectDb(String username, String password) {
        try {
            // 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);
            // 打开链接
            System.out.println("连接数据库...");
            connection = DriverManager.getConnection(DB_URL, username, password);
            // 执行查询
            System.out.println("实例化Statement对象...");
            statement = connection.createStatement();
            statement.executeQuery("USE DBS;\n");
        }
        catch (SQLException se) {
            // 处理 JDBC 错误
            System.out.println("JDBC Error");
            se.printStackTrace();
        }
        catch (Exception e) {
            // 处理 Class.forName 错误
            System.out.println("Class.forName Error");
            e.printStackTrace();
        }
        finally {
            System.out.println("Welcome");
        }
    }

    public void createDb(String username, Connection connection, String sql) {

    }

    public void deleteDb(String username,Connection connection, String sql) {

    }

    public void updateDb(String username, Statement statement, String sql) {

    }

    public String retrieveDb(String username, Statement statement, String sql) {
        return "";
    }
}
