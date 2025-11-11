package com.bp2501901.model.dto;

import java.sql.Timestamp;

/**
 * Board 테이블의 데이터를 전송하기 위한 DTO
 * 게시판 목록에서는 작성자 이름(member.name)도 필요하므로,
 * writer_name 필드를 추가하여 JOIN 쿼리 결과를 담습니다.
 */
public class BoardDTO {
    // Board 테이블의 컬럼
    private int num;
    private String category;
    private String title;
    private String content;
    private String writer_id; // FK (member.id)
    private Timestamp postdate;
    private int visitcount;
    private String ofile;
    private String sfile;
    private Timestamp editdate;

    public Timestamp getEditdate() {
        return editdate;
    }

    public void setEditdate(Timestamp editdate) {
        this.editdate = editdate;
    }



    // Member 테이블에서 JOIN 해올 컬럼
    private String writer_name; // 작성자 이름

    // --- Getters and Setters ---
    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getWriter_id() {
        return writer_id;
    }
    public void setWriter_id(String writer_id) {
        this.writer_id = writer_id;
    }
    public Timestamp getPostdate() {
        return postdate;
    }
    public void setPostdate(Timestamp postdate) {
        this.postdate = postdate;
    }
    public int getVisitcount() {
        return visitcount;
    }
    public void setVisitcount(int visitcount) {
        this.visitcount = visitcount;
    }
    public String getOfile() {
        return ofile;
    }
    public void setOfile(String ofile) {
        this.ofile = ofile;
    }
    public String getSfile() {
        return sfile;
    }
    public void setSfile(String sfile) {
        this.sfile = sfile;
    }
    public String getWriter_name() {
        return writer_name;
    }
    public void setWriter_name(String writer_name) {
        this.writer_name = writer_name;
    }
}