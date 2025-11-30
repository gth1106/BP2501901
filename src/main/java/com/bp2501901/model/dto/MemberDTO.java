package com.bp2501901.model.dto;



/**
 * Member 테이블의 데이터를 전송하기 위한 DTO (Data Transfer Object)
 * (Java Bean / POJO)
 * - DB 테이블의 '컬럼'과 1:1로 매칭되는 '필드(변수)'를 가집니다.
 * - Getters/Setters 메서드를 가집니다.
 */
public class MemberDTO {
    // 1. 필드 (DB 컬럼과 일치)
    private String id;
    private String pass;
    private String name;
    private java.sql.Timestamp regdate; // regdate 컬럼 타입이 DATETIME이므로 Timestamp 사용p
    private String getMemberInfo;
    // 2. Getters and Setters (JSP나 다른 클래스에서 값을 읽고 쓸 때 사용)
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPass() {
        return pass;
    }
    public void setPass(String pass) {
        this.pass = pass;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public java.sql.Timestamp getRegdate() {
        return regdate;
    }
    public void setRegdate(java.sql.Timestamp regdate) {
        this.regdate = regdate;
    }
}