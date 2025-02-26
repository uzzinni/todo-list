<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zin.dto.Todo" %>

<%
    List<Todo> todos = (List<Todo>) request.getAttribute("todos");
    if (todos == null) {
        response.sendRedirect("listTodo");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h1 {
            text-align: center;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            padding: 10px;
            margin: 5px 0;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex;
            align-items: center;
        }
        .todo-content {
            display: inline-block;
            width: 65%;
            cursor: pointer;
        }
        .todo-actions {
            display: inline-block;
            width: 30%;
            text-align: right;
        }
        .completed {
            text-decoration: line-through;
            color: gray;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <h1>Todo List</h1>

    <!-- Add Todo Form -->
    <form action="addTodo" method="post">
        <input type="text" name="title" placeholder="제목을 입력하세요" required>
        <input type="text" name="description" placeholder="설명을 입력하세요" required>
        <button type="submit">추가하기</button>
    </form>

    <!-- Todo List -->
    <h2>Todo 목록</h2>
    <ul>
        <% if (todos != null) {
               for (Todo todo : todos) { %>
            <li>
                <form action="toggleCompletion" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= todo.getId() %>">
                    <input type="checkbox" name="completed" onchange="this.form.submit()" <%= todo.isCompleted() ? "checked" : "" %>>
                </form>
                <span class="todo-content <%= todo.isCompleted() ? "completed" : "" %>" 
                      onclick="openViewModal('<%= todo.getTitle() %>', '<%= todo.getDescription() %>')">
                    <%= todo.getTitle() != null ? todo.getTitle() : "(제목 없음)" %>
                </span>
                <span class="todo-actions">
                    <button onclick="openEditModal('<%= todo.getId() %>', '<%= todo.getTitle() %>', '<%= todo.getDescription() %>')">수정</button>
                    <form action="deleteTodo" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= todo.getId() %>">
                        <button type="submit">삭제</button>
                    </form>
                </span>
            </li>
        <% } } %>
    </ul>

    <!-- View Modal -->
    <div id="viewModal" class="modal">
        <h2>Todo 상세 보기</h2>
        <p><strong>제목:</strong> <span id="viewTitle"></span></p>
        <p><strong>설명:</strong> <span id="viewDescription"></span></p>
        <button type="button" onclick="closeViewModal()">닫기</button>
    </div>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <h2>Todo 수정</h2>
        <form action="editTodo" method="post">
            <input type="hidden" id="editId" name="id">
            <input type="text" id="editTitle" name="title" required>
            <input type="text" id="editDescription" name="description" required>
            <button type="submit">저장</button>
            <button type="button" onclick="closeEditModal()">닫기</button>
        </form>
    </div>

    <script>
        function openViewModal(title, description) {
            document.getElementById("viewTitle").innerText = title;
            document.getElementById("viewDescription").innerText = description;
            document.getElementById("viewModal").style.display = "block";
        }

        function closeViewModal() {
            document.getElementById("viewModal").style.display = "none";
        }

        function openEditModal(id, title, description) {
            document.getElementById("editId").value = id;
            document.getElementById("editTitle").value = title;
            document.getElementById("editDescription").value = description;
            document.getElementById("editModal").style.display = "block";
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>

</body>
</html>
