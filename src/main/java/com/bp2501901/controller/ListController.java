package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/list.do")
public class ListController extends HttpServlet {

    // 게시판 목록은 GET 방식으로 요청
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. Model(DAO) 호출
        BoardDAO dao = new BoardDAO();
        List<BoardDTO> boardList = dao.getBoardList(); // DB에서 목록 가져오기
        dao.close(); // ★ 중요: DAO 사용 후 자원 반납

        // 2. View(JSP)로 데이터 전달
        // request 객체에 "boardList"라는 이름으로 데이터(List)를 저장
        req.setAttribute("boardList", boardList);

        // 3. View(JSP)로 포워드(forward)
        // '포워드'는 request 객체를 그대로 전달하면서 페이지를 이동
        // (cf. '리다이렉트'는 브라우저에게 새 주소로 다시 접속하라고 명령)
        RequestDispatcher rd = req.getRequestDispatcher("list.jsp");
        rd.forward(req, resp);
    }
}