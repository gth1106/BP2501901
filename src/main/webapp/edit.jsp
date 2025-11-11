<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %> <%-- JSTL 사용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  [보안] EditController가 DTO를 request에 담아주지 않으면
  dto.writer_id가 비어있게 되므로, 세션 검사에서 걸러집니다.
--%>
<%
    if (session.getAttribute("UserId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정하기 - BP2501901</title>
    <style>
        /* write.jsp와 동일한 스타일 */
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: #f9f9f9; }
        .header { background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); padding: 20px 40px; }
        .main-container {
            width: 90%; max-width: 800px; margin: 40px auto;
            padding: 30px; background-color: #fff; border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .main-container h1 { margin-top: 0; }
        .edit-form table { width: 100%; }
        .edit-form table td { padding: 8px 0; }
        .edit-form input[type="text"], .edit-form select {
            width: 100%; padding: 10px; box-sizing: border-box;
            border: 1px solid #ddd; border-radius: 4px;
        }
        .edit-form textarea {
            width: 100%; height: 300px; padding: 10px; box-sizing: border-box;
            border: 1px solid #ddd; border-radius: 4px; resize: vertical;
        }
        .button-group { text-align: right; margin-top: 20px; }
        .button-group button {
            padding: 10px 20px; border: none; border-radius: 4px;
            font-size: 15px; cursor: pointer;
        }
        .button-group button[type="submit"] { background-color: #ffc107; color: #333; } /* 수정 (노란색) */
        .button-group button[type="button"] { background-color: #6c757d; color: white; }
    </style>
</head>
<body>
<div class="main-container">
    <h1>기술 블로그 글 수정</h1>

    <form name="editForm" class="edit-form"
          action="editProcess.do" method="post"> <%-- ★ 1. action 경로 다름 --%>

        <%-- ★ 2. 수정할 글 번호(num)를 컨트롤러로 몰래 넘김 --%>
        <input type="hidden" name="num" value="${dto.num}">

        <table>
            <tr>
                <td>카테고리</td>
                <td>
                    <%-- ★ 3. JSTL을 이용해 기존 카테고리를 'selected'로 표시 --%>
                    <select name="category" required>
                        <option value="">선택하세요</option>
                        <option value="JSP" ${dto.category == 'JSP' ? 'selected' : ''}>JSP</option>
                        <option value="Spring" ${dto.category == 'Spring' ? 'selected' : ''}>Spring</option>
                        <option value="QNA" ${dto.category == 'QNA' ? 'selected' : ''}>Q&A</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <%-- ★ 4. JSTL을 이용해 기존 제목을 value로 채움 --%>
                <td><input type="text" name="title" value="${dto.title}" required></td>
            </tr>
            <tr>
                <td>내용</td>
                <%-- ★ 5. JSTL을 이용해 기존 내용을 textarea에 채움 --%>
                <td><textarea name="content" required>${dto.content}</textarea></td>
            </tr>
        </table>

        <div class="button-group">
            <button type="button" onclick="history.back();">취소</button>
            <button type="submit">수정 완료</button>
        </div>
    </form>
</div>
</body>
</html>