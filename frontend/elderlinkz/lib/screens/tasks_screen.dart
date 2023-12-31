import 'package:elderlinkz/classes/task_list.dart';
import 'package:elderlinkz/widgets/add_task_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
    // required this.category,
    // required this.tasks
  });

  // final String category;
  // final List<Task> tasks;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  bool showCompletedTasks = false;

  // List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TaskList taskList = context
      .read<TaskList>();

    List<Task> tasks = context
      .watch<TaskList>().taskList;

    List<Task> completedTasks = tasks
      .where((task) => task.completed)
      .toList();

    // debugPrint(taskList.toJson());

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height - 200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Uncompleted Task List Section
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(widget.category,
                  const Text("Tasks",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () { addTask(taskList); },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()
                    ),
                    child: Icon(Icons.add,
                      // size: 30,
                      color: colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
            ...tasks
              .where((task) => !task.completed)
              .map(
                (task) =>
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ListTile(
                        title: Text(task.name),
                        onTap: () { editTask(taskList, task); }
                      );
                    }
                  )
              ),
    
            // Completed Task Section
            if (completedTasks.isNotEmpty)
              ListTile(
                onTap: toggleCompletedTasks,
                title: const Text("Completed Tasks"),
                trailing: Icon(
                  showCompletedTasks ?
                    Icons.arrow_drop_down :
                    Icons.arrow_drop_up
                ),
              ),
            if (showCompletedTasks)
              ...completedTasks
                .map(
                  (task) =>
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return ListTile(
                          title: Text(task.name),
    
                        );
                      }
                    )
                )
          ]
        ),
      ),
    );
  }














  // OnTap Functions
  
  // Show Completed Tasks
  void toggleCompletedTasks() {
    setState(() {
      showCompletedTasks = !showCompletedTasks;
    });
  }
  
  // Open SetTask Modal
  openSetTaskModal(Task task) {
    showDialog(
      context: context,
      builder:
        (context) =>
          AddTaskModal(
            task: task
          )
    );
  }

  void addTask(TaskList taskList) {
    
    openSetTaskModal(
      taskList.addTask(
        name: 'New Task',
        // category: 'Tasks',
        deadline: DateTime.now(),
        completed: false
      )
    );

  }

  void editTask(TaskList taskList, Task task) {
    
    openSetTaskModal(task);

  }
}