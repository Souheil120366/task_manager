<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Read Share</title>

<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />

<!-- YOUR own local CSS -->
<link rel="stylesheet" type="text/css" href="/css/style.css">

<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>


</head>
<body>

<div class="container-fluid vh-100 mt-5 custom-width  align-items-center">
	<div class="form-group mt-3 mb-4 d-flex justify-content-between align-items-center">
		<h1>Task View</h1>
		<p><a href="/tasks">Dashboard</a></p>
	</div> 

	<div class="form-group d-flex align-items-center">
		<h5 class="col-md-3">Title: </h5>
		<h6>${task.title}</h6>
	</div>
	<br>

	<div class="form-group d-flex align-items-center">
		<h5 class="col-md-3">Description: </h5>
		<h6>${task.description}</h6>
	</div>
	<br>

	<div class="form-group d-flex align-items-center">
		<h5 class="col-md-3">Due Date: </5>
		<h6><fmt:formatDate value="${task.due_date}" pattern="MMMM dd, yyyy"/></h6>
	</div>
	<br>
	
	<div class="form-group d-flex align-items-center">
		<h5 class="col-md-3">Priority: </h5>
		<h6>${task.priority}</h6>
	</div>
	<br>
	
	<div class="form-group d-flex align-items-center">
		<h5 class="col-md-3">Added on: </5>
		<h6><fmt:formatDate value="${task.createdAt}" pattern="MMMM dd, yyyy @ hh:mm a"/></h6>
	</div>
	<br>
	<c:set var="isUpdated" value="${task.updatedAt != null}" />
	<c:choose>
 	<c:when test="${isUpdated}">
 		<div class="form-group d-flex align-items-center">
 			<h5 class="col-md-3">Last updated on: </5>
 			<h6><fmt:formatDate value="${task.updatedAt}" pattern="MMMM dd, yyyy @ hh:mm a"/></h6>
 		</div>
 		<br>
     </c:when>
 </c:choose>

</div>

</body>
</html>