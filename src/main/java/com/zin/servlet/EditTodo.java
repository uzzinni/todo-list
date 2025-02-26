package com.zin.servlet;

import com.zin.dao.TodoDAO;
import com.zin.dto.Todo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editTodo")
public class EditTodo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        TodoDAO todoDAO = new TodoDAO();
        todoDAO.updateTodo(new Todo(id, title, description, false, null));

        response.sendRedirect("listTodo"); // 수정 후 리스트 페이지로 이동
    }
}
