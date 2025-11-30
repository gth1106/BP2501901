package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;
import com.bp2501901.util.BoardPage; // 페이징 유틸리티 임포트

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/list.do")
public class ListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1. DAO 생성
        BoardDAO dao = new BoardDAO();

        // 2. 뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<>();

        // 3. 게시물 수 확인 (전체 게시글 개수)
        int totalCount = dao.selectCount(map);

        /* ================= 페이징 처리 start ================= */
        // 페이지당 글 개수 (10개씩)
        int pageSize = 10;
        // 하단 페이지 블록 개수 ([1] [2] [3] [4] [5])
        int blockPage = 5;

        // 현재 페이지 확인 (기본값 1)
        int pageNum = 1;
        String pageTemp = req.getParameter("pageNum");
        if (pageTemp != null && !pageTemp.equals(""))
            pageNum = Integer.parseInt(pageTemp);

        // 목록에 출력할 게시물 범위 계산 (MySQL LIMIT용)
        // 1페이지 -> 0, 2페이지 -> 10, 3페이지 -> 20
        int start = (pageNum - 1) * pageSize;

        // DAO에 전달할 매개변수 저장
        map.put("start", start);
        map.put("pageSize", pageSize);
        /* ================= 페이징 처리 end ================= */

        // 4. 게시물 목록 받기 (페이징된 목록)
        List<BoardDTO> boardList = dao.selectListPage(map); // ★ map을 전달합니다!
        dao.close();

        // 5. 뷰에 전달할 매개변수 추가 설정 (하단 페이지 번호 HTML 생성)
        String pagingStr = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "list.do");

        map.put("pagingStr", pagingStr); // 페이지 블록 문자열 ([1] [2] ...)
        map.put("totalCount", totalCount); // 전체 글 개수
        map.put("pageSize", pageSize);
        map.put("pageNum", pageNum);

        // 6. 결과 전달
        req.setAttribute("boardList", boardList);
        req.setAttribute("map", map);

        // 7. View(JSP)로 포워드
        req.getRequestDispatcher("list.jsp").forward(req, resp);
    }
}