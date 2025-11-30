package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dao.MemberDAO;
import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.model.dto.MemberDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/mypage.do")
public class MypageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 1. 회원 상세 정보 가져오기
        MemberDAO memberDao = new MemberDAO();
        MemberDTO memberInfo = memberDao.getMemberInfo(userId);
        memberDao.close();

        // 2. 내가 쓴 글 목록 가져오기
        BoardDAO boardDao = new BoardDAO();
        List<BoardDTO> myList = boardDao.getMyList(userId);
        boardDao.close();

        // 3. 뷰로 전달
        req.setAttribute("memberInfo", memberInfo);
        req.setAttribute("myList", myList);

        req.getRequestDispatcher("mypage.jsp").forward(req, resp);
    }
}