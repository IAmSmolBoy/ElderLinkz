import 'package:elderlinkz/classes/task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({
    super.key,
    required this.task,
  });

  // final String categoryName;
  final Task task;

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  double iconWidth = 0;

  // Task values
  String name = "";
  // String category = "";
  bool completed = false;
  DateTime deadline = DateTime.now();
  String deadlineStr = "";
  String? errorText;

  // Global key to get close modal button size
  final _iconKey = GlobalKey();

  late TextEditingController nameController;
  late TextEditingController deadlineController;
  late TextEditingController categoryController;

  @override
  void initState() {

    name = widget.task.name;
    deadline = widget.task.deadline;
    deadlineStr = deadline
      .toString()
      .split(" ")[0];

    nameController = TextEditingController(text: name);
    deadlineController = TextEditingController(text: deadlineStr);
    completed = widget.task.completed;

    // Get width of card
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        iconWidth = _iconKey.currentContext?.size?.width ?? 0.0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;
    Size modalSize = Size(.75 * screenSize.width, .5 * screenSize.height);

    TaskList taskList = context.read<TaskList>();

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: modalSize.width,
          height: modalSize.height,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: modalSize.width - iconWidth - 30,
                          child: TextField(
                            controller: nameController,
                            cursorColor: colorScheme.onSurface,
                            onChanged: (value) { nameOnChange(value, taskList); },
                            decoration: const InputDecoration( border: InputBorder.none, ),
                            onTapOutside: (_) { FocusManager.instance.primaryFocus?.unfocus(); },
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        IconButton(
                          key: _iconKey,
                          iconSize: 25,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(maxWidth: 25),
                          icon: const Icon(FontAwesomeIcons.x),
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                      child: TextField(
                        readOnly: true,
                        controller: deadlineController,
                        onTap: () { deadlineOnChange(taskList); },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          enabledBorder: const OutlineInputBorder( borderSide: BorderSide.none ),
                          errorText: errorText
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const Text("Completed",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Checkbox(
                            value: completed,
                            onChanged: (value) { completedOnChange(value, taskList); },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton
                        .styleFrom(
                          backgroundColor: colorScheme.error
                        ),
                      onPressed: () { onDelete(taskList); },
                      child: Text("DELETE",
                        style: TextStyle(
                          color: colorScheme.onError
                        ),
                      )
                    ),
                    const SizedBox(width: 30,),
                    ElevatedButton(
                      style: ElevatedButton
                        .styleFrom(
                          backgroundColor: colorScheme.secondary
                        ),
                      onPressed: () {},
                      child: Text("SAVE",
                        style: TextStyle(
                          color: colorScheme.onSecondary
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




















  // Functions
  void nameOnChange(String value, TaskList taskList) {

    setState(() {
      name = value;
    });

  }

  void deadlineOnChange(TaskList taskList) async {

    DateTime? newDeadline = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100)
    );

    if (newDeadline != null) {
      setState(() {
        deadline = newDeadline;
        deadlineStr = newDeadline
          .toString()
          .split(" ")[0];
      });
    }

  }
  void completedOnChange(bool? value, TaskList taskList) {

    setState(() {
      completed = value ?? false;
    });

  }

  void onDelete(TaskList taskList) {

    taskList.deleteTask(widget.task.id);

    Navigator.of(context).maybePop();

  }

  void onSave(TaskList taskList) {

    taskList.setTask(
      Task(
        id: widget.task.id,
        name: name,
        deadline: deadline,
        completed: completed
      )
    );

    Navigator.of(context).maybePop();

  }

}