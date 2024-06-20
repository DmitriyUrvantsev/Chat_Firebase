// import 'package:flutter/material.dart';
// import 'package:chat_firebase/core/app_export.dart';
// import 'package:chat_firebase/data/models/user/user_app.dart';
// import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
// import 'package:chat_firebase/presentation/auth_screen/account_screens/account_screen.dart';
// import 'package:chat_firebase/servises/data_base.dart';

// class K2MainScreenWidget extends StatefulWidget {
//   final String uid;

//   const K2MainScreenWidget({super.key, 
//   required this.uid
//   });

//   @override
//   State<K2MainScreenWidget> createState() => _K2MainScreenWidgetState();
// }

// class _K2MainScreenWidgetState extends State<K2MainScreenWidget> {
//   int index = 0;

//   @override
//   Widget build(BuildContext context) {
//     UserApp user = Provider.of<UserApp>(context);
//     final read = context.read<MainScreenProvider>();

//     read.uid = user.uid;
 
//     index = context.watch<MainScreenProvider>().currentMainScreenIndex;

//     return StreamBuilder<UserAppData>(
//         stream: DatabaseService(uid: user.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
         
//             read.snapShot = snapshot;

//             return Scaffold(
//               backgroundColor: appTheme.gray100,
//               body: SizedBox(
//                   width: SizeUtils.width, child: const K3AccounrScreenWidget()),
             
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }


// }
