import 'package:elderlinkz/classes/task_list.dart';
import 'package:elderlinkz/widgets/task_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({ super.key });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with TickerProviderStateMixin {

  final newListButtonKey = GlobalKey();
  double newListButtonWidth = 0.0;
  
  late TabController _tabController;

  @override
  void initState() {
    // Get width of TabBar
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        newListButtonWidth = newListButtonKey.currentContext?.size?.width ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    TextStyle tabBarTextStyle = TextStyle(
      color: colorScheme.onSurface,
      fontSize: 17,
    );

    //Task List
    TaskList taskList = context.watch<TaskList>();

    // Get task list
    Map<String, List<Task>> tasks = taskList.taskList;

    // Get all categories
    List<String> categoryNames = {
      "Tasks",
      ...tasks
        .keys
        .toSet(),
    }
    .toList();

    _tabController = TabController(
      vsync: this,
      length: categoryNames.length,
    );

    return Column(
      children: [
        Container(
          width: screenSize.width,
          color: colorScheme.surface,
          child: Row(
            children: [
              if (newListButtonWidth != 0.0) SizedBox(
                width: screenSize.width - newListButtonWidth,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: colorScheme.onSurface,
                  tabs: getTabs(categoryNames, tabBarTextStyle),
                ),
              ),
              ElevatedButton(
                key: newListButtonKey,
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () { newList(taskList); },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        "New List",
                        style: tabBarTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: screenSize.width, maxHeight: screenSize.height - 200),
          child: TabBarView(
            controller: _tabController,
            children: getTabViews(tasks)
          ),
        ),
      ],
    );
  }













  // Get Tabs
  List<Widget> getTabs(List<String> categoryNames, TextStyle tabBarTextStyle) {
    return categoryNames
      .map(
        (category) =>
          Tab(
            child: Text(
              category,
              style: tabBarTextStyle,
            ),
          ),
      )
      .toList();
  }
  // Get Tab Views
  List<Widget> getTabViews(Map<String, List<Task>> tasks) {

    return tasks
      .keys
      .map(
        (category) =>
          TaskTab(
            category: category,
            tasks: tasks[category]!
          )
      )
      .toList();
  }

  void newList(TaskList taskList) {

    // taskList.newList();

  }
}