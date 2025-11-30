package com.bp2501901.controller;

import com.bp2501901.model.dao.BoardDAO;
import com.bp2501901.model.dto.BoardDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.UUID;

@WebServlet("/write.do")
public class WriteController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");

        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 1. 파라미터 받기
        String category = req.getParameter("category");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String imageData = req.getParameter("imageData"); // Base64 이미지 데이터

        String savedFileName = null; // 저장된 파일명

        // 2. 이미지 처리 (이미지 데이터가 있는 경우)
        if (imageData != null && !imageData.isEmpty() && imageData.contains(",")) {
            try {
                // Base64 데이터 분리 ("data:image/png;base64," 뒷부분만 추출)
                String base64Image = imageData.split(",")[1];
                byte[] imageBytes = Base64.getDecoder().decode(base64Image);

                // 저장 경로 설정 (프로젝트 내부가 아닌 실제 서버 경로)
                // 예: webapp/uploads 폴더
                String savePath = req.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(savePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // 폴더가 없으면 생성
                }

                // 고유한 파일명 생성 (UUID 사용)
                savedFileName = UUID.randomUUID().toString() + ".png";
                String fullPath = savePath + File.separator + savedFileName;

                // 파일 저장
                FileOutputStream fos = new FileOutputStream(fullPath);
                fos.write(imageBytes);
                fos.close();

                System.out.println("Image saved at: " + fullPath);

            } catch (Exception e) {
                System.out.println("Image Upload Error");
                e.printStackTrace();
            }
        }

        // 3. DTO 저장
        BoardDTO dto = new BoardDTO();
        dto.setCategory(category);
        dto.setTitle(title);
        dto.setContent(content);
        dto.setWriter_id(userId);
        dto.setSfile(savedFileName); // 저장된 파일명 (없으면 null)

        // 4. DB 삽입
        BoardDAO dao = new BoardDAO();
        int result = dao.insertBoard(dto);
        dao.close();

        if (result == 1) {
            resp.sendRedirect("list.do");
        } else {
            resp.sendRedirect("write.jsp");
        }
    }
}