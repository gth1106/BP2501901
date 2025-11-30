package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/main.do")
public class MainController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // ★ 수정됨: 메인 페이지는 로그인 여부와 상관없이 누구나 접근 가능해야 함.
        // 기존의 세션 체크 로직 삭제

        // 1. 최신 글 목록 가져오기 (LIMIT 3)
        BoardDAO dao = new BoardDAO();
        List<BoardDTO> recentPosts = dao.getRecentList();
        dao.close();

        // 2. 조회한 목록을 request 영역에 저장
        req.setAttribute("recentPosts", recentPosts);

        // 3. 메인 페이지(index.jsp)로 포워드
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}