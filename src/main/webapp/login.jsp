<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 - BP2501901</title>
    <!-- 부트스트랩 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="d-flex align-items-center min-vh-100">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">

            <div class="login-card p-4 p-md-5">
                <div class="text-center mb-4">
                    <h2 class="login-title">BP2501901</h2>
                    <p class="text-muted small">Dev Blog Login</p>
                </div>

                <%-- 알림 메시지 --%>
                <% if (request.getParameter("LoginError") != null) { %>
                <div class="alert alert-danger py-2 text-center small" role="alert">
                    아이디 또는 비밀번호가 일치하지 않습니다.
                </div>
                <% } %>
                <% if (request.getParameter("JoinSuccess") != null) { %>
                <div class="alert alert-success py-2 text-center small" role="alert">
                    회원가입 완료! 로그인해주세요.
                </div>
                <% } %>

                <form action="login.do" method="post">
                    <!-- 아이디 입력 (Floating Label) -->
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="userId" name="userId" placeholder="ID" required>
                        <label for="userId">아이디</label>
                    </div>

                    <!-- 비밀번호 입력 (Floating Label) -->
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="userPass" name="userPass" placeholder="Password" required>
                        <label for="userPass">비밀번호</label>
                    </div>

                    <!-- 버튼 -->
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg fw-bold">로그인</button>
                    </div>
                </form>

                <hr class="my-4 text-muted">

                <div class="text-center small">
                    <span class="text-muted">계정이 없으신가요?</span>
                    <a href="join.jsp" class="fw-bold text-decoration-none ms-1">회원가입</a>
                    <span class="mx-2 text-muted">|</span>
                    <a href="index.jsp" class="text-secondary text-decoration-none">메인으로</a>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>