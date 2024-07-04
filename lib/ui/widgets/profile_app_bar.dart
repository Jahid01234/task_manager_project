import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import 'package:task_manager_project/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/update_profile_screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';

AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    leading: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.memory(
              base64Decode(AuthController.userData?.photo ?? ''),
            ),
          ),
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (fromUpdateProfile) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfileScreen(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AuthController.userData?.fullName ?? '',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            AuthController.userData?.email ?? '',
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          await AuthController.clearAllData();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false,
          );
        },
        icon: const Icon(Icons.logout,color: Colors.white, ),
      )
    ],
  );
}





















// import 'package:flutter/material.dart';
// import 'package:task_manager_project/ui/controllers/auth_controller.dart';
// import 'package:task_manager_project/ui/screens/auth/sign_in_screen.dart';
// import 'package:task_manager_project/ui/screens/update_profile_screen.dart';
// import 'package:task_manager_project/ui/utility/app_colors.dart';
// import 'package:task_manager_project/ui/widgets/network_cached_image.dart';
//
// AppBar profileAppBar(context, [bool fromUpdateProfile = false]) {
//   return AppBar(
//     backgroundColor: AppColors.themeColor,
//     leading: GestureDetector(
//       onTap: () {
//         if (fromUpdateProfile) {
//           return;
//         }
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UpdateProfileScreen(),
//           ),
//         );
//       },
//       child: const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: CircleAvatar(
//           child: NetworkCachedImage(
//             url: '',
//           ),
//         ),
//       ),
//     ),
//     title: GestureDetector(
//       onTap: () {
//         if (fromUpdateProfile) {
//           return;
//         }
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const UpdateProfileScreen(),
//           ),
//         );
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             AuthController.userData?.fullName ?? '',
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           Text(
//             AuthController.userData?.email ?? '',
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       IconButton(
//         onPressed: () async{
//           await AuthController.clearAllData();
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SignInScreen(),
//               ),
//               (route) => false);
//         },
//         icon: const Icon(Icons.logout, color: Colors.white, size: 20),
//       ),
//     ],
//   );
// }
