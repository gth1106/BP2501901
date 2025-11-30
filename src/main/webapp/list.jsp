<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 목록 - BP2501901</title>
    <!-- 부트스트랩 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="css/style.css">

    <style>
        /* 페이징 버튼 커스텀 (글래스모피즘 스타일) */
        .pagination .page-link {
            background: rgba(255, 255, 255, 0.3); /* 반투명 배경 */
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #333;
            margin: 0 3px;
            border-radius: 8px; /* 둥근 모서리 */
            backdrop-filter: blur(5px);
        }
        .pagination .page-link:hover {
            background: rgba(255, 255, 255, 0.6);
            color: #0d6efd;
        }
        .pagination .page-item.active .page-link {
            background: #0d6efd; /* 활성화된 페이지 (파란색) */
            color: white;
            border-color: #0d6efd;
            box-shadow: 0 4px 6px rgba(13, 110, 253, 0.3);
        }
    </style>
</head>
<body>

<!-- 헤더 -->
<nav class="navbar navbar-expand-lg glass-nav sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-glass-dark" href="main.do">BP2501901</a>
        <div class="d-flex align-items-center">
            <% if (session.getAttribute("UserId") == null) { %>
            <a href="login.jsp" class="btn btn-light bg-opacity-50 btn-sm me-2 fw-bold">로그인</a>
            <a href="join.jsp" class="btn btn-glass-primary btn-sm rounded-pill px-3">회원가입</a>
            <% } else { %>
            <span class="me-3 fw-bold text-dark"><%= session.getAttribute("UserName") %>님</span>
            <a href="mypage.do" class="text-dark text-decoration-none me-3 small">마이페이지</a>
            <a href="logout.do" class="btn btn-danger bg-opacity-75 border-0 btn-sm rounded-pill">로그아웃</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- 메인 콘텐츠 -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="glass-card p-5">

                <!-- 게시판 상단 (제목 + 글쓰기 버튼) -->
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom border-dark border-opacity-10 pb-3">
                    <h2 class="fw-bold text-glass-dark m-0">기술 게시판</h2>

                    <!-- 전체 글 개수 표시 -->
                    <span class="badge bg-secondary bg-opacity-25 text-dark ms-2">
                            Total : ${map.totalCount}
                        </span>

                    <div class="ms-auto">
                        <c:if test="${not empty sessionScope.UserId}">
                            <a href="write.jsp" class="btn btn-glass-primary btn-sm rounded-pill px-4 fw-bold">✏️ 글쓰기</a>
                        </c:if>
                    </div>
                </div>

                <!-- 게시판 테이블 -->
                <div class="table-responsive">
                    <table class="table table-hover align-middle" style="background-color: transparent;">
                        <thead class="table-light bg-opacity-50 text-center">
                        <tr>
                            <th width="8%" class="py-3">번호</th>
                            <th width="12%">카테고리</th>
                            <th width="*">제목</th>
                            <th width="15%">작성자</th>
                            <th width="20%">작성일</th>
                            <th width="10%">조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="dto" items="${boardList}">
                            <tr>
                                <td class="text-center fw-bold text-muted">${dto.num}</td>
                                <td class="text-center">
                                            <span class="badge bg-light text-dark border border-secondary border-opacity-25 rounded-pill px-3 py-2">
                                                    ${dto.category}
                                            </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.UserId}">
                                            <a href="view.do?num=${dto.num}" class="text-decoration-none text-dark fw-bold d-block text-truncate" style="max-width: 300px;">
                                                    ${dto.title}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" onclick="requireLogin();" class="text-decoration-none text-dark fw-bold d-block text-truncate" style="max-width: 300px;">
                                                    ${dto.title}
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center text-muted small">${dto.writer_name}</td>
                                <td class="text-center text-muted small">
                                    <fmt:formatDate value="${dto.postdate}" pattern="yyyy.MM.dd"/>
                                </td>
                                <td class="text-center text-muted small">${dto.visitcount}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty boardList}">
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    등록된 게시물이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- ★ 페이징 (Controller에서 map.pagingStr로 전달됨) -->
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <!-- Java 문자열로 만들어진 HTML 코드를 그대로 출력 -->
                        ${map.pagingStr}
                    </ul>
                </nav>

            </div>
        </div>
    </div>
</div>

<!-- 로그인 알림 스크립트 -->
<script>
    function requireLogin() {
        alert('로그인이 필요한 서비스입니다.');
        location.href = 'login.jsp';
    }
</script>

</body>
</html>