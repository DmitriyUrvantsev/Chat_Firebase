import 'dart:async';

import 'package:chat_firebase/widgets/app_bar/appbar_subtitle.dart';
import 'package:flutter/material.dart';
import '../../../../../data/models/chat/chat_model.dart';
import '../../../../core/app_export.dart';
import '../../../../data/models/user/user_app.dart';
import '../../../../servises/auth_servises.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_title.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/castom_icon_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'item_chat_widget.dart';
import '../provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final UserAppData user;

  const ChatScreen({required this.user, super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final currentUserId = AuthService().currentUser?.uid ?? 'нулл';
    chatProvider.createChat(currentUserId, widget.user.uid);
    chatProvider.getMessages().listen((_) {
      setState(() {
        chatProvider.setLoading(false);
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    Timer(const Duration(milliseconds: 3000), () {
      chatProvider
          .getMessages(); //!КОСТЫЛЬ(без этого задержка до минуты(чтото перегружает поток))
    });

    return Scaffold(
      appBar: _sectionCustomAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: chatProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : StreamBuilder<List<ChatMessage>>(
                      stream: chatProvider.getMessages(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        var messagesOrign = snapshot.data ?? [];
                        var messages = messagesOrign.reversed.toList();

                        return ListView.builder(
                          reverse: true,
                          controller: chatProvider.scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            var message = messages[index];
                            ChatMessage? previousMessage;
                            if (index < messages.length - 1) {
                              previousMessage = messages[index + 1];
                            }
                            bool isMe = message.senderId ==
                                AuthService().currentUser?.uid;

                            return ItemChatWidget(isMe: isMe, message: message);
                          },
                        );
                      },
                    ),
            ),
            if (chatProvider.photo != null)
              _buildImageDialog(context, chatProvider),
            if (chatProvider.photo == null) _buildSectionTextField(context),
          ],
        ),
      ),
    );
  }

  CustomAppBar _sectionCustomAppBar(BuildContext context) {
    final nik = '${widget.user.name?[0]}${widget.user.surName?[0]}';
    final read = context.read<ChatProvider>();
    return CustomAppBar(
      height: 60,
      leadingWidth: 50.0,
      leading: AppbarLeadingImage(
        onTap: () => read.back(),
        color: PrimaryColors().gray600,
        imagePath: ImageConstant.imgArrowRight,
        margin:
            const EdgeInsets.only(left: 8.0, top: 19.0, bottom: 20.0, right: 10.0),
      ),
      title: Row(
        children: [
          widget.user.currentAvatar != null
              ? Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    widget.user.currentAvatar ?? 'нулл',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      nik,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          const SizedBox(width: 12.0),
          Padding(
            padding: const  EdgeInsets.only(top: 2.0, bottom: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarTitle(
                  text:
                      '${widget.user.name ?? 'нулл'} ${widget.user.surName ?? 'нулл'}',
                ),
                AppbarSubtitle(text: 'В сети'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color(0xFFEDF2F6),
          height: 1.0,
        ),
      ),
    );
  }


///---------
  Widget _buildSectionTextField(BuildContext context) {
    final read = context.read<ChatProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 20.v),
      child: Row(
        children: <Widget>[
          CustomIconButton(
              onTap: () {
               
                read.focusNode.unfocus();
                read.showImageSource(context);
              },
              height: 42.adaptSize,
              width: 42.adaptSize,
              padding: EdgeInsets.all(10.h),
              child: CustomImageView(
                fit: BoxFit.fitHeight,
                imagePath: ImageConstant.skip,
              )),
          SizedBox(width: 8.h),
          Expanded(
            child: CustomFloatingTextField(
              focusNode: read.focusNode,
              controller: read.messageController,
              autofocus: false,
              labelStyle: CustomTextStyles.bodyLargeGray80020,
              labelText: 'Сообщение',
              onSubmitted: (val) => read.sendTextMessage(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              fillColor: appTheme.gray200,
            ),
          ),
          SizedBox(width: 8.h),
          CustomIconButton(
              onTap:() => read.sendTextMessage(),
              height: 42.adaptSize,
              width: 42.adaptSize,
              padding: EdgeInsets.all(10.h),
              child: CustomImageView(
                fit: BoxFit.fitHeight,
                imagePath: ImageConstant.microphon,
              )),
        ],
      ),
    );
  }

  Widget _buildSectionTextFieldImage(BuildContext context) {
    final read = context.read<ChatProvider>();

    return Row(
      children: <Widget>[
        CustomIconButton(
          onTap: () {
            Navigator.of(context).pop();
            read.photo = null;
          },
          height: 42.adaptSize,
          width: 42.adaptSize,
          padding: EdgeInsets.all(5.h),
          child: const Icon(Icons.cancel, color: Colors.grey),
        ),
        SizedBox(width: 8.h),
        Expanded(
          child: CustomFloatingTextField(
            controller: read.messageController,
            autofocus: false,
            labelStyle: CustomTextStyles.bodyLargeGray80020,
            labelText: 'Сообщение',
            onSubmitted: (val) {
              read.sendImageMessage(read.messageController.text);
              read.photo = null;
            },
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            fillColor: appTheme.gray200,
          ),
        ),
        SizedBox(width: 8.h),
        CustomIconButton(
          onTap: () {
          
          

         

            read.sendImageMessage(read.messageController.text);
            read.messageController.clear();
            read.photo =
                null; // Отправка сообщения и очистка выбранного изображения
          },
          height: 42.adaptSize,
          width: 42.adaptSize,
          padding: EdgeInsets.all(5.h),
          child: const Icon(Icons.send, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildImageDialog(BuildContext context, ChatProvider chatProvider) {
    return Dialog(
      insetPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: 380.v,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (chatProvider.photo != null)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // border: Border.all(
                          //   color: Colors.lightBlue.shade100,
                          //   width: 2,
                          // ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            chatProvider.photo!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  _buildSectionTextFieldImage(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
