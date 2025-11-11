<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BP2501901 기술 블로그</title>
    <style>
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: #f9f9f9; }
        .header {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .logo { font-size: 24px; font-weight: bold; color: #007bff; }
        .header .user-menu a {
            margin-left: 15px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }
        .header .user-menu a:hover { color: #007bff; }
        .header .user-menu span { /* 로그인 시 사용자 이름 스타일 */
            margin-left: 15px;
            font-weight: 500;
            color: #007bff;
        }
        .main {
            padding: 40px;
            text-align: center;
        }
    </style>
</head>
<body>

<header class="header">
    <div class="logo">
        <a href="index.jsp" style="text-decoration: none; color: inherit;">BP2501901 Blog</a>
    </div>

    <nav class="user-menu">
        <% if (session.getAttribute("UserId") == null) { %>
        <a href="login.jsp">로그인</a>
        <a href="join.jsp">회원가입</a>
        <% } else { %>
        <span>[<%= session.getAttribute("UserName") %>님]</span>
        <a href="mypage.jsp">마이페이지</a>
        <a href="logout.do">로그아웃</a>
        <% } %>

        <%-- ★ 수정된 부분: board.jsp -> list.do --%>
        <a href="list.do">기술 게시판</a>
    </nav>
</header>

<main class="main">
    <h1>JSP/Servlet MVC 패턴 학습 블로그</h1>
    <p>이곳은 JSP와 스프링을 공부하며 만드는 기술 블로그입니다.</p>
</main>

</body>
</html>