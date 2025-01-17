import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_project/data/models/task_model.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/utilities/urls.dart';
import 'package:task_manager_project/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_project/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_project/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> progressTasks = [];

  @override
  void initState() {
    super.initState();
    _getProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: RefreshIndicator(
        onRefresh: ()async{
          _getProgressTasks();
        },
        child: Visibility(
          visible: _getProgressTasksInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: progressTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: progressTasks[index],
                onUpdateTask: () {  },
              );
            },
          ),
        ),
      ),
    );
  }

  //create Progress Task  api method
  Future<void> _getProgressTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      progressTasks = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get progress task failed! Try again');
      }
    }
    _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
