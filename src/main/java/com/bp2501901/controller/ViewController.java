package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dao.CommentDAO;
import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.model.dto.CommentDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/view.do")
public class ViewController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 보안: 로그인 체크
        HttpSession session = req.getSession();
        if (session.getAttribute("UserId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String num = req.getParameter("num");

        // 2. 게시글 상세 정보 가져오기
        BoardDAO boardDao = new BoardDAO();
        boardDao.updateVisitCount(num);        // 조회수 증가
        BoardDTO dto = boardDao.getBoardView(num); // 내용 가져오기
        boardDao.close();

        // 줄바꿈 처리 (\n -> <br>)
        if(dto != null && dto.getContent() != null) {
            dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
        }

        // 3. 댓글 목록 가져오기 (아직 댓글이 없어도 에러 안 나게 처리됨)
        CommentDAO cmtDao = new CommentDAO();
        List<CommentDTO> commentList = cmtDao.getCommentList(num);
        cmtDao.close();

        // 4. JSP로 전달
        req.setAttribute("dto", dto);
        req.setAttribute("commentList", commentList);

        RequestDispatcher rd = req.getRequestDispatcher("view.jsp");
        rd.forward(req, resp);
    }
}