package com.bp2501901.model.dao;

import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.util.DBConnPool;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BoardDAO extends DBConnPool {

    public BoardDAO() {
        super();
    }

    // 1. 게시판 목록 조회 (전체)
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
        } catch (Exception e) {
            System.out.println("Board List Select Error");
            e.printStackTrace();
        }
        return boardList;
    }

    // 2. 게시글 작성 (수정됨: sfile 추가)
    public int insertBoard(BoardDTO dto) {
        int result = 0;
        // sfile 컬럼 추가
        String sql = "INSERT INTO board (category, title, content, writer_id, sfile) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getCategory());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getWriter_id());
            psmt.setString(5, dto.getSfile()); // 파일명 (없으면 null)
            result = psmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("Board Insert Error");
            e.printStackTrace();
        }
        return result;
    }

    // 3. 조회수 증가
    public void updateVisitCount(String num) {
        String sql = "UPDATE board SET visitcount = visitcount + 1 WHERE num = ?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);
            psmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("VisitCount Update Error");
            e.printStackTrace();
        }
    }

    // 4. 상세보기
    public BoardDTO getBoardView(String num) {
        BoardDTO dto = null;
        String sql = "SELECT B.*, M.name AS writer_name "
                + " FROM board B INNER JOIN member M ON B.writer_id = M.id WHERE B.num = ?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);
            rs = psmt.executeQuery();
            if (rs.next()) {
                dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setCategory(rs.getString("category"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriter_id(rs.getString("writer_id"));
                dto.setPostdate(rs.getTimestamp("postdate"));
                dto.setEditdate(rs.getTimestamp("editdate"));
                dto.setVisitcount(rs.getInt("visitcount"));
                dto.setWriter_name(rs.getString("writer_name"));
            }
        } catch (Exception e) {
            System.out.println("Board View Select Error");
            e.printStackTrace();
        }
        return dto;
    }

    // 5. 삭제
    public int deleteBoard(String num) {
        int result = 0;
        String sql = "DELETE FROM board WHERE num = ?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, num);
            result = psmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("Board Delete Error");
            e.printStackTrace();
        }
        return result;
    }

    // 6. 수정 (UPDATE)
    public int updateBoard(BoardDTO dto) {
        int result = 0;
        String sql = "UPDATE board SET category=?, title=?, content=?, editdate=NOW() WHERE num=?";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getCategory());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setInt(4, dto.getNum());
            result = psmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("Board Update Error");
            e.printStackTrace();
        }
        return result;
    }

    // 7. 메인 화면용 최신 게시글 3개 조회
    public List<BoardDTO> getRecentList() {
        List<BoardDTO> boardList = new ArrayList<>();
        String sql = "SELECT B.*, M.name AS writer_name "
                + " FROM board B INNER JOIN member M ON B.writer_id = M.id "
                + " ORDER BY B.num DESC LIMIT 3";
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
                dto.setVisitcount(rs.getInt("visitcount"));
                dto.setWriter_name(rs.getString("writer_name"));
                boardList.add(dto);
            }
        } catch (Exception e) {
            System.out.println("Recent List Error");
            e.printStackTrace();
        }
        return boardList;
    }

    // 8. 마이페이지용 내가 쓴 글 목록 조회
    public List<BoardDTO> getMyList(String userId) {
        List<BoardDTO> boardList = new ArrayList<>();
        String sql = "SELECT * FROM board WHERE writer_id = ? ORDER BY num DESC";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setCategory(rs.getString("category"));
                dto.setTitle(rs.getString("title"));
                dto.setPostdate(rs.getTimestamp("postdate"));
                dto.setVisitcount(rs.getInt("visitcount"));
                boardList.add(dto);
            }
        } catch (Exception e) {
            System.out.println("My List Error");
            e.printStackTrace();
        }
        return boardList;
    }

    // 9. 전체 게시글 수 조회 (페이징용)
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;
        String query = "SELECT COUNT(*) FROM board";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);
        } catch (Exception e) {
            System.out.println("Count Error");
            e.printStackTrace();
        }
        return totalCount;
    }

    // 10. 페이징된 게시글 목록 조회
    public List<BoardDTO> selectListPage(Map<String, Object> map) {
        List<BoardDTO> boardList = new ArrayList<>();
        String query = "SELECT B.*, M.name AS writer_name "
                + " FROM board B INNER JOIN member M ON B.writer_id = M.id ";

        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY num DESC LIMIT ?, ?";

        try {
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, (int) map.get("start"));
            psmt.setInt(2, (int) map.get("pageSize"));
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
        } catch (Exception e) {
            System.out.println("Paging List Error");
            e.printStackTrace();
        }
        return boardList;
    }
}