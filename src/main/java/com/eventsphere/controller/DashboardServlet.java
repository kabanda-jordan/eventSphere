package com.eventsphere.controller;

import com.eventsphere.dao.EventDAO;
import com.eventsphere.dao.StudentDAO;
import com.eventsphere.dao.RegistrationDAO;
import com.eventsphere.model.Event;
import com.eventsphere.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class DashboardServlet extends HttpServlet {
    private EventDAO eventDAO;
    private StudentDAO studentDAO;
    private RegistrationDAO registrationDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        studentDAO = new StudentDAO();
        registrationDAO = new RegistrationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            String role = (String) session.getAttribute("role");

            List<Event> events = eventDAO.getActiveEvents();
            request.setAttribute("events", events);

            if ("STUDENT".equals(role)) {
                Student student = studentDAO.getStudentByUserId(userId);
                if (student != null) {
                    request.setAttribute("student", student);
                    request.setAttribute("registrations", registrationDAO.getStudentRegistrations(student.getId()));
                }
            }

            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
