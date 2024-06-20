// import 'package:flutter/material.dart';
// import 'package:chat_firebase/core/app_export.dart';
// import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';

// // ignore: must_be_immutable
// class CustomBottomBar extends StatefulWidget {
//   CustomBottomBar({super.key, this.onChanged});

//   Function(BottomBarEnum)? onChanged;

//   @override
//   CustomBottomBarState createState() => CustomBottomBarState();
// }

// class CustomBottomBarState extends State<CustomBottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     final read = context.read<MainScreenProvider>();
//     int selectedIndex = read.currentMainScreenIndex;
//     return Container(
//       height: 75.v,
//       decoration: BoxDecoration(
//         color: appTheme.gray300,
//         boxShadow: [
//           BoxShadow(
//             color: appTheme.black9004c,
//             spreadRadius: 1.h,
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.transparent,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedFontSize: 0,
//         elevation: 0,
//         currentIndex: selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         items: List.generate(read.bottomMenuList.length, (index) {
//           return BottomNavigationBarItem(
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomImageView(
//                   imagePath: read.bottomMenuList[index].icon,
//                   height: 21.adaptSize,
//                   width: 21.adaptSize,
//                   color: appTheme.gray600,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 2.v),
//                   child: Text(
//                     read.bottomMenuList[index].title ?? "",
//                     style: theme.textTheme.labelMedium!.copyWith(
//                       color: appTheme.gray800,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             activeIcon: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomImageView(
//                   imagePath: read.bottomMenuList[index].activeIcon,
//                   height: 20.adaptSize,
//                   width: 20.adaptSize,
//                   color: appTheme.lightBlueA700,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 1.v),
//                   child: Text(
//                     read.bottomMenuList[index].title ?? "",
//                     style: CustomTextStyles.labelMediumLightblueA700.copyWith(
//                       color: appTheme.lightBlueA700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             label: '',
//           );
//         }),
//         onTap: (index) {
//           selectedIndex = index;
//           widget.onChanged?.call(read.bottomMenuList[index].type);
//           read.toglleIndex(index);
//           setState(() {});
//         },
//       ),
//     );
//   }
// }

// enum BottomBarEnum {
//   tf,
// }

// class BottomMenuModel {
//   BottomMenuModel({
//     required this.icon,
//     required this.activeIcon,
//     this.title,
//     required this.type,
//   });

//   String icon;

//   String activeIcon;

//   String? title;

//   BottomBarEnum type;
// }

// class DefaultWidget extends StatelessWidget {
//   const DefaultWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(10),
//       child: const Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Please replace the respective Widget here',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
