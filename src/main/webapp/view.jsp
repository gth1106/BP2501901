<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 상세보기 - BP2501901</title>
    <!-- 부트스트랩 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- 헤더 (네비게이션) -->
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

            <!-- 유리 질감 카드 -->
            <div class="glass-card p-5">

                <c:if test="${not empty dto}">
                    <!-- 게시글 헤더 -->
                    <div class="mb-4 border-bottom border-dark border-opacity-10 pb-3">
                        <span class="badge bg-primary bg-gradient rounded-pill mb-2">${dto.category}</span>
                        <h2 class="fw-bold text-dark mb-3">
                                ${dto.title}
                            <c:if test="${not empty dto.editdate}">
                                    <span class="fs-6 text-muted ms-2 fw-normal">
                                        (수정됨: <fmt:formatDate value="${dto.editdate}" pattern="yyyy.MM.dd HH:mm"/>)
                                    </span>
                            </c:if>
                        </h2>
                        <div class="d-flex justify-content-between text-muted small">
                            <div>
                                <span class="fw-bold text-dark me-2">${dto.writer_name}</span>
                                <span><fmt:formatDate value="${dto.postdate}" pattern="yyyy.MM.dd HH:mm"/></span>
                            </div>
                            <div>
                                조회수 <span class="fw-bold">${dto.visitcount}</span>
                            </div>
                        </div>
                    </div>

                    <!-- 게시글 본문 -->
                    <div class="mb-5" style="min-height: 200px; line-height: 1.8;">
                            ${dto.content}
                    </div>

                    <!-- 버튼 그룹 -->
                    <div class="d-flex justify-content-end gap-2 mb-5">
                        <a href="list.do" class="btn btn-secondary bg-opacity-75 border-0 px-4">목록</a>

                        <!-- 본인 글일 때만 수정/삭제 버튼 표시 -->
                        <c:if test="${sessionScope.UserId == dto.writer_id}">
                            <a href="edit.do?num=${dto.num}" class="btn btn-warning text-dark px-4">수정</a>
                            <button onclick="deletePost('${dto.num}')" class="btn btn-danger px-4">삭제</button>
                        </c:if>
                    </div>

                    <!-- 댓글 섹션 -->
                    <div class="bg-white bg-opacity-50 p-4 rounded-4 shadow-sm">
                        <h5 class="fw-bold mb-3">댓글</h5>

                        <!-- 댓글 작성 폼 -->
                        <form action="comment.do" method="post" class="mb-4 d-flex gap-2">
                            <input type="hidden" name="bnum" value="${dto.num}">
                            <textarea name="content" class="form-control" rows="2" placeholder="댓글을 남겨보세요..." required></textarea>
                            <button type="submit" class="btn btn-glass-primary px-4">등록</button>
                        </form>

                        <!-- 댓글 목록 -->
                        <div class="vstack gap-3">
                            <c:forEach var="cmt" items="${commentList}">
                                <div class="border-bottom border-secondary border-opacity-10 pb-2">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <span class="fw-bold small">${cmt.writer_name}</span>
                                        <div class="text-muted small">
                                            <fmt:formatDate value="${cmt.postdate}" pattern="yyyy.MM.dd HH:mm"/>
                                            <c:if test="${sessionScope.UserId == cmt.writer_id}">
                                                <a href="#" onclick="deleteComment('${cmt.cnum}', '${dto.num}')" class="text-danger text-decoration-none ms-2">[삭제]</a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="text-dark small">${cmt.content}</div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty commentList}">
                                <p class="text-center text-muted small py-3">첫 번째 댓글을 남겨보세요!</p>
                            </c:if>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty dto}">
                    <div class="text-center py-5">
                        <h3>게시글을 찾을 수 없습니다.</h3>
                        <a href="list.do" class="btn btn-secondary mt-3">목록으로 돌아가기</a>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
</div>

<script>
    function deletePost(num) {
        if(confirm('정말 이 게시글을 삭제하시겠습니까?')) {
            location.href = 'delete.do?num=' + num;
        }
    }
    function deleteComment(cnum, bnum) {
        if(confirm('댓글을 삭제하시겠습니까?')) {
            location.href = 'deleteComment.do?cnum=' + cnum + '&bnum=' + bnum;
        }
    }
</script>

</body>
</html>