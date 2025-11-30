<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 비로그인 접근 시 로그인 페이지로 이동 --%>
<%
    if (session.getAttribute("UserId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기 - BP2501901</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg glass-nav sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-glass-dark" href="main.do">BP2501901</a>
        <div class="d-flex align-items-center">
            <span class="me-3 fw-bold text-dark"><%= session.getAttribute("UserName") %>님</span>
            <a href="mypage.do" class="text-dark text-decoration-none me-3 small">마이페이지</a>
            <a href="logout.do" class="btn btn-danger bg-opacity-75 border-0 btn-sm rounded-pill">로그아웃</a>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="glass-card p-5">

                <div class="mb-4 border-bottom border-dark border-opacity-10 pb-3">
                    <h2 class="fw-bold text-glass-dark m-0">새 글 작성</h2>
                </div>

                <form action="write.do" method="post" id="writeForm">

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">카테고리</label>
                        <select name="category" class="form-select bg-white bg-opacity-50 border-0 shadow-sm" required>
                            <option value="">선택하세요</option>
                            <option value="JSP">JSP</option>
                            <option value="Spring">Spring</option>
                            <option value="Database">Database</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">제목</label>
                        <input type="text" name="title" class="form-control bg-white bg-opacity-50 border-0 shadow-sm" placeholder="제목을 입력하세요" required>
                    </div>

                    <!-- ★ 스크린샷 붙여넣기 영역 -->
                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">이미지 첨부 (Ctrl+V로 스크린샷 붙여넣기)</label>
                        <div id="preview-area" tabindex="0"> <!-- tabindex=0: 포커스 가능하게 함 -->
                            <div id="preview-placeholder">여기를 클릭하고 Ctrl+V를 눌러 이미지를 붙여넣으세요.</div>
                        </div>
                        <!-- 실제 전송될 이미지 데이터 (숨김 필드) -->
                        <input type="hidden" name="imageData" id="imageData">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-muted">내용</label>
                        <textarea name="content" class="form-control bg-white bg-opacity-50 border-0 shadow-sm" style="height: 300px;" placeholder="내용을 자유롭게 작성하세요..." required></textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <button type="button" onclick="location.href='list.do'" class="btn btn-secondary bg-opacity-75 border-0 px-4 rounded-3">취소</button>
                        <button type="submit" class="btn btn-glass-primary px-4 fw-bold rounded-3">작성 완료</button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<!-- 스크린샷 처리 스크립트 -->
<script>
    const previewArea = document.getElementById('preview-area');
    const imageDataInput = document.getElementById('imageData');
    const placeholder = document.getElementById('preview-placeholder');

    previewArea.addEventListener('paste', function(e) {
        const items = (e.clipboardData || e.originalEvent.clipboardData).items;

        for (let index in items) {
            const item = items[index];
            if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
                const blob = item.getAsFile();
                const reader = new FileReader();

                reader.onload = function(event) {
                    // 미리보기 이미지 생성
                    const img = document.createElement('img');
                    img.src = event.target.result;

                    // 기존 내용 지우고 이미지 추가
                    previewArea.innerHTML = '';
                    previewArea.appendChild(img);

                    // 숨겨진 input에 Base64 데이터 저장
                    imageDataInput.value = event.target.result;
                };

                reader.readAsDataURL(blob);
                e.preventDefault(); // 기본 붙여넣기 동작 방지
            }
        }
    });
</script>

</body>
</html>