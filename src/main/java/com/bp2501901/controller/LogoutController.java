package com.bp2501901.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout.do")
public class LogoutController extends HttpServlet {

    // 로그아웃은 보통 링크(GET 방식)로 요청하므로 doGet()을 오버라이드합니다.
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. 세션(Session)을 가져옵니다.
        HttpSession session = req.getSession();

        // 2. 세션을 무효화(invalidate)합니다. (세션에 저장된 모든 정보 삭제)
        session.invalidate();

        // 3. 메인 페이지(index.jsp)로 리다이렉트합니다.
        resp.sendRedirect("index.jsp");
    }
}