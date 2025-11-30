<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - BP2501901</title>
    <!-- 부트스트랩 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- 1. 헤더 (Navbar) -->
<nav class="navbar navbar-expand-lg glass-nav sticky-top mb-5">
    <div class="container">
        <a class="navbar-brand fw-bold text-glass-dark" href="main.do">BP2501901</a>

        <div class="d-flex align-items-center">
            <!-- 회원가입 페이지이므로 로그인 버튼만 노출 -->
            <span class="text-dark small me-3">이미 계정이 있으신가요?</span>
            <a href="login.jsp" class="btn btn-glass-primary btn-sm rounded-pill px-4 fw-bold">로그인</a>
        </div>
    </div>
</nav>

<!-- 2. 메인 콘텐츠 -->
<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">

            <!-- 유리 질감 카드 -->
            <div class="glass-card p-5">

                <div class="text-center mb-4 border-bottom border-dark border-opacity-10 pb-3">
                    <h2 class="fw-bold text-glass-dark">회원가입</h2>
                    <p class="text-muted small">새로운 멤버가 되어 지식을 공유해보세요!</p>
                </div>

                <form action="join.do" method="post" onsubmit="return validateJoinForm(this);">

                    <!-- 아이디 -->
                    <div class="mb-3">
                        <label for="userId" class="form-label fw-bold small text-muted ms-1">아이디</label>
                        <input type="text" id="userId" name="userId" class="form-control bg-white bg-opacity-50 border-0 shadow-sm p-3" placeholder="사용할 아이디를 입력하세요" required>
                    </div>

                    <!-- 비밀번호 -->
                    <div class="mb-3">
                        <label for="userPass1" class="form-label fw-bold small text-muted ms-1">비밀번호</label>
                        <input type="password" id="userPass1" name="userPass1" class="form-control bg-white bg-opacity-50 border-0 shadow-sm p-3" placeholder="비밀번호를 입력하세요" required>
                    </div>

                    <!-- 비밀번호 확인 -->
                    <div class="mb-3">
                        <label for="userPass2" class="form-label fw-bold small text-muted ms-1">비밀번호 확인</label>
                        <input type="password" id="userPass2" name="userPass2" class="form-control bg-white bg-opacity-50 border-0 shadow-sm p-3" placeholder="비밀번호를 다시 입력하세요" required>
                    </div>

                    <!-- 이름 -->
                    <div class="mb-4">
                        <label for="userName" class="form-label fw-bold small text-muted ms-1">이름</label>
                        <input type="text" id="userName" name="userName" class="form-control bg-white bg-opacity-50 border-0 shadow-sm p-3" placeholder="사용자 이름을 입력하세요" required>
                    </div>

                    <!-- 가입 버튼 -->
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-glass-primary btn-lg fw-bold rounded-3">회원가입 완료</button>
                        <a href="index.jsp" class="btn btn-light bg-opacity-50 border-0 text-muted mt-2">메인으로 돌아가기</a>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<script>
    // 비밀번호 일치 확인 스크립트
    function validateJoinForm(form) {
        if (form.userPass1.value !== form.userPass2.value) {
            alert("비밀번호가 일치하지 않습니다.\n다시 확인해주세요.");
            form.userPass2.value = "";
            form.userPass2.focus();
            return false;
        }
        return true;
    }
</script>

</body>
</html>