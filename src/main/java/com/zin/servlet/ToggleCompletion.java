package com.zin.servlet;

import com.zin.dao.TodoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/toggleCompletion")
public class ToggleCompletion extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean completed = request.getParameter("completed") != null;

        TodoDAO todoDAO = new TodoDAO();
        todoDAO.updateCompletionStatus(id, completed);

        response.sendRedirect("listTodo"); // 변경 후 리스트 페이지로 이동
    }
}
