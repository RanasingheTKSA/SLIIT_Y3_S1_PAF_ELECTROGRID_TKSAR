package com.electrogrid.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.electrogrid.model.User;
import com.electrogrid.repository.UserRepository;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	User userObject = new User();

    public UserServlet() {
    	super();
        // TODO Auto-generated constructor stub
    }

    // get users list
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");
		String dispatchPage;
		
		try {
			UserRepository userRepository = new UserRepository();
			List <User> users = userRepository.getUsers();
			
			request.setAttribute("user_list", users);
			
			if(users != null) {
				dispatchPage = "UserList.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(dispatchPage);
				dispatcher.forward(request, response);
			}else {
				pw.println("<script type = 'text/javascript'>");
				pw.println("alert('Not Found Customer Details');");
				pw.println("location = 'UserServlet'");
				pw.println("</script>");
			}
			
		}catch (Exception ex){
			ex.printStackTrace();
		}
				
	}


	// add users
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		UserRepository userRepository = new UserRepository();
		User users = new User();
		
		String name = request.getParameter("name");
		String nic = request.getParameter("nic");
		String address = request.getParameter("address");
		String zipcode = request.getParameter("zipcode");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");

		users.setUser_name(name);
		users.setUser_nic(nic);
		users.setUser_address(address);
		users.setUser_zip_code(zipcode);
		users.setUser_email(email);
		users.setUser_contact_number(phone);

		String output = userRepository.addUser(users);
		response.getWriter().write(output);
		}

	//delete users
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
	    PrintWriter pw = response.getWriter();
		
		String userId = request.getParameter("id");
		
	    try {
	        //Class.forName("com.mysql.jdbc.Driver");
	        //String user = "root";
	        //String pass = "root";
	        //String query = "delete from user_details where email=?";
	        Connection con = DriverManager.getConnection("jdbc:mysql://locahost:3306/dbname", "root", "root");
	        PreparedStatement ps = con.prepareStatement("DELETE FROM `electro_grid`.`user` WHERE (`id` = ?);");
	        ps.setString(1, "name");

	        int i = ps.executeUpdate();

	        if(i > 0) {
	            System.out.println("User successfully removed...");
	        }

	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}
	
	
}
