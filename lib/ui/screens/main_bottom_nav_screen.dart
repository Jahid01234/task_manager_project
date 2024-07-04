import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_project/ui/screens/completed_task_screen.dart';
import 'package:task_manager_project/ui/screens/in_progress_task_screen.dart';
import 'package:task_manager_project/ui/screens/new_task_screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          _selectedIndex = index;
          if(mounted){
            setState(() {});
          }
        },
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon:  Icon(Icons.list_alt), label: 'New Task'),
          BottomNavigationBarItem(icon:  Icon(Icons.access_time_rounded), label: 'Progress'),
          BottomNavigationBarItem(icon:  Icon(Icons.check_circle_outlined), label: ' Completed'),
          BottomNavigationBarItem(icon:  Icon(Icons.cancel_outlined), label: 'Cancelled')
        ],
      ),
    );
  }
}