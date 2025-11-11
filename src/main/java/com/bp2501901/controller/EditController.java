package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * /edit.do 요청을 받아, 수정할 게시글의 "기존 정보"를 DB에서 가져와
 * edit.jsp (수정 폼)으로 전달(forward)하는 컨트롤러
 */
@WebServlet("/edit.do")
public class EditController extends HttpServlet {

    // "수정" 링크는 GET 방식
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 파라미터(게시글 번호) 받기
        String num = req.getParameter("num");

        // 2. 컨트롤러 보안: 세션 확인
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 3. DAO(Model) 호출
        BoardDAO dao = new BoardDAO();
        BoardDTO dto = dao.getBoardView(num); // 상세보기 메서드 재활용
        dao.close(); // DAO 자원 반납

        // 4. 본인 글 여부 2차 검증 (보안)
        if (dto != null && userId.equals(dto.getWriter_id())) {
            // 4-1. 본인 글이 맞음 -> View(JSP)로 DTO 전달 및 포워드
            req.setAttribute("dto", dto);
            RequestDispatcher rd = req.getRequestDispatcher("edit.jsp");
            rd.forward(req, resp);
        } else {
            // 4-2. 본인 글이 아님 (URL 조작) 또는 게시글이 없음
            // 알림창 띄우고 '목록'으로 튕겨내기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('수정 권한이 없거나 존재하지 않는 게시글입니다.');");
            out.println("location.href = 'list.do';");
            out.println("</script>");
            out.close();
        }
    }
}