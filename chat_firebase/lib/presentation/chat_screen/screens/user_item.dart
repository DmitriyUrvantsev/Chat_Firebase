//
//
//

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/models/user/user_app.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserAppData>>(context);
    final List<Color> avatarColors = [
      Colors.red,
      // Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange
    ];
    final Random random = Random();
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final nik = '${user.name?[0]}${user.surName?[0]}';
        final Color randomColor =
            avatarColors[random.nextInt(avatarColors.length)];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: user.currentAvatar != null
                ? Container(
                    height: 50.adaptSize,
                    width: 50.adaptSize,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      user.currentAvatar!,
                      //!currentAvatar!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 50.adaptSize,
                    width: 50.adaptSize,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: randomColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      nik,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),
            title: Text('${user.name} ${user.surName}'),
          ),
        );
      },
    );
  }
}
