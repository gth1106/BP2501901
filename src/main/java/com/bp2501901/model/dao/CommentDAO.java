package com.bp2501901.model.dao;

import com.bp2501901.model.dto.CommentDTO;
import com.bp2501901.util.DBConnPool;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends DBConnPool {

    public CommentDAO() {
        super();
    }

    /**
     * 특정 게시글(bnum)의 댓글 목록을 조회
     */
    public List<CommentDTO> getCommentList(String bnum) {
        List<CommentDTO> cmtList = new ArrayList<>();

        // comment(C)와 member(M) 테이블을 JOIN
        String sql = "SELECT C.*, M.name AS writer_name "
                + " FROM comment C INNER JOIN member M "
                + " ON C.writer_id = M.id "
                + " WHERE C.bnum = ? "
                + " ORDER BY C.cnum ASC"; // 댓글 오름차순

        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, bnum);
            rs = psmt.executeQuery();

            while(rs.next()) {
                CommentDTO dto = new CommentDTO();
                dto.setCnum(rs.getInt("cnum"));
                dto.setBnum(rs.getInt("bnum"));
                dto.setWriter_id(rs.getString("writer_id"));
                dto.setContent(rs.getString("content"));
                dto.setPostdate(rs.getTimestamp("postdate"));
                dto.setWriter_name(rs.getString("writer_name"));

                cmtList.add(dto);
            }
            psmt.close();

        } catch (Exception e) {
            System.out.println("Comment List Select Error");
            e.printStackTrace();
        }
        return cmtList;
    }

    /**
     * 댓글 작성
     */
    public int addComment(CommentDTO dto) {
        int result = 0;
        String sql = "INSERT INTO comment (bnum, writer_id, content) "
                + " VALUES (?, ?, ?)";
        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setInt(1, dto.getBnum());
            psmt.setString(2, dto.getWriter_id()); // Controller가 Session에서 가져온 ID
            psmt.setString(3, dto.getContent());

            result = psmt.executeUpdate();
            psmt.close();

        } catch (Exception e) {
            System.out.println("Comment Insert Error");
            e.printStackTrace();
        }
        return result;
    }

    // TODO: 댓글 수정, 삭제 메서드
    /**
     * 댓글 삭제 (★ 추가된 메서드)
     * @param cnum (삭제할 댓글 번호)
     * @param writer_id (삭제 요청자 ID - 본인 확인용)
     * @return 1 (성공) or 0 (실패)
     */
    public int deleteComment(String cnum, String writer_id) {
        int result = 0;
        // 본인 댓글만 삭제할 수 있도록 쿼리문에 writer_id 조건 추가
        String sql = "DELETE FROM comment WHERE cnum = ? AND writer_id = ?";

        try {
            PreparedStatement psmt = con.prepareStatement(sql);
            psmt.setString(1, cnum);
            psmt.setString(2, writer_id);

            result = psmt.executeUpdate(); // 1 (성공) or 0 (실패)

        } catch (Exception e) {
            System.out.println("Comment Delete Error");
            e.printStackTrace();
        }
        return result;
    }
}