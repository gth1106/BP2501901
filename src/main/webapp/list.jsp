<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %> <%-- ★ 1. JSTL 버그 수정 --%>
<%-- JSTL(JSP Standard Tag Library)을 사용하기 위한 'taglib' 지시어 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록 - BP2501901</title>
    <style>
        /* 이전과 동일한 CSS */
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: #f9f9f9; }
        .header { background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .header .logo { font-size: 24px; font-weight: bold; color: #007bff; }
        .header .user-menu a { margin-left: 15px; text-decoration: none; color: #333; font-weight: 500; }
        .header .user-menu a:hover { color: #007bff; }
        .header .user-menu span { margin-left: 15px; font-weight: 500; color: #007bff; }

        .main-container { width: 90%; max-width: 1000px; margin: 40px auto; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .main-container h1 { margin-top: 0; }

        .table-header { display: flex; justify-content: space-between; align-items: center; }
        .write-button { padding: 8px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; }

        .board-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .board-table th, .board-table td { padding: 12px 15px; border-bottom: 1px solid #ddd; }
        .board-table th { background-color: #f7f7f7; font-weight: 600; text-align: center; }
        .board-table td { text-align: center; }
        .board-table td.title { text-align: left; }
        .board-table td.title a { text-decoration: none; color: #333; font-weight: 500; }
        .board-table td.title a:hover { text-decoration: underline; }

        .empty-message { text-align: center; padding: 50px; color: #777; }

    </style>
    <script>
        // ★ 3. 로그인 안 한 사용자가 클릭 시 알림창
        function requireLogin() {
            alert('로그인이 필요한 서비스입니다.');
            location.href = 'login.jsp';
        }
    </script>
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
        <a href="list.do">기술 게시판</a>
    </nav>
</header>

<div class="main-container">
    <div class="table-header">
        <h1>기술 게시판</h1>

        <%-- ★ 2. 글쓰기 버튼 보안 (로그인한 사용자에게만 보임) --%>
        <c:if test="${not empty sessionScope.UserId}">
            <a href="write.jsp" class="write-button">글쓰기</a>
        </c:if>
    </div>

    <table class="board-table">
        <thead>
        <tr>
            <th width="10%">번호</th>
            <th width="15%">카테고리</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="15%">작성일</th>
            <th width="10%">조회수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dto" items="${boardList}">
            <tr>
                <td>${dto.num}</td>
                <td>${dto.category}</td>
                <td class="title">
                        <%-- ★ 3. 게시글 링크 보안 --%>
                    <c:choose>
                        <c:when test="${not empty sessionScope.UserId}">
                            <%-- 3.1. 로그인 한 경우: 상세보기로 이동 --%>
                            <a href="view.do?num=${dto.num}">${dto.title}</a>
                        </c:when>
                        <c:otherwise>
                            <%-- 3.2. 로그인 안 한 경우: JS 알림창 --%>
                            <a href="#" onclick="requireLogin();">${dto.title}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${dto.writer_name}</td>
                <td>${dto.postdate}</td>
                <td>${dto.visitcount}</td>
            </tr>
        </c:forEach>

        <c:if test="${empty boardList}">
            <tr>
                <td colspan="6" class="empty-message">
                    등록된 게시물이 없습니다.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>