package com.bp2501901.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 톰캣에서 설정한 DBCP(커넥션 풀)를 사용하기 위한 유틸리티 클래스
 * JNDI를 통해 'jdbc/BP2501901' 리소스를 찾아 Connection 객체를 반환합니다.
 */
public class DBConnPool {
    public Connection con;
    public Statement stmt;
    public ResultSet rs;

    public DBConnPool() {
        try {
            // 1. JNDI Context 초기화
            Context initCtx = new InitialContext();
            // 2. 'java:comp/env' 경로의 Context 가져오기 (톰캣 리소스 경로)
            Context ctx = (Context) initCtx.lookup("java:comp/env");
            // 3. 'jdbc/BP2501901' 이름의 DataSource(커넥션 풀) 찾기
            DataSource ds = (DataSource) ctx.lookup("jdbc/BP2501901");

            // 4. 커넥션 풀에서 Connection 객체 하나 빌려오기
            con = ds.getConnection();

            System.out.println("DBCP Connection Pool Success!");
        } catch (Exception e) {
            System.out.println("DBCP Connection Pool Failed...");
            e.printStackTrace();
        }
    }

    // DAO 클래스들이 이 클래스를 상속받아 사용한 후 자원을 반납하기 위한 메서드
    public void close() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close(); // Connection을 닫으면 풀(Pool)로 반납됨

            System.out.println("DBCP Connection Pool Resource Released.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}