package com.eventsphere.controller;

import com.eventsphere.dao.StudentDAO;
import com.eventsphere.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listStudents(request, response);
                    break;
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                default:
                    listStudents(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createStudent(request, response);
            } else if ("update".equals(action)) {
                updateStudent(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        String search = request.getParameter("search");
        List<Student> students;
        
        if (search != null && !search.trim().isEmpty()) {
            students = studentDAO.searchStudents(search);
        } else {
            students = studentDAO.getAllStudents();
        }
        
        request.setAttribute("students", students);
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/student-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student-form.jsp").forward(request, response);
    }

    private void createStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String department = request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));
        String phone = request.getParameter("phone");

        // First, create the user account
        com.eventsphere.dao.UserDAO userDAO = new com.eventsphere.dao.UserDAO();
        com.eventsphere.model.User user = new com.eventsphere.model.User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("STUDENT");
        
        user = userDAO.createUser(user);
        
        if (user != null) {
            // Then create the student profile
            Student student = new Student();
            student.setUserId(user.getId());
            student.setFullName(fullName);
            student.setDepartment(department);
            student.setYear(year);
            student.setPhone(phone);
            
            studentDAO.createStudent(student);
            response.sendRedirect(request.getContextPath() + "/students?action=list&success=created");
        } else {
            request.setAttribute("error", "Failed to create user account");
            request.getRequestDispatcher("/student-form.jsp").forward(request, response);
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String department = request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));
        String phone = request.getParameter("phone");

        Student student = new Student();
        student.setId(id);
        student.setFullName(fullName);
        student.setDepartment(department);
        student.setYear(year);
        student.setPhone(phone);

        studentDAO.updateStudent(student);
        response.sendRedirect(request.getContextPath() + "/students?action=list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect(request.getContextPath() + "/students?action=list");
    }
}
