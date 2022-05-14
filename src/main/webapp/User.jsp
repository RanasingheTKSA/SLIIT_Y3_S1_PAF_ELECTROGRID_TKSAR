
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%@ page import="java.util.*" %>
<%@ page import="com.electrogrid.model.*" %>
<%@ page import="com.electrogrid.repository.*" %>



<%
	UserRepository userrepository=new UserRepository();
	List<User> users= userrepository.getUsers();
	
	User userValueRow = new User();
%>

    
    
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="views/bootstrap.min.css">
<link rel="stylesheet" href="views/user.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="components/user.js"></script>

<meta charset="ISO-8859-1">

<title>User List</title>
</head>
<body>

<figure class="text-center">
	<blockquote class="blockquote">
		<h2><b>USER MANAGEMENT</b></h2>
	</blockquote>
	<figcaption class="blockquote-footer">
		MANAGE THE USER DETAILS
	</figcaption>
</figure>


<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>MANAGE <b>USERS</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="#addUserModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New User</span></a>												
					</div>
				</div>
			</div>
			<table class="table table-striped table-hover" id="displayUsers">
				<thead>
					<tr>						
						<th>Name</th>
						<th>NIC</th>
 						<th>Address</th>
 						<th>Zip Code</th>
 						<th>Email</th>
						<th>Phone</th> 
	 					<th>Actions</th>
					</tr>
				</thead>
				<tbody>
				
				<%for (int recodeCount = 0; recodeCount < users.size();recodeCount++){ %>
				<% User user = users.get(recodeCount); %>
				<% userValueRow = user; %>
				
 					<tr>						
						<td><%= user.getUser_name() %> </td>
 						<td><%= user.getUser_nic() %> </td>
 						<td><%= user.getUser_address() %> </td>
 						<td><%= user.getUser_zip_code() %> </td>
 						<td><%= user.getUser_email() %> </td>
 						<td><%= user.getUser_contact_number() %></td>
											
						<td>
							<a href="#editUserModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
							<a href="#deleteUserModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
						</td>
					</tr>
				<%} %>
				</tbody>
			</table>
			
			<div class="clearfix">
				<div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
				<ul class="pagination">
					<li class="page-item disabled"><a href="#">Previous</a></li>
					<li class="page-item"><a href="#" class="page-link">1</a></li>
					<li class="page-item"><a href="#" class="page-link">2</a></li>
					<li class="page-item active"><a href="#" class="page-link">3</a></li>
					<li class="page-item"><a href="#" class="page-link">4</a></li>
					<li class="page-item"><a href="#" class="page-link">5</a></li>
					<li class="page-item"><a href="#" class="page-link">Next</a></li>
				</ul>
			</div>
		</div>
	</div>        
</div>

<!-- Add Modal HTML -->
<div id="addUserModal" name = "addUserModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="addformUser" name="addformUser">
				<div class="modal-header">						
					<h4 class="modal-title">ADD USER</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<div class="form-group">
						<label>Name</label>
						<input type="text" class="form-control" id = "name" name = "name" required>
					</div>
					<div class="form-group">
						<label>NIC</label>
						<input type="text" class="form-control" id = "nic" name = "nic" required>
					</div>					
					<div class="form-group">
						<label>Address</label>
						<input class="form-control" id = "address" name = "address" required>
					</div>
					<div class="form-group">
						<label>Zip Code</label>
						<input type="text" class="form-control" id = "zipcode" name = "zipcode" required>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="email" class="form-control" id = "email" name = "email" required>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" id = "phone" name = "phone" required>
					</div>
										
				</div>
				<div id="alertSuccess" class="alert alert-success"></div>
				<div id="alertError" class="alert alert-danger"></div>
				
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" class="btn btn-success" id = "addUser" name = "addUser" value="Add">
				</div>
			</form>
		</div>
	</div>
</div>

	
<!-- Edit Modal HTML -->
<div id="editUserModal" name = "editUserModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="editformUser" name="editformUser">
				<div class="modal-header">						
					<h4 class="modal-title">EDIT USER</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<input id="uId" name="uId" value= <%= userValueRow.getId()%> type ="hidden">
				<div class="modal-body">					
					<div class="form-group">
						<label>Name</label>
						<input type="text" id = "ename" name = "ename" value= <%= userValueRow.getUser_name()%> class="form-control" required>
					</div>
					<div class="form-group">
						<label>NIC</label>
						<input type="text" id = "enic" name = "enic" value= <%= userValueRow.getUser_nic()%> class="form-control" required>
					</div>
					<div class="form-group">
						<label>Address</label>
						<input type = "text" class="form-control" id = "eaddress" value= <%= userValueRow.getUser_address()%> name = "eaddress"  required>
					</div>
					<div class="form-group">
						<label>ZIP Code</label>
						<input type="text" id = "ezipcode" name = "ezipcode" value= <%= userValueRow.getUser_zip_code()%> class="form-control" required>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="email" id = "eemail" name = "eemail" value= <%= userValueRow.getUser_email()%> class="form-control" required>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" id = "ephone" name = "ephone" value= <%= userValueRow.getUser_contact_number()%> class="form-control" required>
					</div>				
				</div>
				<div id="editSuccess" class="edit alert-success"></div>
				<div id="editError" class="edit alert-danger"></div>
				
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" id = "esave" name = "esave" class="btn btn-info" value="Save">
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Delete Modal HTML -->
<div id="deleteUserModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action = "#" method = "get" id="table">
				<div class="modal-header">						
					<h4 class="modal-title">Delete User</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<p>Are you sure you want to delete these Records?</p>
					<p class="text-warning"><small>This action cannot be undone.</small></p>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="submit" id = "delete" name = "delete" class="btn btn-danger" value="Delete">
				</div>
			</form>
		</div>
	</div>
</div>

</body>
</html>
