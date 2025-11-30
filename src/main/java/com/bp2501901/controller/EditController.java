package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/edit.do")
public class EditController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 로그인 확인
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. 게시글 번호 받기
        String num = req.getParameter("num");

        // 3. 기존 게시글 정보 가져오기
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.getBoardView(num);
        dao.close();

        // 4. 본인 확인 (작성자만 수정 가능)
        if (dto != null && userId.equals(dto.getWriter_id())) {
            req.setAttribute("dto", dto);
            req.getRequestDispatcher("edit.jsp").forward(req, resp);
        } else {
            // 작성자가 아니면 경고창 띄우고 뒤로가기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>alert('수정 권한이 없습니다.'); history.back();</script>");
            out.close();
        }
    }
}