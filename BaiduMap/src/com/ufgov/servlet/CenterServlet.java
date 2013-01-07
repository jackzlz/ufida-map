package com.ufgov.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CenterServlet extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2206716139597638786L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("./mapServlet?action=showAllLine").forward(request,response);
	}

}
