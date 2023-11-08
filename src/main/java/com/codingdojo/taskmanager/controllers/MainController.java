package com.codingdojo.taskmanager.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.taskmanager.models.Task;
import com.codingdojo.taskmanager.models.LoginUser;
import com.codingdojo.taskmanager.models.User;
import com.codingdojo.taskmanager.services.TaskService;
import com.codingdojo.taskmanager.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller

public class MainController {
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	TaskService taskService;
	
	@GetMapping("/")
	public String index() {

		return "redirect:/register_page";
	}
	
	@GetMapping("/register_page")
	public String register_page(Model model) {
		model.addAttribute("newUser", new User());
		return "register.jsp";
	}
	
	@GetMapping("/login_page")
	public String login_page(Model model) {
		model.addAttribute("newLogin", new LoginUser());
		return "login.jsp";
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model,
			HttpSession session) {

		userServ.register(newUser, result);

		if (result.hasErrors()) {

			model.addAttribute("newLogin", new LoginUser());
			return "register.jsp";
		}

		session.setAttribute("userId", newUser.getId());

		return "redirect:/tasks";
	}

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model,
			HttpSession session) {

		User user = userServ.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login.jsp";
		}

		session.setAttribute("userId", user.getId());

		return "redirect:/tasks";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.setAttribute("userId", null);

		return "redirect:/register_page";
	}

	@GetMapping("/tasks")
	public String home(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		User user = userServ.findById(userId);
		List<Task> tasks = taskService.allTasks(user);
		model.addAttribute("allTasks",tasks);
		model.addAttribute("user", user);
		return "dashboard.jsp";
	}
	
	@PostMapping("/tasks_by_priority")
	public String home_by_priority(Model model, HttpSession session, @RequestParam(value = "priority") String priority) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		User user = userServ.findById(userId);
		
		List<Task> tasks;
		if ("All".equals(priority)) {
			
			tasks = taskService.allTasks(user);
		}
		else {
			tasks = taskService.tasksByPriority(user, priority);
		}
		
		model.addAttribute("allTasks",tasks);
		model.addAttribute("user", user);
		return "dashboard.jsp";
	}
	
	@PostMapping("/changeStatus")
	public String updateStatus(@RequestParam(value = "status") String status, @RequestParam(value = "taskId") Long taskId,
			HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		
				
		Task task = taskService.findTask(taskId);
		
		task.setStatus(status);
		
		taskService.updateTask(task);
		
		return "redirect:/tasks";

	}
	
	@RequestMapping("/search")
	public String searchByTitle (Model model, @RequestParam("searchTitle") String searchTitle) {
				
		 return "redirect:/search/"+searchTitle;
	}
	
	@RequestMapping("/search/{searchTitle}")
	public String searchTitle (Model model, @PathVariable("searchTitle") String searchTitle, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		User user = userServ.findById(userId);
		List<Task> tasksByTitle = taskService.tasksByTitle(user, searchTitle);
		if ( !tasksByTitle.isEmpty() ) {
			//System.out.println("************** Hey *********");
			//System.out.println(tasksByTitle);
			model.addAttribute("allTasks",tasksByTitle);
			model.addAttribute("user", user);
			return "dashboard.jsp";
		}
		else return "redirect:/tasks";
	}
	
	@GetMapping("/tasks/new")
	public String newIdea(@ModelAttribute("task") Task task, Model model, HttpSession session) {

		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		User user = userServ.findById(userId);
		model.addAttribute("user", user);

		return "new_task.jsp";
	}
	
	@PostMapping("/new/task")
	public String create(@Valid @ModelAttribute("task") Task task, BindingResult result, HttpSession session, @RequestParam("due_date") String dueDateStr) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		
		// Manually parse the date input from the form into a Date object
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dueDate;
        try {
            dueDate = dateFormat.parse(dueDateStr);
        } catch (ParseException e) {
            result.rejectValue("due_date", "InvalidDateFormat", "Invalid date format");
            return "new_task.jsp";
        }

        // Manually validate the due date
        Date currentDate = new Date();
        if (dueDate.before(currentDate)) {
            result.rejectValue("due_date", "PastDueDate", "Due date must be in the future");
            return "new_task.jsp";
        }

		if (result.hasErrors()) {
			return "new_task.jsp";
		} else {
			taskService.createTask(task);
			
			return "redirect:/tasks";
		}
	}
	
	@GetMapping("/view/{taskId}")
	public String oneTask (Model model,@PathVariable("taskId") Long taskId, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		User user = userServ.findById(userId);
		model.addAttribute("user", user);

		Task task = taskService.findTask(taskId);
		model.addAttribute("task",task);
		
		
		
		return "show_task.jsp";
	}
	
	@RequestMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		User user = userServ.findById(userId);
		model.addAttribute("user", user);
		
        Task task = taskService.findTask(id);
        if ( task != null) {
           model.addAttribute("task", task);
           return "edit_task.jsp";
        }
        
        else return "redirect:/tasks";
    }
    
    @RequestMapping(value="/update/{id}", method=RequestMethod.PUT)
    public String update(@Valid @ModelAttribute("task") Task task, BindingResult result) {
        if (result.hasErrors()) {
            return "edit_task.jsp";
        } else {
            taskService.updateTask(task);
            return "redirect:/tasks";
        }
    }
	
	@RequestMapping("/delete/{taskId}")
	public String deleteTask(@PathVariable("taskId") Long taskId) {
		taskService.deleteTask(taskId);
		return "redirect:/tasks";
	}
}
