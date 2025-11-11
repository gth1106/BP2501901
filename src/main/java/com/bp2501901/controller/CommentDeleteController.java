package com.bp2501901.controller;

import com.bp2501901.model.dao.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deleteComment.do")
public class CommentDeleteController extends HttpServlet {

    // 링크(<a>) 태그는 GET 방식
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 보안: 세션 확인 (로그인한 사용자 ID 가져오기)
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        // 2. 파라미터 받기
        String cnum = req.getParameter("cnum"); // 삭제할 댓글 번호
        String bnum = req.getParameter("bnum"); // 돌아갈 게시글 번호

        if (userId == null) {
            // 2-1. 비로그인 사용자가 URL로 접근 시
            resp.sendRedirect("login.jsp");
            return;
        }

        // 3. DAO(Model) 호출
        CommentDAO dao = new CommentDAO();
        int result = dao.deleteComment(cnum, userId); // cnum과 userId를 둘 다 보냄
        dao.close();

        // 4. 결과 처리
        if (result == 1) {
            // 삭제 성공: 원래 보던 게시글(view.do)로 리다이렉트
            resp.sendRedirect("view.do?num=" + bnum);
        } else {
            // 삭제 실패: (본인 댓글이 아니거나 DB 오류)
            // "삭제에 실패했습니다." 알림창 띄우고 이전 페이지(상세보기)로 복귀
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter out = resp.getWriter();
            out.println("<script>");
            out.println("alert('댓글 삭제에 실패했습니다. (작성자 불일치 등)');");
            out.println("history.back();"); // 브라우저의 '뒤로 가기' 실행
            out.println("</script>");
            out.close();
        }
    }
}