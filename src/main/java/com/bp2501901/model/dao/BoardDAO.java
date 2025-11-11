package com.bp2501901.model.dao;

import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.util.DBConnPool;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO extends DBConnPool {

    public BoardDAO() {
        super();
    }

    /**
     * 1. 게시판 목록 조회
     */
    public List<BoardDTO> getBoardList() {
        List<BoardDTO> boardList = new ArrayList<>();
        String sql = "SELECT B.*, M.name AS writer_name "
                + " FROM board B INNER JOIN member M "
                + " ON B.writer_id = M.id "
                + " ORDER BY B.num DESC";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setCategory(rs.getString("category"));
                dto.setTitle(rs.getString("title"));
                dto.setWriter_id(rs.getString("writer_id"));
                dto.setPostdate(rs.getTimestamp("postdate"));
                dto.setEditdate(rs.getTimestamp("editdate"));
                dto.setVisitcount(rs.getInt("visitcount"));
                dto.setWriter_name(rs.getString("writer_name"));
                boardList.add(dto);
            }
            psmt.close();
        } catch (Exception e) {
            System.out.println("Board List Select Error");
            e.printStackTrace();
        }
        return boardList;
    }

    /**
     * 2. 게시글 작성 (Chapter 2)
     */
    public int insertBoard(BoardDTO dto) {
        int result = 0;
        String sql = "INSERT INTO board (category, title, content, writer_id) "
                + " VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getCategory());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getWriter_id()); // Controller가 Session에서 꺼낸 ID

            result = psmt.executeUpdate(); // 0 (실패) 또는 1 (성공)
            psmt.close();
        } catch (Exception e) {
            System.out.println("Board Insert Error");
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 3. 게시글 조회수 1 증가 (Chapter 3)
     */
    public void updateVisitCount(String num) {
        String sql = "UPDATE board SET visitcount = visitcount + 1 WHERE num = ?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);
            psmt.executeUpdate();
            psmt.close();
        } catch (Exception e) {
            System.out.println("VisitCount Update Error");
            e.printStackTrace();
        }
    }

    /**
     * 4. 게시글 상세보기 (Chapter 3)
     */
    public BoardDTO getBoardView(String num) {
        BoardDTO dto = null;
        String sql = "SELECT B.*, M.name AS writer_name "
                + " FROM board B INNER JOIN member M "
                + " ON B.writer_id = M.id "
                + " WHERE B.num = ?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);
            rs = psmt.executeQuery();

            if (rs.next()) {
                dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setCategory(rs.getString("category"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content")); // 내용
                dto.setWriter_id(rs.getString("writer_id"));
                dto.setPostdate(rs.getTimestamp("postdate"));
                dto.setEditdate(rs.getTimestamp("editdate")); // 수정 시간
                dto.setVisitcount(rs.getInt("visitcount"));
                dto.setWriter_name(rs.getString("writer_name")); // 작성자 이름
            }
            psmt.close();
        } catch (Exception e) {
            System.out.println("Board View Select Error");
            e.printStackTrace();
        }
        return dto;
    }
    /**
     * 5. 게시글 삭제 (★ 추가된 메서드)
     * @param num (삭제할 게시글 번호)
     * @return 1 (성공) or 0 (실패)
     */
    public int deleteBoard(String num) {
        int result = 0;
        String sql = "DELETE FROM board WHERE num = ?";

        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);

            result = psmt.executeUpdate(); // 1 (성공) or 0 (실패)

        } catch (Exception e) {
            System.out.println("Board Delete Error");
            e.printStackTrace();
        }
        return result;
    }
}