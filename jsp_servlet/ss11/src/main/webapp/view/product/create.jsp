<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 8/23/2022
  Time: 10:19 PM
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
<h1> Add New </h1>
<a class="btn btn-outline-dark" href="/product">Back</a>
<c:if test="${mess!=null}">
    <p style="color: red">${mess}</p>
</c:if>
<form class="form form-control" action="/product?action=create" method="post">
    <pre>ID:               <input type="text" name="id"></pre>
    <pre>Name:             <input type="text" name="name"></pre>
    <pre>Price:            <input type="text" name="price"></pre>
    <pre>Describe:         <input type="text" name="describe"></pre>
    <pre>Producer:         <input type="text" name="producer"></pre>
    <pre>                  <button>Save</button></pre>
</form>
</body>
</html>
