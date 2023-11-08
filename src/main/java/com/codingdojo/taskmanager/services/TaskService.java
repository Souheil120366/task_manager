package com.codingdojo.taskmanager.services;

import org.springframework.stereotype.Service;

import com.codingdojo.taskmanager.models.User;
import com.codingdojo.taskmanager.models.Task;
import com.codingdojo.taskmanager.repositories.TaskRepository;

import java.util.List;
import java.util.Optional;

@Service
public class TaskService {

	// adding the Task repository as a dependency
	private final TaskRepository taskRepository;

	public TaskService(TaskRepository taskRepository) {
		this.taskRepository = taskRepository;
	}

	// returns all the tasks
	public List<Task> allTasks(User user) {
		return taskRepository.findAllByUser(user);
	}

	// returns all the tasks
	public List<Task> tasksByPriority(User user, String priority) {
		return taskRepository.findByUserAndPriority(user, priority);
	}

	// returns all the tasks
	public List<Task> tasksByTitle(User user, String word) {
		return taskRepository.findByUserAndTitleContaining(user, word);
	}

	// creates a task
	public Task createTask(Task task) {
		return taskRepository.save(task);
	}

	// retrieves a task 
	public Task findTask(Long id) {
		Optional<Task> optionalTask = taskRepository.findById(id);
		if (optionalTask.isPresent()) {
			return optionalTask.get();
		} else {
			return null;
		}
	}

	public Task updateTask(Task task) {

		return taskRepository.save(task);
	}

	// to delete a task, we simply pass in the task ID and if our repository finds
	// it, the task will be deleted
	public void deleteTask(Long id) {
		Optional<Task> optionalTask = taskRepository.findById(id);
		if (optionalTask.isPresent()) {
			taskRepository.deleteById(id);
		}
	}

}
