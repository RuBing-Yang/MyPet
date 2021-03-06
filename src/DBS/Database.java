package DBS;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.math.BigInteger;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;

public class Database {

    //static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    //static final String DB_URL = "jdbc:mysql://bj-cynosdbmysql-grp-6pt17ydw.sql.tencentcdb.com:25522/users?" +
           // "useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8&allowMultiQueries=true";

    private static Connection connection = null;
    private static Statement statement = null;
    private static PreparedStatement preparedStatement = null;

    public static Statement getStatement() {
        return statement;
    }

    public static Connection getConnection() {
        return connection;
    }

    public static int getId() {
        ResultSet rs = null;
        int res = -1;
        try {
            rs = preparedStatement.getGeneratedKeys();
            if (rs != null && rs.next()) res = ((BigInteger) rs.getObject(1)).intValue();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return res;
    }

    public static PreparedStatement getPreparedStatement() {
        return preparedStatement;
    }

    public static boolean connectDb() {
        //MyPoolingDataSource mpds = new MyPoolingDataSource();
        //mpds.connectDb();

        boolean suc = false;
        try {
            // 获取上下文
            Context initContext = new InitialContext();
            Context webContext = (Context)initContext.lookup("java:/comp/env");

            DataSource ds = (DataSource) webContext.lookup("jdbc/myJdbc");
            connection = ds.getConnection();

            /*// 注册 JDBC 驱动
            Class.forName(JDBC_DRIVER);
            // 打开链接
            System.out.println("连接数据库...");
            connection = DriverManager.getConnection(DB_URL, username, password);*/

            // 执行查询
            System.out.println("实例化Statement对象...");
            statement = connection.createStatement();
            statement.executeQuery("USE DBS;\n");
            suc = true;
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
            if (suc) System.out.println("Welcome!");
            else System.out.println("Failed to connect to db!");
        }
        return suc;
    }

    public static boolean createDb(String sql) {
        boolean suc = false;
        try {
            preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);;
            preparedStatement.executeUpdate();
            suc = true;
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
        catch (Exception e) {
            // 处理 Class.forName 错误
            System.out.println("Class.forName Error");
            e.printStackTrace();
        }
        finally {
            if (suc) System.out.println("【成功】" + sql);
        }
        return suc;
    }

    public static boolean deleteDb(String sql) {
        boolean suc = false;
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.executeUpdate();
            suc = true;
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
        catch (Exception e) {
            // 处理 Class.forName 错误
            System.out.println("Class.forName Error");
            e.printStackTrace();
        }
        finally {
            if (suc) System.out.println("【成功】" + sql);
        }
        return suc;
    }

    public static boolean updateDb(String sql) {
        boolean suc = false;
        try {
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.executeUpdate();
            suc = true;
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
        catch (Exception e) {
            // 处理 Class.forName 错误
            System.out.println("Class.forName Error");
            e.printStackTrace();
        }
        finally {
            if (suc) System.out.println("【成功】" + sql);
        }
        return suc;
    }

    public static ResultSet retrieveDb(String sql) {
        ResultSet rs = null;
        try {
            rs = statement.executeQuery(sql);
        }
        catch (SQLException se) {
            se.printStackTrace();
        }
        catch (Exception e) {
            // 处理 Class.forName 错误
            System.out.println("Class.forName Error");
            e.printStackTrace();
        }
        return rs;
    }

    public static boolean valid() throws SQLException {
        if (statement == null || connection == null || connection.isClosed()) {
            connectDb();
        }
        return statement != null && connection != null;
    }

}
