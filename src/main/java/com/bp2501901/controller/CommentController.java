package com.bp2501901.controller;

import com.bp2501901.model.dao.CommentDAO;
import com.bp2501901.model.dto.CommentDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/comment.do")
public class CommentController extends HttpServlet {

    // 댓글 폼 전송(POST) 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 1. 보안: 세션 확인 (로그인한 사용자만)
        HttpSession session = req.getSession();
        String writerId = (String) session.getAttribute("UserId");

        if (writerId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. 폼 데이터 받기
        String bnum = req.getParameter("bnum"); // 어느 게시글의 댓글인지
        String content = req.getParameter("content");

        // 3. DTO에 저장
        CommentDTO dto = new CommentDTO();
        dto.setBnum(Integer.parseInt(bnum)); // bnum은 int 타입
        dto.setContent(content);
        dto.setWriter_id(writerId); // 세션에서 가져온 ID

        // 4. DAO로 DB에 삽입
        CommentDAO dao = new CommentDAO();
        int result = dao.addComment(dto);
        dao.close();

        // 5. 결과와 상관없이 원래 보던 게시글(view.do)로 리다이렉트
        resp.sendRedirect("view.do?num=" + bnum);
    }
}