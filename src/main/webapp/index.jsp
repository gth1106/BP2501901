<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BP2501901 기술 블로그</title>
    <!-- 부트스트랩 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="css/style.css">

    <style>
        .transition-hover { transition: transform 0.2s; }
        .transition-hover:hover { transform: translateY(-5px); }
    </style>

</head>
<body>

<!-- 1. 헤더 (Navbar) -->
<nav class="navbar navbar-expand-lg glass-nav sticky-top mb-5">
    <div class="container">
        <!-- 로고 클릭 시 main.do 호출 -->
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

<div class="container pb-5">

    <!-- 2. 메인 소개 (Hero) 섹션 -->
    <section class="row justify-content-center text-center mb-5">
        <div class="col-lg-10">
            <div class="glass-card p-5">
                <h1 class="display-4 fw-bold text-glass-dark mb-3">Tech Blog</h1>
                <p class="lead text-dark opacity-75 mb-4">
                    JSP, Servlet, Spring Framework 학습 기록.<br>
                    유리처럼 투명하고 명확한 지식을 공유합니다.
                </p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="list.do" class="btn btn-glass-primary btn-lg px-5 rounded-pill fw-bold">게시판 입장</a>
                </div>
            </div>
        </div>
    </section>

    <!-- ★ 3. 최신 포스트 섹션 (수정됨: C : IF 제거하여 항상 보이게 함) -->
    <section class="mb-5">
        <h4 class="fw-bold mb-4 ps-2 border-start border-4 border-primary">🔥 최신 포스트</h4>

        <div class="row g-4">
            <c:choose>
                <%-- 게시글이 있을 때: 카드 형태로 반복 출력 --%>
                <c:when test="${not empty recentPosts}">
                    <c:forEach var="post" items="${recentPosts}">
                        <div class="col-md-4">
                            <div class="glass-card h-100 p-4 d-flex flex-column transition-hover">
                                <div class="mb-3">
                                    <span class="badge bg-primary bg-opacity-10 text-primary mb-2">${post.category}</span>
                                    <h5 class="fw-bold text-truncate">${post.title}</h5>
                                </div>

                                <div class="mt-auto">
                                    <p class="text-muted small mb-2">
                                        작성자: ${post.writer_name}<br>
                                        <fmt:formatDate value="${post.postdate}" pattern="yyyy.MM.dd"/>
                                    </p>
                                    <a href="view.do?num=${post.num}" class="btn btn-sm btn-outline-primary w-100 stretched-link">읽기</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <%-- 게시글이 없을 때: 안내 메시지 카드 출력 --%>
                <c:otherwise>
                    <div class="col-12">
                        <div class="glass-card p-5 text-center">
                            <p class="text-muted m-0">아직 등록된 게시글이 없습니다.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- 4. 하단 소개 카드 섹션 -->
    <section>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="glass-card h-100 p-4 text-center transition-hover">
                    <div class="fs-1 mb-3">☕</div>
                    <h4 class="fw-bold">Java & JSP</h4>
                    <p class="text-dark opacity-75 small">Back-end 개발의 기초를 탄탄하게 다지는 공간입니다.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card h-100 p-4 text-center transition-hover">
                    <div class="fs-1 mb-3">🍃</div>
                    <h4 class="fw-bold">Spring Boot</h4>
                    <p class="text-dark opacity-75 small">현업에서 가장 많이 쓰이는 프레임워크 활용법을 기록합니다.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card h-100 p-4 text-center transition-hover">
                    <div class="fs-1 mb-3">💾</div>
                    <h4 class="fw-bold">Database</h4>
                    <p class="text-dark opacity-75 small">데이터 설계부터 최적화 쿼리까지 DB의 모든 것을 다룹니다.</p>
                </div>
            </div>
        </div>
    </section>

</div>

</body>
</html>