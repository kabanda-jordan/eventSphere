package com.eventsphere.controller;

import com.eventsphere.dao.EventDAO;
import com.eventsphere.dao.RegistrationDAO;
import com.eventsphere.dao.StudentDAO;
import com.eventsphere.model.Event;
import com.eventsphere.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class EventServlet extends HttpServlet {
    private EventDAO eventDAO;
    private RegistrationDAO registrationDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        registrationDAO = new RegistrationDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "list":
                    listEvents(request, response);
                    break;
                case "view":
                    viewEvent(request, response);
                    break;
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteEvent(request, response);
                    break;
                case "register":
                    registerForEvent(request, response);
                    break;
                case "cancel":
                    cancelRegistration(request, response);
                    break;
                default:
                    listEvents(request, response);
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
        
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createEvent(request, response);
            } else if ("update".equals(action)) {
                updateEvent(request, response);
            }
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void listEvents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        String search = request.getParameter("search");
        List<Event> events;
        
        if (search != null && !search.trim().isEmpty()) {
            events = eventDAO.searchEvents(search);
        } else {
            events = eventDAO.getAllEvents();
        }
        
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        
        if ("STUDENT".equals(role)) {
            Student student = studentDAO.getStudentByUserId(userId);
            if (student != null) {
                request.setAttribute("studentId", student.getId());
            }
        }
        
        request.setAttribute("events", events);
        request.getRequestDispatcher("/events.jsp").forward(request, response);
    }

    private void viewEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Event event = eventDAO.getEventById(id);
        
        request.setAttribute("event", event);
        request.setAttribute("registrations", registrationDAO.getEventRegistrations(id));
        request.getRequestDispatcher("/event-detail.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/events?action=list");
            return;
        }
        
        request.getRequestDispatcher("/event-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        String role = (String) session.getAttribute("role");
        
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/events?action=list");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        Event event = eventDAO.getEventById(id);
        
        request.setAttribute("event", event);
        request.getRequestDispatcher("/event-form.jsp").forward(request, response);
    }

    private void createEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ParseException, IOException {
        
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");
        
        Event event = new Event();
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setLocation(request.getParameter("location"));
        event.setCapacity(Integer.parseInt(request.getParameter("capacity")));
        event.setCreatedBy(userId);
        event.setStatus("ACTIVE");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date date = sdf.parse(request.getParameter("eventDate"));
        event.setEventDate(new Timestamp(date.getTime()));
        
        eventDAO.createEvent(event);
        response.sendRedirect(request.getContextPath() + "/events?action=list");
    }

    private void updateEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ParseException, IOException {
        
        Event event = new Event();
        event.setId(Integer.parseInt(request.getParameter("id")));
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setLocation(request.getParameter("location"));
        event.setCapacity(Integer.parseInt(request.getParameter("capacity")));
        event.setStatus(request.getParameter("status"));
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date date = sdf.parse(request.getParameter("eventDate"));
        event.setEventDate(new Timestamp(date.getTime()));
        
        eventDAO.updateEvent(event);
        response.sendRedirect(request.getContextPath() + "/events?action=list");
    }

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        eventDAO.deleteEvent(id);
        response.sendRedirect(request.getContextPath() + "/events?action=list");
    }

    private void registerForEvent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        
        Student student = studentDAO.getStudentByUserId(userId);
        
        if (student != null) {
            if (registrationDAO.isStudentRegistered(student.getId(), eventId)) {
                response.sendRedirect(request.getContextPath() + "/events?action=list&error=already_registered");
                return;
            }
            
            Event event = eventDAO.getEventById(eventId);
            if (event.isFull()) {
                response.sendRedirect(request.getContextPath() + "/events?action=list&error=event_full");
                return;
            }
            
            registrationDAO.createRegistration(student.getId(), eventId);
        }
        
        response.sendRedirect(request.getContextPath() + "/events?action=list&success=registered");
    }

    private void cancelRegistration(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        
        Student student = studentDAO.getStudentByUserId(userId);
        
        if (student != null) {
            registrationDAO.cancelRegistration(student.getId(), eventId);
        }
        
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}
