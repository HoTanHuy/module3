<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 8/19/2022
  Time: 6:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
<h1>Danh sách khách hàng</h1>

<table class="table table-dark">
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Name</th>
        <th>BirthDay</th>
        <th>Address</th>
        <th>IMG</th>
    </tr>
    <c:forEach var="client" items="${clientList}" varStatus="status">
        <tr>
        <td>${status.count}</td>
        <td>${client.id}</td>
        <td>${client.name}</td>
        <td>${client.birthday}</td>
        <td>${client.address}</td>
        <td>
                <img width="20%" height="20%" src="${client.img}">
        </td>
        </tr>

    </c:forEach>
</table>
</body>
</html>
