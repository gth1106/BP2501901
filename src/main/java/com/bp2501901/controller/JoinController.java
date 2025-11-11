package com.bp2501901.controller;

import com.bp2501901.model.dao.MemberDAO;
import com.bp2501901.model.dto.MemberDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/join.do")
public class JoinController extends HttpServlet {

    // 폼 전송은 POST 방식
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

        // 1. View(join.jsp)에서 폼 데이터 받기
        String id = req.getParameter("userId");
        String pass = req.getParameter("userPass1"); // 폼에서 userPass1로 보냄
        String name = req.getParameter("userName");

        // 2. DTO(Model)에 데이터 저장
        MemberDTO dto = new MemberDTO();
        dto.setId(id);
        dto.setPass(pass);
        dto.setName(name);

        // 3. DAO(Model)에 DTO 전달하여 DB에 삽입
        MemberDAO dao = new MemberDAO();
        int result = dao.insertMember(dto);
        dao.close(); // ★ 중요: DAO 사용 후 자원 반납

        // 4. 결과에 따라 View(JSP) 선택
        if (result == 1) {
            // 회원가입 성공
            // login.jsp로 리다이렉트 (성공했다는 파라미터와 함께)
            resp.sendRedirect("login.jsp?JoinSuccess=1");
        } else {
            // 회원가입 실패 (e.g., ID 중복)
            // (실제로는 "ID가 중복됩니다" 등 알림을 주는 것이 좋음)
            resp.sendRedirect("join.jsp");
        }
    }
}