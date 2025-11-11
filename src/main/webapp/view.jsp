<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %> <%-- JSTL 작동을 위해 isELIgnored="false" --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글상세보기 - BP2501901</title>
    <style>
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: #f9f9f9; }
        /* --- 헤더 스타일 (index, list와 동일) --- */
        .header {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .logo { font-size: 24px; font-weight: bold; color: #007bff; }
        .header .user-menu a { margin-left: 15px; text-decoration: none; color: #333; font-weight: 500; }
        .header .user-menu span { margin-left: 15px; font-weight: 500; color: #007bff; }

        /* --- 메인 콘텐츠 (게시글) --- */
        .main-container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        /* 게시글 본문 */
        .view-header { border-bottom: 2px solid #333; padding-bottom: 10px; }
        .view-header h2 { margin: 0; }
        .view-header .category { font-size: 0.9em; color: #007bff; font-weight: 600; margin-bottom: 5px; }
        .view-info { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #eee; font-size: 0.9em; color: #555; }
        .view-content { padding: 30px 10px; min-height: 250px; border-bottom: 1px solid #eee; line-height: 1.7; }

        .view-content {
            padding: 30px 10px;
            min-height: 250px;
            border-bottom: 1px solid #eee;
            line-height: 1.7; /* 줄 간격 */
        }

        /* ★ 1. 버튼 그룹 스타일 수정 */
        .button-group { text-align: right; margin-top: 20px; }
        /* '목록으로' 버튼 스타일 */
        .button-group button,
        .button-group a { /* <a> 태그도 버튼처럼 보이도록 공통 스타일 적용 */
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
            font-family: 'Inter', sans-serif;
        }

        .button-group button {
            background-color: #6c757d; /* 목록 (회색) */
            color: white;
        }
        .button-group a.btn-edit {
            background-color: #ffc107; /* 수정 (노란색) */
            color: #333;
        }
        .button-group a.btn-delete {
            background-color: #dc3545; /* 삭제 (빨간색) */
            color: white;
        }

        /* ★ 1. 댓글 섹션 스타일 */
        .comment-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .comment-section h3 { margin-top: 0; }

        /* 댓글 작성 폼 */
        .comment-form { display: flex; gap: 10px; margin-bottom: 20px; }
        .comment-form textarea {
            flex: 1; /* 남은 공간 모두 차지 */
            height: 50px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
        }
        .comment-form button {
            padding: 0 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        /* 댓글 목록 */
        .comment-list { list-style: none; padding: 0; margin: 0; }
        .comment-item {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .comment-item:last-child { border-bottom: none; }
        .comment-info { display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px; }
        .comment-info .writer { font-weight: 600; color: #333; }
        .comment-info .date { font-size: 0.85em; color: #777; }
        .comment-content { color: #555; line-height: 1.6; }
        .no-comments { text-align: center; color: #888; padding: 20px 0; }


        <!-- /* 댓글 삭제 수정  */-->
        .comment-info .date {
            font-size: 0.85em;
            color: #777;
        }

        /* ★ 1. 추가된 스타일: 댓글 삭제 링크 */
        .comment-info .delete-link {
            margin-left: 10px;
            color: #d93025; /* 빨간색 */
            text-decoration: none;
            font-weight: 500;
        }
        .comment-info .delete-link:hover {
            text-decoration: underline;
        }


    </style>
</head>
<body>

<!-- 헤더 -->
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

<!-- 메인 콘텐츠 (게시글 상세) -->
<div class="main-container">

    <%-- 1. 게시글 본문 (ViewController가 보내준 'dto') --%>
    <c:if test="${not empty dto}">
        <div class="view-header">
            <div class="category">[${dto.category}]</div>
            <h2>${dto.title}</h2>
        </div>

        <div class="view-info">
            <span>작성자: ${dto.writer_name} (${dto.writer_id})</span>
            <span>
                    작성일: ${dto.postdate} | 조회수: ${dto.visitcount}
                </span>
        </div>

        <div class="view-content">
                ${dto.content} <%-- 컨트롤러에서 \n을 <br>로 변환해 줌 --%>
        </div>
    </c:if>

    <c:if test="${empty dto}">
        <div class="view-content">
            게시글을 찾을 수 없습니다. (데이터 로드 실패)
        </div>
    </c:if>

        <div class="button-group">
            <button type="button" onclick="location.href='list.do';">목록으로</button>

            <%-- 수정/삭제 버튼 (본인 확인) --%>
            <c:if test="${sessionScope.UserId == dto.writer_id}">
                <%-- "수정" 버튼이 /edit.do 컨트롤러를 호출하도록 변경 --%>
                <a href="edit.do?num=${dto.num}" class="btn-edit">수정</a>

                <%-- "삭제" 버튼 (onclick 이벤트로 JS 함수 호출) --%>
                <a href="#" onclick="deletePost('${dto.num}');" class="btn-delete">삭제</a>
            </c:if>
        </div>

    <!-- ★ 2. 댓글 기능 섹션 -->
    <div class="comment-section">
        <h3>댓글</h3>

        <!-- 댓글 작성 폼 (로그인한 사용자만) -->
        <c:if test="${not empty sessionScope.UserId}">
            <form class="comment-form" action="comment.do" method="post">
                <!-- 현재 게시글 번호(bnum)를 컨트롤러로 몰래 넘김 -->
                <input type="hidden" name="bnum" value="${dto.num}">

                <textarea name="content" placeholder="댓글을 입력하세요..." required></textarea>
                <button type="submit">등록</button>
            </form>
        </c:if>

        <!-- ★ 2. 댓글 목록 (수정된 부분) -->
        <ul class="comment-list">
            <c:choose>
                <c:when test="${not empty commentList}">
                    <c:forEach var="cmt" items="${commentList}">
                        <li class="comment-item">
                            <div class="comment-info">
                                <span class="writer">${cmt.writer_name} (${cmt.writer_id})</span>

                                    <%-- ★ 수정된 부분: 날짜 + 삭제 링크 --%>
                                <span class="date">
                                        ${cmt.postdate}

                                        <%-- 본인 댓글일 경우 '삭제' 링크 표시 --%>
                                        <c:if test="${sessionScope.UserId == cmt.writer_id}">
                                            <a href="#"
                                               onclick="deleteComment('${cmt.cnum}', '${dto.num}');"
                                               class="delete-link">[삭제]</a>
                                        </c:if>
                                    </span>
                            </div>
                            <div class="comment-content">${cmt.content}</div>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li class="no-comments">등록된 댓글이 없습니다.</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

</div>
        <!-- ★ 3. 추가된 <script> 블록 -->
        <script>
            // (이전 단계에서 추가한) 게시글 삭제용 Javascript
            function deletePost(num) {
                // "정말 삭제하시겠습니까?" 확인 창
                if (confirm('정말 삭제하시겠습니까?')) {
                    // '확인' 시 delete.do로 이동
                    location.href = 'delete.do?num=' + num;
                }
            }

            // (이번 단계에서 추가한) 댓글 삭제용 Javascript
            function deleteComment(cnum, bnum) {
                // "정말 삭제하시겠습니까?" 확인 창
                if (confirm('정말 삭제하시겠습니까?')) {
                    // '확인' 시 deleteComment.do로 이동 (댓글번호, 게시글번호 전달)
                    location.href = 'deleteComment.do?cnum=' + cnum + '&bnum=' + bnum;
                }
            }
        </script>
</body>
</html>