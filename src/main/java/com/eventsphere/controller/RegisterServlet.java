package com.eventsphere.controller;

import com.eventsphere.dao.StudentDAO;
import com.eventsphere.dao.UserDAO;
import com.eventsphere.model.Student;
import com.eventsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String department = request.getParameter("department");
        String yearStr = request.getParameter("year");
        String phone = request.getParameter("phone");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            if (userDAO.isUsernameExists(username)) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            if (userDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email already exists");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole("STUDENT");

            User createdUser = userDAO.createUser(user);

            if (createdUser != null) {
                Student student = new Student();
                student.setUserId(createdUser.getId());
                student.setFullName(fullName);
                student.setDepartment(department);
                student.setYear(Integer.parseInt(yearStr));
                student.setPhone(phone);

                studentDAO.createStudent(student);

                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}
