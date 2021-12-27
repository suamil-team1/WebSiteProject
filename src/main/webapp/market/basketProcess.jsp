<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
//이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function(){
    

    // 수량변경 - 이벤트 델리게이션으로 이벤트 종류 구분해 처리

    document.querySelectorAll('.updown').forEach(

        function(item, idx){

            item.querySelector('input').addEventListener('keyup', function(){

                basket.changePNum(idx+1);

            });

            //수량 증가 화살표 클릭

            item.children[1].addEventListener('click', function(){

                basket.changePNum(idx+1);

            });

            //수량 감소 화살표 클릭

            item.children[2].addEventListener('click', function(){

                basket.changePNum(idx+1);

            });

        }

    );

    //앵커 # 대체해 스크롤 탑 차단

    document.querySelectorAll('a[href="#"]').forEach(function(item){

        item.setAttribute('href','javascript:void(0)');

    });

});
</script>
</head>
<body>

</body>
</html>