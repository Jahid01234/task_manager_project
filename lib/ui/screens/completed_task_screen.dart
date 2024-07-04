import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_project/data/models/task_model.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/utilities/urls.dart';
import 'package:task_manager_project/ui/widgets/profile_app_bar.dart';
import 'package:task_manager_project/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_project/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTasksInProgress = false;
  List<TaskModel> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: RefreshIndicator(
        onRefresh: ()async{
          _getCompletedTasks();
        },
        child: Visibility(
          visible: _getCompletedTasksInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: completedTasks[index],
                onUpdateTask: () {  },
              );
            },
          ),
        ),
      ),
    );
  }


  //create Completed Task  api method
  Future<void> _getCompletedTasks() async {
    _getCompletedTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      completedTasks = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get completed task failed! Try again');
      }
    }
    _getCompletedTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
