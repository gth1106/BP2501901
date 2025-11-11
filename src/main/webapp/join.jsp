<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 - BP2501901</title>
    <style>
        /* login.jsp와 유사한 스타일 */
        body {
            font-family: 'Inter', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5;
            margin: 0;
        }
        .join-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 340px; /* 로그인 폼보다 약간 넓게 */
            text-align: center;
        }
        .join-container h1 {
            color: #007bff;
            margin-bottom: 25px;
            font-size: 24px;
        }
        .join-container .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .join-container .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }
        .join-container .input-group input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 6px;
        }
        .join-container .join-button {
            width: 100%;
            padding: 12px;
            background-color: #28a745; /* 가입 버튼 (초록색) */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .join-container .join-button:hover {
            background-color: #218838;
        }
        .join-container .login-link {
            margin-top: 20px;
            font-size: 0.9em;
        }
        .join-container .login-link a {
            color: #007bff;
            text-decoration: none;
        }
        /* 회원가입 성공 메시지 */
        .success-message {
            color: #28a745;
            font-weight: 500;
            margin-bottom: 15px;
        }
    </style>
    <script>
        // 폼 유효성 검사 (비밀번호 일치)
        function validateJoinForm(form) {
            if (form.userPass1.value !== form.userPass2.value) {
                alert("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
                form.userPass2.focus(); // 두 번째 비밀번호 폼에 포커스
                return false; // 폼 제출(submit) 막기
            }
            // 유효성 검사 통과
            return true;
        }
    </script>
</head>
<body>

<div class="join-container">
    <h1>회원가입</h1>

    <form action="join.do" method="post" onsubmit="return validateJoinForm(this);">
        <div class="input-group">
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" required>
        </div>
        <div class="input-group">
            <label for="userPass1">비밀번호</label>
            <input type="password" id="userPass1" name="userPass1" required>
        </div>
        <div class="input-group">
            <label for="userPass2">비밀번호 확인</label>
            <input type="password" id="userPass2" name="userPass2" required>
        </div>
        <div class="input-group">
            <label for="userName">이름</label>
            <input type="text" id="userName" name="userName" required>
        </div>
        <button type="submit" class="join-button">회원가입</button>
    </form>

    <div class="login-link">
        이미 회원이신가요? <a href="login.jsp">로그인</a>
    </div>
</div>

</body>
</html>