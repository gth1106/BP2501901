<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - BP2501901</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- 헤더 -->
<nav class="navbar navbar-expand-lg glass-nav sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-glass-dark" href="main.do">BP2501901</a>
        <div class="d-flex align-items-center">
            <span class="me-3 fw-bold text-dark"><%= session.getAttribute("UserName") %>님</span>
            <a href="logout.do" class="btn btn-danger bg-opacity-75 border-0 btn-sm rounded-pill">로그아웃</a>
        </div>
    </div>
</nav>

<!-- 메인 콘텐츠 -->
<div class="container py-5">
    <div class="row g-4">

        <!-- 왼쪽: 내 정보 카드 -->
        <div class="col-md-4">
            <div class="glass-card p-4 text-center h-100">
                <div class="mb-3">
                    <span class="fs-1">👤</span>
                </div>
                <h3 class="fw-bold mb-1">${memberInfo.name}</h3>
                <p class="text-muted small mb-4">${memberInfo.id}</p>

                <div class="border-top border-dark border-opacity-10 pt-3 text-start">
                    <p class="mb-1 small text-muted">가입일</p>
                    <p class="fw-bold"><fmt:formatDate value="${memberInfo.regdate}" pattern="yyyy년 MM월 dd일"/></p>
                </div>

                <div class="d-grid mt-4">
                    <button class="btn btn-secondary btn-sm" onclick="alert('준비 중인 기능입니다.');">비밀번호 변경</button>
                </div>
            </div>
        </div>

        <!-- 오른쪽: 내가 쓴 글 목록 -->
        <div class="col-md-8">
            <div class="glass-card p-4 h-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold m-0">내가 쓴 글</h4>
                    <a href="list.do" class="btn btn-sm btn-outline-dark rounded-pill px-3">전체 보기</a>
                </div>

                <div class="list-group list-group-flush bg-transparent">
                    <c:forEach var="dto" items="${myList}">
                        <a href="view.do?num=${dto.num}" class="list-group-item list-group-item-action bg-transparent border-bottom border-dark border-opacity-10 py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 fw-bold text-dark">${dto.title}</h6>
                                <small class="text-muted"><fmt:formatDate value="${dto.postdate}" pattern="MM.dd"/></small>
                            </div>
                            <small class="text-muted"><span class="badge bg-light text-dark border">${dto.category}</span> 조회수 ${dto.visitcount}</small>
                        </a>
                    </c:forEach>
                    <c:if test="${empty myList}">
                        <div class="text-center py-5 text-muted">작성한 글이 없습니다.</div>
                    </c:if>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>