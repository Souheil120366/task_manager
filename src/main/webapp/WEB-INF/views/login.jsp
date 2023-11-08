<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<title>Read Share</title>
	
	<!-- for Bootstrap CSS -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- YOUR own local CSS -->
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	
	<!-- For any Bootstrap that uses JS -->
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<script type="text/javascript" src="/js/clearErrors.js"></script>		
	
</head>
<body>

	<div class="container-fluid vh-100 mt-5 custom-width align-items-center">
		<div class="d-flex mt-2 justify-content-end">
			<p><a href="/register_page">Don't Have an Account? Register</a></p>
		</div>
		
		
		<div class="col-md-10">
		<h1 class="text-center">Welcome Back!</h1>
		<br>
		<form:form action="/login" method="POST" modelAttribute="newLogin">
			<form:errors id="emailErrors" path="email" class="text-danger"/>
			<div class="form-group d-flex align-items-center">
        		<form:label class="col-md-3" path="email">Email: </form:label>
        		<form:input type="email" class="form-control" id="email" path="email"/>
        	</div>
        	<br>
        	<form:errors id="passwordErrors" path="password" class="text-danger"/>
        	<div class="form-group d-flex align-items-center">
        		<form:label class="col-md-3" path="password">Password: </form:label>
        		<form:input type="password" class="form-control" id="password" path="password"/>
        	</div>
        	<br>
        	<div class="form-group d-flex align-items-center">
        	<div class="col-md-3"></div>
        	
				<button type="submit" class="btn btn-primary btn-block">Submit</button>
			
			</div>
			
		</form:form>
	</div>
	</div>
    
    </body>
    </html>