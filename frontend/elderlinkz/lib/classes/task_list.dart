import 'dart:convert';

import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';

class TaskList extends ChangeNotifier {

  TaskList({ required this.taskList });

  final List<Task> taskList;

  static List<Task> fromStringList(List<String> stringList) {

    // Format mapObj to have proper typing
    return stringList.map(
      (task) {
        final taskObj = json.decode(task) as Map<String, dynamic>;

        return Task(
          id: taskObj["id"] ?? 0,
          name: taskObj["name"],
          // category: taskObj["category"],
          deadline: DateTime.tryParse(taskObj["deadline"]) ?? DateTime.now(),
          completed: taskObj["completed"] ?? false,
        );
      }
        
    )
    .toList();
  
  }

  Task? setTask(Task newTask) {

    int taskIndex = taskList
      .indexWhere(
      (task) =>
        task.id == newTask.id
    );

    if (taskIndex > 0) {
      taskList[taskIndex] = newTask;
    }
    else {
      taskList.add(newTask);
    }

    prefs.setStringList("tasks",
      taskList.map(
        (task) => 
          task.toJson()
      )
      .toList()
    );

    notifyListeners();

    return null;

  }

  Task addTask({
    required String name,
    required DateTime deadline,
    required bool completed
  }) {

    Task task = Task(
      id: taskList.length + 1,
      name: name,
      deadline: deadline,
      completed: completed
    );

    setTask(task);

    return task;

  }

  void deleteTask(int taskId) {

    taskList.removeWhere((task) => task.id == taskId);

    prefs.setStringList("tasks",
      taskList.map(
        (task) => 
          task.toJson()
      )
      .toList()
    );

    notifyListeners();

  }

}

class Task {

  const Task({
    required this.id,
    required this.name,
    required this.deadline,
    required this.completed,
  });
  
  final int id;
  final String name;
  final DateTime deadline;
  final bool completed;

  Task setName(String newName) =>
    Task(
      id: id,
      name: newName,
      deadline: deadline,
      completed: completed
    );

  Task setDeadline(DateTime newDeadline) =>
    Task(
      id: id,
      name: name,
      deadline: newDeadline,
      completed: completed
    );

  Task setCompleted(bool newCompleted) =>
    Task(
      id: id,
      name: name,
      deadline: deadline,
      completed: newCompleted
    );

  String toJson() =>
    json
      .encode({
        "id": id,
        "name": name,
        "deadline": deadline.toString(),
        "completed": completed
      });

}