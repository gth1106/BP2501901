package com.bp2501901.model.dao;

import com.bp2501901.model.dto.MemberDTO; // DTO 임포트
import com.bp2501901.util.DBConnPool;   // 3단계에서 만든 DBConnPool 임포트

import java.sql.PreparedStatement;

/**
 * Member 테이블에 접근하기 위한 DAO (Data Access Object)
 * DBConnPool을 상속하여 DBCP(커넥션 풀)를 사용합니다.
 */
public class MemberDAO extends DBConnPool { // DBConnPool 상속

    /**
     * 기본 생성자
     * 부모 클래스(DBConnPool)의 생성자를 호출하여 Connection 객체를 초기화합니다.
     */
    public MemberDAO() {
        super(); // 이 시점에 Connection 객체(con)가 생성됨
    }

    /**
     * Todo: 로그인 처리를 위한 getMember 메서드
     * @param uid 사용자 ID
     * @param upass 사용자 PW
     * @return 로그인 성공 시 MemberDTO 반환, 실패 시 null 반환
     */
    public MemberDTO getMember(String uid, String upass) {
        MemberDTO dto = null; // 리턴할 객체 초기화
        String sql = "SELECT * FROM member WHERE id = ? AND pass = ?"; // SQL 쿼리

        try {
            // PreparedStatement: SQL 인젝션 공격을 방지하는 가장 좋은 방법
            // con 객체는 부모 클래스(DBConnPool)로부터 물려받아 바로 사용 가능
            PreparedStatement psmt = con.prepareStatement(sql);

            // SQL 쿼리의 '?' (인파라미터)에 값을 채워넣음
            psmt.setString(1, uid);  // 첫 번째 '?'에 uid 변수 값
            psmt.setString(2, upass); // 두 번째 '?'에 upass 변수 값

            // 쿼리 실행 (SELECT 쿼리이므로 executeQuery)
            // rs (ResultSet) 객체도 부모 클래스에 선언되어 있음
            rs = psmt.executeQuery();

            if (rs.next()) { // 쿼리 결과가 있다면 (로그인 성공)
                // DTO 객체를 생성
                dto = new MemberDTO();

                // ResultSet(rs)에서 DTO로 값을 옮겨 담음
                dto.setId(rs.getString("id"));
                dto.setName(rs.getString("name"));
                dto.setRegdate(rs.getTimestamp("regdate"));
            }

            // ★ 올바른 패턴: 메서드 내부에서 psmt나 rs를 닫지 않는다.
            // psmt.close(); (X)

        } catch (Exception e) {
            System.out.println("Login Error");
            e.printStackTrace();
        }

        return dto; // 로그인 성공 시 DTO, 실패 시 null 반환
    }

    /**
     * Todo: 회원가입 처리를 위한 메서드 (INSERT)
     * @param dto (id, pass, name이 담긴 DTO)
     * @return 1 (성공) 또는 0 (실패)
     */
    public int insertMember(MemberDTO dto) {
        int result = 0;
        String sql = "INSERT INTO member (id, pass, name) VALUES (?, ?, ?)";

        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getPass());
            psmt.setString(3, dto.getName());

            // INSERT, UPDATE, DELETE 쿼리는 executeUpdate() 사용
            result = psmt.executeUpdate(); // 1(성공) 또는 0(실패) 반환

            // ★ 수정된 부분: psmt.close() 제거
            // psmt.close(); (X)

        } catch (Exception e) {
            System.out.println("Member Insert Error");
            e.printStackTrace();
        }

        return result;
    }
}