<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정 - BP2501901</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- 헤더 -->
<nav class="navbar navbar-expand-lg glass-nav sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-glass-dark" href="index.jsp">BP2501901</a>
        <div class="d-flex align-items-center">
            <span class="me-3 fw-bold text-dark"><%= session.getAttribute("UserName") %>님</span>
            <a href="mypage.jsp" class="text-dark text-decoration-none me-3 small">마이페이지</a>
            <a href="logout.do" class="btn btn-danger bg-opacity-75 border-0 btn-sm rounded-pill">로그아웃</a>
        </div>
    </div>
</nav>

<!-- 메인 콘텐츠 -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="glass-card p-5">

                <div class="mb-4 border-bottom border-dark border-opacity-10 pb-3">
                    <h2 class="fw-bold text-glass-dark m-0">게시글 수정</h2>
                </div>

                <form action="editProcess.do" method="post">
                    <!-- 게시글 번호 (숨김 전송) -->
                    <input type="hidden" name="num" value="${dto.num}">

                    <div class="mb-3">
                        <label class="form-label fw-bold">카테고리</label>
                        <select name="category" class="form-select bg-white bg-opacity-50 border-0 shadow-sm">
                            <option value="JSP" ${dto.category == 'JSP' ? 'selected' : ''}>JSP</option>
                            <option value="Spring" ${dto.category == 'Spring' ? 'selected' : ''}>Spring</option>
                            <option value="Database" ${dto.category == 'Database' ? 'selected' : ''}>Database</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">제목</label>
                        <input type="text" name="title" class="form-control bg-white bg-opacity-50 border-0 shadow-sm" value="${dto.title}" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold">내용</label>
                        <textarea name="content" class="form-control bg-white bg-opacity-50 border-0 shadow-sm" style="height: 300px;" required>${dto.content}</textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <button type="button" onclick="history.back()" class="btn btn-secondary bg-opacity-75 border-0 px-4">취소</button>
                        <button type="submit" class="btn btn-glass-primary px-4 fw-bold">수정 완료</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

</body>
</html>