import 'dart:convert';

import 'package:elderlinkz/globals.dart';
import 'package:flutter/material.dart';

class TaskList extends ChangeNotifier {

  TaskList({ required this.taskList });

  // final Map<String, List<Task>> taskList;
  final List<Task> taskList;

  // static Map<String, List<Task>> fromMap(Map mapObj) {

  //   // Format mapObj to have proper typing
  //   return (mapObj as Map<String, dynamic>)
  //     .map(
  //       (key, value) =>
  //         MapEntry(
  //           key,
  //           (value as List)
  //             .map(
  //               (task) {
  //                 final taskObj = json.decode(task) as Map<String, dynamic>;

  //                 return Task(
  //                   id: taskObj["id"] ?? 0,
  //                   name: taskObj["name"],
  //                   // category: taskObj["category"],
  //                   deadline: DateTime.tryParse(taskObj["deadline"]) ?? DateTime.now(),
  //                   completed: taskObj["completed"] ?? false,
  //                 );
  //               }
                  
  //             )
  //             .toList()
  //         )
  //     );
  
  // }

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

  // static Map<String, List<Task>> fromJson(String jsonObj) {
  //   return TaskList.fromMap(json.decode(jsonObj));
  // }

  Task? setTask(Task newTask) {
    
    // if (taskList[task.category] != null) {
    //   int taskIndex = taskList[task.category]
    //     !.indexWhere(
    //       (categoryTask) =>
    //         task.id == categoryTask.id
    //     );

    //   if (taskIndex != -1) {
    //     taskList[task.category]![taskIndex] = task;
    //   }

    //   else {
    //     taskList[task.category]!.add(task);
    //   }

    //   prefs.setString("tasks",
    //     json.encode(
    //       taskList
    //       .map(
    //         (key, value) =>
    //           MapEntry(
    //             key,
    //             value
    //               .map(
    //                 (task) => 
    //                   task.toJson()
    //               )
    //               .toList()
    //           )
    //       )
    //     )
    //   );

    //   notifyListeners();

    //   return task;
    // }

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
    // required String category,
    required DateTime deadline,
    required bool completed
  }) {

    Task task = Task(
      // id: taskList.values.expand((task) => task).length + 1,
      id: taskList.length + 1,
      name: name,
      // category: category,
      deadline: deadline,
      completed: completed
    );

    setTask(task);

    return task;

  }

  // void newList(String categoryName) {
  //   taskList[categoryName] = [];

  //   prefs.setString("tasks", json.encode(taskList));
  // }

}

class Task {

  const Task({
    required this.id,
    required this.name,
    // required this.category,
    required this.deadline,
    required this.completed,
  });
  
  final int id;
  // final String name, category;
  final String name;
  final DateTime deadline;
  final bool completed;

  Task setName(String newName) =>
    Task(
      id: id,
      name: newName,
      // // category: category,
      deadline: deadline,
      completed: completed
    );

  // Task setCategory(String newCategory) =>
  //   Task(
  //     id: id,
  //     name: name,
  //     category: newCategory,
  //     deadline: deadline,
  //     completed: completed
  //   );

  Task setDeadline(DateTime newDeadline) =>
    Task(
      id: id,
      name: name,
      // // category: category,
      deadline: newDeadline,
      completed: completed
    );

  Task setCompleted(bool newCompleted) =>
    Task(
      id: id,
      name: name,
      // // category: category,
      deadline: deadline,
      completed: newCompleted
    );

  String toJson() =>
    json
      .encode({
        "id": id,
        "name": name,
        // // "category": category,
        "deadline": deadline.toString(),
        "completed": completed
      });

}