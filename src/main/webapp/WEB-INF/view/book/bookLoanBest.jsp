<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*, java.net.*, javax.xml.parsers.*, org.xml.sax.*, org.w3c.dom.*"%>
<%@ include file="/WEB-INF/view/layout/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 대출 순위</title>
<style>
.card-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.card {
	width: calc(25% - 20px);
	margin-bottom: 20px;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	background-color: #fff;
}

.card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.card img {
	width: 100%;
	border-radius: 5px;
	margin-bottom: 10px;
}

.card h3 {
	margin-bottom: 10px;
	color: #333;
}

.card p {
	margin: 5px 0;
	color: #666;
}
</style>
</head>
<body>

	<!-- Header Start -->
	<div class="container-fluid bg-primary py-5 mb-5 page-header">
		<div class="container py-5">
			<div class="row justify-content-center">
				<div class="col-lg-10 text-center">
					<h1 class="display-3 text-white animated slideInDown">추천도서</h1>
					<h4 class="text-white animated slideInDown">그린 도서관에서 추천하는 책을 즐겨보세요!</h4>
				</div>
			</div>
		</div>
	</div>
	<!-- Header End -->
	<div class="container">
		<div class="card-container">
			<%
			// API 호출을 위한 URL
			String apiUrl = "http://apis.data.go.kr/6260000/BookLoanBestService/getBookLoanBest?serviceKey=548lbT1deC4nGpPOT2delYJKY0LJeu4AC9sUHSWb1%2Fd5Ti0yAfF1DtKByJrPLT7LOHpkIXPN8uqVzMrvrTALmw%3D%3D&numOfRows=20&pageNo=1&resultType=xml";
			// URL에 쿼리 파라미터 추가

			// XML 데이터 가져오기
			URL url = new URL(apiUrl);
			URLConnection connection = url.openConnection();
			InputStream inputStream = connection.getInputStream();

			// XML 파싱
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(inputStream);
			doc.getDocumentElement().normalize();

			// items 노드 가져오기
			NodeList items = doc.getElementsByTagName("item");

			// 데이터 표시
			for (int i = 0; i < items.getLength(); i++) {
				Node item = items.item(i);
				if (item.getNodeType() == Node.ELEMENT_NODE) {
					Element element = (Element) item;
					String author = element.getElementsByTagName("author").item(0).getTextContent();
					String title = element.getElementsByTagName("title").item(0).getTextContent();
					String shelf_loc_name = element.getElementsByTagName("shelf_loc_name").item(0).getTextContent();
					String image = element.getElementsByTagName("image").item(0).getTextContent();
			%>
			<div class="card">
				<img src="<%=image%>" alt="<%=title%> 표지">
				<h3><%=title%></h3>
				<p>
					저자:
					<%=author%></p>

			</div>
			<%
			}
			}
			inputStream.close();
			%>
		</div>
	</div>

</body>
</html>

<%@ include file="/WEB-INF/view/layout/footer.jsp"%>
