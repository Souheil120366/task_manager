package com.codingdojo.taskmanager.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.taskmanager.models.Task;
import com.codingdojo.taskmanager.models.User;

import java.util.List;


@Repository

public interface TaskRepository extends CrudRepository <Task, Long> {
	List<Task> findAllByUser(User user);
	List<Task> findByUserAndPriority(User user,String priority);
	List<Task> findByUserAndTitleContaining(User user,String word);
	List<Task> findByStatus(String status);
}
