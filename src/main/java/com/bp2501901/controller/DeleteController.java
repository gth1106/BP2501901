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

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet {

    // 링크(<a>) 태그는 GET 방식
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 파라미터(게시글 번호) 받기
        String num = req.getParameter("num");

        // 2. 컨트롤러 보안: 세션 확인
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        if (userId == null) {
            // 2-1. 비로그인 사용자가 URL로 접근 시
            resp.sendRedirect("login.jsp");
            return;
        }

        // 3. DAO(Model) 호출
        BoardDAO dao = new BoardDAO();

        // 3-1. (중요) DB에서 현재 게시글의 작성자 ID를 가져옴
        //      세션의 userId와 비교하여 본인 글이 맞는지 "서버"에서 한번 더 확인함
        BoardDTO dto = dao.getBoardView(num); // 상세보기 메서드 재활용

        int result = 0;
        if (dto != null && userId.equals(dto.getWriter_id())) {
            // 3-2. 본인 글이 맞으면, 삭제 메서드 호출
            result = dao.deleteBoard(num);
        } else {
            // 3-3. 본인 글이 아니거나 (e.g., URL 조작), dto가 null(없는 글)인 경우
            // (여기서는 아무것도 하지 않고 그냥 넘어감, result = 0)
        }

        dao.close(); // DAO 자원 반납

        // 4. 결과에 따라 View(JSP) 선택
        if (result == 1) {
            // 삭제 성공: 게시판 목록으로 리다이렉트
            resp.sendRedirect("list.do");
        } else {
            // 삭제 실패: (본인 글이 아님, DB 오류 등)
            // "삭제에 실패했습니다." 알림창 띄우고 이전 페이지(상세보기)로 복귀

            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('삭제에 실패했습니다. (작성자 불일치 또는 DB 오류)');");
            out.println("history.back();"); // 브라우저의 '뒤로 가기' 실행
            out.println("</script>");
            out.close();
        }
    }
}