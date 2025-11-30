package com.bp2501901.util;

public class BoardPage {
    public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String reqUrl) {
        String pagingStr = "";

        // 전체 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 현재 페이지 블록의 시작 번호 (1, 6, 11...)
        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;

        // [이전 블록] 링크
        if (pageTemp != 1) {
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?pageNum=1'>First</a></li>";
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?pageNum=" + (pageTemp - 1) + "'>Prev</a></li>";
        }

        // [페이지 번호] 출력
        int blockCount = 1;
        while (blockCount <= blockPage && pageTemp <= totalPages) {
            if (pageTemp == pageNum) {
                // 현재 페이지는 링크 없이 활성화(active) 표시
                pagingStr += "<li class='page-item active'><span class='page-link'>" + pageTemp + "</span></li>";
            } else {
                pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?pageNum=" + pageTemp + "'>" + pageTemp + "</a></li>";
            }
            pageTemp++;
            blockCount++;
        }

        // [다음 블록] 링크
        if (pageTemp <= totalPages) {
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?pageNum=" + pageTemp + "'>Next</a></li>";
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?pageNum=" + totalPages + "'>Last</a></li>";
        }

        return pagingStr;
    }
}