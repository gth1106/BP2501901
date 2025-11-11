package com.bp2501901.model.dto;

import java.sql.Timestamp;

public class CommentDTO {
    // comment 테이블 컬럼
    private int cnum;
    private int bnum; // 게시글 번호 (FK)
    private String writer_id; // 작성자 ID (FK)
    private String content;
    private Timestamp postdate;

    // member 테이블 JOIN용
    private String writer_name;

    // --- Getters and Setters ---
    public int getCnum() {
        return cnum;
    }
    public void setCnum(int cnum) {
        this.cnum = cnum;
    }
    public int getBnum() {
        return bnum;
    }
    public void setBnum(int bnum) {
        this.bnum = bnum;
    }
    public String getWriter_id() {
        return writer_id;
    }
    public void setWriter_id(String writer_id) {
        this.writer_id = writer_id;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Timestamp getPostdate() {
        return postdate;
    }
    public void setPostdate(Timestamp postdate) {
        this.postdate = postdate;
    }
    public String getWriter_name() {
        return writer_name;
    }
    public void setWriter_name(String writer_name) {
        this.writer_name = writer_name;
    }
}