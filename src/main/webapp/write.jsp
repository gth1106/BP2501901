<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%-- ★ 1. 페이지 접근 보안 (가장 중요) --%>
<%
    if (session.getAttribute("UserId") == null) {
        // 1.1. 로그인하지 않은 사용자가 URL로 직접 접근한 경우
        response.setContentType("text/html; charset=UTF-8");
        out.println("<script>");
        out.println("alert('로그인이 필요한 서비스입니다.');");
        out.println("location.href = 'login.jsp';"); // 로그인 페이지로 튕겨내기
        out.println("</script>");
        out.close();
        return; // 아래쪽 HTML 렌더링 중단
    }
%>
<%-- ★ 1.2. 로그인한 사용자의 경우, 아래 HTML이 정상적으로 보임 --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글쓰기 - BP2501901</title>
    <style>
        /* list.jsp와 유사한 스타일 */
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: #f9f9f9; }
        .header { background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); padding: 20px 40px; }
        .main-container {
            width: 90%; max-width: 800px; margin: 40px auto;
            padding: 30px; background-color: #fff; border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .main-container h1 { margin-top: 0; }
        .write-form table { width: 100%; }
        .write-form table td { padding: 8px 0; }
        .write-form input[type="text"], .write-form select {
            width: 100%; padding: 10px; box-sizing: border-box;
            border: 1px solid #ddd; border-radius: 4px;
        }
        .write-form textarea {
            width: 100%; height: 300px; padding: 10px; box-sizing: border-box;
            border: 1px solid #ddd; border-radius: 4px; resize: vertical;
        }
        .button-group { text-align: right; margin-top: 20px; }
        .button-group button {
            padding: 10px 20px; border: none; border-radius: 4px;
            font-size: 15px; cursor: pointer;
        }
        .button-group button[type="submit"] { background-color: #007bff; color: white; }
        .button-group button[type="button"] { background-color: #6c757d; color: white; }
    </style>
</head>
<body>
<div class="main-container">
    <h1>기술 블로그 글쓰기</h1>
    <form name="writeForm" class="write-form"
          action="write.do" method="post"
          onsubmit="return validateForm(this);">

        <table>
            <tr>
                <td>카테고리</td>
                <td>
                    <select name="category" required>
                        <option value="">선택하세요</option>
                        <option value="JSP">JSP</option>
                        <option value="Spring">Spring</option>
                        <option value="QNA">Q&A</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input type="text" name="title" placeholder="제목을 입력하세요" required></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea name="content" placeholder="내용을 입력하세요" required></textarea></td>
            </tr>
        </table>

        <div class="button-group">
            <button type="button" onclick="location.href='list.do';">목록으로</button>
            <button type="submit">작성 완료</button>
        </div>
    </form>
</div>
</body>
</html>