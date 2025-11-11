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

/**
 * @WebServlet 어노테이션
 * - 이 클래스가 Servlet(Controller)임을 나타냅니다.
 * - "/login.do" URL 패턴의 요청을 이 서블릿이 처리하도록 톰캣에 등록합니다.
 * - (과거 web.xml에 수동으로 등록하던 작업을 대체합니다)
 */
@WebServlet("/login.do")
public class LoginController extends HttpServlet {

    // login.jsp의 <form method="post"> 요청을 처리하므로 doPost() 메서드를 오버라이드합니다.
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. View(login.jsp)에서 보낸 폼 데이터 받기
        String id = req.getParameter("userId");
        String pass = req.getParameter("userPass");

        // 2. Model(DAO)에 폼 데이터 전달
        MemberDAO dao = new MemberDAO(); // DAO 객체 생성
        MemberDTO dto = dao.getMember(id, pass); // 4단계에서 만든 로그인 메서드 호출
        dao.close(); // ★ 중요: DAO 사용 후 자원 반납 (Connection 반납)

        // 3. Model(DAO)의 처리 결과에 따라 View(JSP) 선택
        if (dto != null) {
            // 로그인 성공

            // 4. 세션(Session)에 로그인 정보 저장
            // 세션은 브라우저가 닫히기 전까지 서버에 정보를 저장하는 기술
            HttpSession session = req.getSession(); // 세션 객체 가져오기
            session.setAttribute("UserId", dto.getId());     // "UserId" 라는 이름으로 유저 ID 저장
            session.setAttribute("UserName", dto.getName()); // "UserName" 이라는 이름으로 유저 이름 저장

            // 5. 메인 페이지(index.jsp)로 이동 (Redirect)
            // sendRedirect: 브라우저에게 "이 주소로 다시 접속해"라고 명령
            resp.sendRedirect("index.jsp");

        } else {
            // 로그인 실패

            // 5. 다시 로그인 페이지(login.jsp)로 이동 (Redirect)
            // 실패했다는 정보를 파라미터로 함께 보냄
            resp.sendRedirect("login.jsp?LoginError=1");
        }
    }
}