package com.zin.servlet;

import com.zin.dao.TodoDAO;
import com.zin.dto.Todo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addTodo")
public class AddTodo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        
        Todo todo = new Todo(0, title, description, false, null);
        TodoDAO todoDAO = new TodoDAO();
        todoDAO.addTodo(todo);
        
        response.sendRedirect("listTodo");
    }
}