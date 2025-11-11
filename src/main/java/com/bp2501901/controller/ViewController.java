package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dao.CommentDAO; // ★ 1. CommentDAO 임포트
import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.model.dto.CommentDTO; // ★ 2. CommentDTO 임포트

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List; // ★ 3. List 임포트

/**
 * 게시글 상세보기 페이지(/view.do) 요청을 처리하는 컨트롤러
 * 1. 게시글 내용 (BoardDAO)
 * 2. 댓글 목록 (CommentDAO)
 * 두 가지를 모두 DB에서 가져와 view.jsp로 전달합니다.
 */
@WebServlet("/view.do")
public class ViewController extends HttpServlet {

    // 링크 클릭(GET)을 처리
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // ★ 1. 컨트롤러 보안: 세션 확인
        HttpSession session = req.getSession();
        if (session.getAttribute("UserId") == null) {
            // 로그인하지 않은 사용자가 URL로 직접 접근 시
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. 파라미터(num) 받기 (e.g., /view.do?num=5)
        String num = req.getParameter("num");

        // 3. Model(DAO) 호출 - (1) 게시글 가져오기
        BoardDAO boardDao = new BoardDAO();
        boardDao.updateVisitCount(num);        // 조회수 1 증가
        BoardDTO dto = boardDao.getBoardView(num); // 게시글 상세 내용
        boardDao.close(); // BoardDAO 자원 반납

        // (JSP는 \n을 <br>로 바꿔야 줄바꿈이 됨)
        if(dto != null && dto.getContent() != null) {
            dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
        }

        // 4. Model(DAO) 호출 - (2) 댓글 목록 가져오기
        CommentDAO cmtDao = new CommentDAO();
        List<CommentDTO> commentList = cmtDao.getCommentList(num);
        cmtDao.close(); // CommentDAO 자원 반납

        // 5. View(JSP)로 2가지 데이터 전달 (request 객체 사용)
        req.setAttribute("dto", dto); // (1) 게시글
        req.setAttribute("commentList", commentList); // (2) 댓글 목록

        // 6. View(JSP)로 포워드
        RequestDispatcher rd = req.getRequestDispatcher("view.jsp");
        rd.forward(req, resp);
    }
}