import 'package:elderlinkz/classes/task_list.dart';
import 'package:elderlinkz/widgets/add_task_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({ super.key, });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  bool showCompletedTasks = false;
  List<int> selected = [];

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    TaskList taskList = context
      .read<TaskList>();

    List<Task> tasks = context
      .watch<TaskList>().taskList;

    List<Task> completedTasks = tasks
      .where(
        (task) =>
          task.completed
      )
      .toList();

    // debugPrint(taskList.toJson());

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height - 200,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tasks",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () { addDelete(taskList); },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder()
                    ),
                    child:
                      selected.isEmpty ?
                        Icon(Icons.add, color: colorScheme.onBackground,) :
                        Icon(Icons.delete, color: colorScheme.onBackground,),
                  )
                ],
              ),
            ),
            ...tasks
              .where((task) => !task.completed)
              .map(
                (task) =>
                  taskListTile(
                    taskList,
                    task,
                    colorScheme
                  )
              ),
    
            // Completed Task Section
            if (completedTasks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListTile(
                  onTap: toggleCompletedTasks,
                  title: const Text("Completed Tasks"),
                  trailing: Icon(
                    showCompletedTasks ?
                      Icons.arrow_drop_up :
                      Icons.arrow_drop_down
                  ),
                ),
              ),
            if (showCompletedTasks)
              ...completedTasks
                .map(
                  (task) =>
                    taskListTile(
                      taskList,
                      task,
                      colorScheme
                    )
                )
          ]
        ),
      ),
    );

  }














  // taskListTile

  Widget taskListTile(TaskList taskList, Task task, ColorScheme colorScheme) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        selected: selected.contains(task.id),
        selectedColor: colorScheme.onSurface,
        selectedTileColor: colorScheme.secondary.withOpacity(.1),
        onLongPress: () { toggleSelectTask(task.id); },
        title: Text(task.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(task.deadline.toString().split(" ")[0],
          style: const TextStyle(
            fontSize: 10
          ),
        ),
        onTap: selected.isEmpty ?
          () { openSetTaskModal(task); } :
          () { toggleSelectTask(task.id); },
        trailing: Checkbox(
          value: task.completed,
          checkColor: colorScheme.surface,
          activeColor: colorScheme.onSurface,
          onChanged: (value) { setCompleted(taskList, task); },
        ),
      ),
    );














  // OnTap Functions

  // Add Delete Button OnTap
  void addDelete(TaskList taskList) {

    if (selected.isEmpty) { addTask(taskList); }
    else {

      taskList.deleteTasks(selected);
      selected.clear();

    }

  }
  
  // Show Completed Tasks
  void toggleCompletedTasks() {

    setState(() {

      showCompletedTasks = !showCompletedTasks;

    });

  }
  
  // Open SetTask Modal
  Future<void> openSetTaskModal(Task task) async {
    
    showDialog(
      context: context,
      builder:
        (context) =>
          AddTaskModal(task: task)
    );
    
  }

  void addTask(TaskList taskList) {
    
    openSetTaskModal(
      taskList
        .addTask(
          name: 'New Task',
          // category: 'Tasks',
          deadline: DateTime.now(),
          completed: false
        )
    );

  }

  void toggleSelectTask(int id) {

    setState(() {

      if (selected.contains(id)) { selected.remove(id); }
      else { selected.add(id); }

    });

  }

  void setCompleted(TaskList taskList, Task task) {
    
    taskList
      .setTask(
        Task(
          id: task.id,
          name: task.name,
          deadline: task.deadline,
          completed: !task.completed
        )
      );

  }
}