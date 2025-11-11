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

@WebServlet("/write.do")
public class WriteController extends HttpServlet {

    // 폼 전송(POST)을 처리
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

        // ★ 1. 컨트롤러 보안: 세션 확인
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        if (userId == null) {
            // 혹시라도 로그아웃 상태에서 비정상적 접근(POST) 시도 시
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. 폼 데이터(View)를 DTO(Model)에 저장
        BoardDTO dto = new BoardDTO();
        dto.setCategory(req.getParameter("category"));
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        dto.setWriter_id(userId); // ★ 폼이 아닌 세션에서 ID를 가져와 저장 (보안)

        // 3. DAO(Model)에 DTO 전달하여 DB에 삽입
        BoardDAO dao = new BoardDAO();
        int result = dao.insertBoard(dto);
        dao.close();

        // 4. 결과에 따라 View 선택 (목록으로 리다이렉트)
        if (result == 1) {
            // 글쓰기 성공
            resp.sendRedirect("list.do");
        } else {
            // 글쓰기 실패
            // (실제로는 "글쓰기에 실패했습니다." 알림창을 띄우는 것이 좋음)
            resp.sendRedirect("write.jsp");
        }
    }
}