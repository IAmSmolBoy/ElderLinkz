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
  String category = "";
  String deadline = "";
  String? errorText;

  // Global key to get close modal button size
  final _iconKey = GlobalKey();

  late TextEditingController nameController;
  late TextEditingController deadlineController;
  late TextEditingController categoryController;

  @override
  void initState() {

    name = widget.task.name;
    category = widget.task.category;
    deadline = widget.task.deadline
      .toString()
      .split(" ")[0];

    nameController = TextEditingController(text: name);
    deadlineController = TextEditingController(text: deadline);
    categoryController = TextEditingController(text: category);

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

    List<String> categories = {
      "Tasks",
      ...taskList
        .taskList
        .keys
        .toSet(),
    }
    .toList();

    return Center(
      child: Card(
        child: Container(
          height: modalSize.height,
          width: modalSize.width,
          color: colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            // padding: EdgeInsets.zero,
            child: Column(
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
                        decoration: const InputDecoration( border: InputBorder.none, ),
                        onTapOutside: (_) { FocusManager.instance.primaryFocus?.unfocus(); },
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        onChanged: (value) => nameOnChange(value, taskList),
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
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.calendar_today),
                      enabledBorder: const OutlineInputBorder( borderSide: BorderSide.none ),
                      errorText: errorText
                    ),
                    onTap: () { deadlineOnChange(taskList); },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: DropdownButton<String>(
                    value: category,
                    onChanged: (String? category) { categoryOnChange(category, taskList); },
                    items: categories
                      .map(
                        (taskCategory) =>
                          DropdownMenuItem(
                            value: taskCategory,
                            child: Text(taskCategory),
                          )
                      )
                      .toList(),
                  ),
                ),
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

    taskList.setTask(
      widget.task
        .setName(value)
    );
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
        deadline = newDeadline
          .toString()
          .split(" ")[0];
      });

      taskList
        .setTask(
          widget.task.setDeadline(newDeadline)
        );
    }

  }

  void categoryOnChange(String? value, TaskList taskList) {
    if (value != null && value.isNotEmpty) {
      setState(() {
        category = value;
      });
      
      taskList.setTask(
        widget.task
          .setCategory(category)
      );
    }
    else {
      errorText = "Please enter task category";
    }
  }

}