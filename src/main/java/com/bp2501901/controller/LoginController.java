package com.bp2501901.controller;

import com.bp2501901.model.dao.MemberDAO;
import com.bp2501901.model.dto.MemberDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("userId");
        String pass = req.getParameter("userPass");

        MemberDAO dao = new MemberDAO();
        MemberDTO dto = dao.getMember(id, pass);
        dao.close();

        if (dto != null) {
            // 로그인 성공
            HttpSession session = req.getSession();
            session.setAttribute("UserId", dto.getId());
            session.setAttribute("UserName", dto.getName());

            // ★ 수정됨: index.jsp -> main.do
            // (컨트롤러를 거쳐야 최신 글 데이터를 가져올 수 있음)
            resp.sendRedirect("main.do");

        } else {
            // 로그인 실패
            resp.sendRedirect("login.jsp?LoginError=1");
        }
    }
}