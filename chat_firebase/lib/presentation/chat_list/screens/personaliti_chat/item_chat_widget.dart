import 'package:chat_firebase/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_export.dart';
import '../../../../data/models/chat/chat_model.dart';
import '../../../../servises/auth_servises.dart';

class ItemChatWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const ItemChatWidget({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final bool isMe = message.senderId == AuthService().currentUser?.uid;

    return Column(
      children: [
        if (message.timeChangeDate != null)
          _buildDateWidget(message.timeChangeDate!.toDate()),
        Padding(
          // Добавляем отступы для ListTile
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          child: ListTile(
            contentPadding:
                EdgeInsets.zero, // Убираем внутренние отступы ListTile
            title: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 282.h),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isMe ? appTheme.green : Colors.grey,
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(23),
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                          )
                        : const BorderRadius.only(
                            // bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                            bottomRight: Radius.circular(23),
                          ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Выровнять содержимое по левому краю
                    children: [
                      if (message.imageUrl != null)
                        Container(
                          //height: 76.adaptSize,
                          width: 282.h,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                          
                            borderRadius: isMe
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(10),
                                  )
                                : const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                          ),
                          child: Image.network(
                            message.imageUrl ?? '',
                            width: 282,
                            // height: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (message.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign
                                .left, // Выровнять текст по левому краю
                            message.text,
                            style: TextStyle(
                                color: appTheme.gray800, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateWidget(DateTime dateTime) {
    final now = DateTime.now();
    final isNow = dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day &&
        dateTime.hour == now.hour &&
        dateTime.minute == now.minute;

    var color = const Color.fromRGBO(140, 168, 191, 1);
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
          horizontal: 6.h), // Устанавливаем отступы от краев экрана
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.v),
              child: Divider(color: color),
            ),
          ),
          SizedBox(width: 10.h),
          Text(
            isNow
                ? 'Сейчас'
                : DateFormat('dd MMMM yyyy, HH:mm').format(dateTime),
            style: TextStyle(color: color),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.v),
              child: Divider(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
