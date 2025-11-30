package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editProcess.do")
public class EditProcessController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 1. 파라미터 받기
        String num = req.getParameter("num");
        String category = req.getParameter("category");
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // 2. DTO에 담기
        BoardDTO dto = new BoardDTO();
        dto.setNum(Integer.parseInt(num));
        dto.setCategory(category);
        dto.setTitle(title);
        dto.setContent(content);

        // 3. DAO 호출 (업데이트)
        BoardDAO dao = new BoardDAO();
        int result = dao.updateBoard(dto);
        dao.close();

        // 4. 결과 페이지 이동
        if (result == 1) {
            // 성공 시 상세 페이지로 이동
            resp.sendRedirect("view.do?num=" + num);
        } else {
            // 실패 시 다시 수정 페이지로 (혹은 에러 페이지)
            resp.sendRedirect("edit.do?num=" + num);
        }
    }
}