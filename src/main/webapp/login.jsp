<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 - BP2501901</title>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5;
            margin: 0;
        }
        .login-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        .login-container h1 {
            color: #007bff;
            margin-bottom: 25px;
            font-size: 24px;
        }
        .login-container .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .login-container .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }
        .login-container .input-group input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box; /* 패딩이 너비에 포함되도록 설정 */
            border: 1px solid #ddd;
            border-radius: 6px;
        }
        .login-container .login-button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .login-container .login-button:hover {
            background-color: #0056b3;
        }

        /* ★ 1. 로그인 실패 시 보여줄 에러 메시지 스타일 */
        .error-message {
            color: #d93025; /* 빨간색 */
            font-size: 0.9em;
            font-weight: 500;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h1>로그인</h1>

    <% if (request.getParameter("LoginError") != null) { %>
    <div class="error-message">아이디 또는 패스워드가 일치하지 않습니다.</div>
    <% } %>

    <form action="login.do" method="post">
        <div class="input-group">
            <label for="userId">아이디</label>
            <input type="text" id="userId" name="userId" required>
        </div>
        <div class="input-group">
            <label for="userPass">패스워드</label>
            <input type="password" id="userPass" name="userPass" required>
        </div>
        <button type="submit" class="login-button">로그인</button>
    </form>
</div>

</body>
</html>
