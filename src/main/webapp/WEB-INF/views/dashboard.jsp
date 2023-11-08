<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<title>Dashboard</title>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-" crossorigin="anonymous" referrerpolicy="no-referrer" />

	<!-- for Bootstrap CSS -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	
	<!-- YOUR own local CSS -->
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	
	<!-- For any Bootstrap that uses JS -->
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	
	 		
	
</head>
<body>
	
	<div class="container-fluid vh-100 mt-5 custom-width align-items-center">
		<h1>Welcome, ${user.userName} !</h1>
		<div class="d-flex justify-content-between">	
			<p><a href="/tasks/new" class="btn btn-primary">Add a Task</a></p>
			<p><a href="/logout">Logout</a></p>
		</div>
		
			
		<div class="container">
		
	    	<div class="row">
	        	<div class="col-md-6">
	            	<form action="/tasks_by_priority" method="POST" class="p-3">
	                	<div class="form-group mb-0">
	                    	<select name="priority" class="form-control" onchange="this.form.submit()">
	                        	<option value="" disabled selected>FILTER</option>
	                        	<option value="All">All</option>
	                        	<option value="High">High</option>
	                        	<option value="Medium">Medium</option>
	                        	<option value="Low">Low</option>
	                        </select>
	                    </div>
	                </form>
	             </div>
	             <div class="col-md-6">
	             	<form action="/search" method="POST" class="p-3">
	             		<div class="input-group">
	             			<input type="text" class="form-control mr-2" id="searchTitle" name="searchTitle" placeholder="Search...">
	             			<div class="input-group-append">
	             				<button type="submit" class="btn btn-primary">
	             					<i class="fa fa-search" aria-hidden="true"></i>
	             				</button>
	             			</div>
	             		</div>
	             	</form>
	             </div>
	        </div>
	        
	    </div>
	    
		<table class="table">
		
	    <thead>
	        <tr>
	            <th class="w-40">Title</th>
	            <th class="w-10">Deadline</th>
	            <th class="w-10">Priority</th>
	            <th class="w-10">Status</th>
	            <th class="w-30">Actions</th>
	            
	        </tr>
	    </thead>
	    <tbody>
	    	<c:forEach var="oneTask" items="${allTasks}">
	    		<tr>
	    			
	    			<td class="setWidth truncate-text">
	    			    <div><a href="/view/${oneTask.id}">${oneTask.title}</a></div> 
	    			</td>
	    			<td><fmt:formatDate value="${oneTask.due_date}" pattern="MMMM dd, yyyy"/></td>
	    			
	    			<td><c:out value="${oneTask.priority}"></c:out></td>
	    			<td><c:out value="${oneTask.status}"></c:out></td>
	    			
	    			<td class="d-flex justify-content-around align-items-center">
	    				<a href="/edit/${oneTask.id}">
	    					<i class="fa fa-pencil-square custom-icon" aria-hidden="true"></i>
	    				</a>
	    				<a href="/delete/${oneTask.id}">
	    					<i class="fa fa-trash custom-icon red-icon" aria-hidden="true"></i>
	    				</a>
	    				
	    				<form action="/changeStatus" method="POST" >
	    			    	<input type="hidden" name="taskId" value="${oneTask.id}">
	    			    	<input type="hidden" name="status" value="In progress">
	    			    	<button type="submit" class="btn btn-link p-0 border-0 submit-button" >
	    			    		<i class="fa fa-hourglass-half custom-icon purple-icon" aria-hidden="true"></i>
	    			        </button>
	    			     </form>
	    				<form action="/changeStatus" method="POST" >
    						<input type="hidden" name="taskId" value="${oneTask.id}">
    						<input type="hidden" name="status" value="Completed">
    						<button type="submit" class="btn btn-link p-0 border-0 submit-button" >
    							<i class="fa fa-check-square custom-icon green-icon" aria-hidden="true"></i>
    							
    			    		</button>
    					</form>
	    			</td>
	    		</tr>
	    	</c:forEach>
	    </tbody>
	    </table>
	    
    </div>
    
    
</body>
</html>