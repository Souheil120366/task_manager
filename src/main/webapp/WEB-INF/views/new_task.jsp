<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<title>New Task</title>
	
	<!-- for Bootstrap CSS -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	
	<!-- YOUR own local CSS -->
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	
	<!-- For any Bootstrap that uses JS -->
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script type="text/javascript" src="/js/clearErrors.js"></script>
	
	
</head>
<body>


<div class="container mt-2 p-3 custom-width" style="border: 3px solid #ccc;">
	<div class="d-flex mt-2 justify-content-end">

		<p><a href="/tasks">Dashboard</a></p>
	</div>

	<h1>Create a new task</h1>
		
	<br>
	<form:form action="/new/task" method="POST" class="p-3" modelAttribute="task">
		<input type="hidden" name="user" value="${user.id}">
		
		<form:errors id="titleErrors" path="title" class="text-danger"/>
		<div class="form-group d-flex align-items-center">
			<form:label class="col-md-3" path="title">Title: </form:label>
			<form:input type="text" class="form-control" id="title" path="title"/>
		</div>
		<br>
		<form:errors id="descriptionErrors" path="description" class="text-danger"/>
		<div class="form-group d-flex align-items-center">
			<form:label class="col-md-3" path="description">Description</form:label>
			<form:textarea type="text" class="form-control" id="description" path="description" rows="3"/>
		</div>
		<br>
		<form:errors id="dateErrors" path="due_date" class="text-danger"/>
		<div class="form-group d-flex align-items-center">
			<form:label class="col-md-3" path="due_date">Due Date</form:label>
			<form:input type="date" class="form-control" id="date" path="due_date"/>
		</div>
		<br>
		<form:errors id="priorityErrors" path="priority" class="text-danger"/>
		<div class="form-group d-flex align-items-center">
			<form:label class="col-md-3" path="priority">Priority </form:label>
			<form:select path="priority">
				<form:option value="High">High</form:option>
				<form:option value="Medium">Medium</form:option>
				<form:option value="Low">Low</form:option>
			</form:select>
		</div>
  		<div class="d-flex mt-2 justify-content-end">
  			<button type="submit" class="btn btn-primary">Add</button>
  		</div>
  	
  
  	</form:form>
  	
</div>
    
    
</body>
</html>