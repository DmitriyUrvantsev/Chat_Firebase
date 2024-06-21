import 'package:chat_firebase/core/utils/size_utils.dart';
import 'package:chat_firebase/widgets/app_bar/appbar_subtitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/chat/chat_model.dart';
import '../../core/app_export.dart';
import '../../data/models/user/user_app.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_field.dart';
import 'item_chat_widget.dart';
import 'provider/chat_provider.dart';
import '../../../servises/auth_servises.dart';

class ChatScreen extends StatefulWidget {
  // final String receiverId;
  // final String receiverName;
  final UserAppData user;

  const ChatScreen({required this.user, super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final currentUserId =
        AuthService().currentUser!.uid; // Использование реального user ID
    chatProvider.createChat(currentUserId, widget.user.uid);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final currentUserId =
        AuthService().currentUser!.uid; // Использование реального user ID

    ChatMessage message = ChatMessage(
      senderId: currentUserId,
      text: _messageController.text,
      timestamp: Timestamp.now(),
    );

    await chatProvider.sendMessage(message);
    _messageController.clear();

    // Прокрутка к последнему добавленному сообщению
    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: _sectionCastomAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: chatProvider.getMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var messages = snapshot.data ?? [];

                  // Прокрутка к последнему добавленному сообщению при первой загрузке
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return Column(
                    children: [
                      
                      ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          bool isMe = message.senderId ==
                              AuthService().currentUser!.uid; // Использование реального user ID
                      
                          return ItemChatWidget(isMe: isMe, message: message);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            _buildSectonTextField(),
          ],
        ),
      ),
    );
  }

//   CustomAppBar _buildCustomAppBar(BuildContext context) {
//     final read = context.read<ChatProvider>();
//     return CustomAppBar(
//       // ваш код для AppBar
//     );
//   }

//   Padding _buildSectionTextField() {
//     return Padding(
//       // ваш код для TextField
//     );
//   }
// }
//
//
  ///------------------- AppBar ---------------------------------------
  CustomAppBar _sectionCastomAppBar(BuildContext context) {
    final read = context.read<ChatProvider>();
    return CustomAppBar(
      height: 60,
      leadingWidth: 50.h,
      leading: AppbarLeadingImage(
          onTap: () => read.back(),
          color: PrimaryColors().gray600,
          imagePath: ImageConstant.imgArrowRight,
          margin:
              EdgeInsets.only(left: 8.h, top: 19.v, bottom: 20.v, right: 10.h)),
      title: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              widget.user.currentAvatar!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.h),
          Padding(
            padding: EdgeInsets.only(top: 2.v, bottom: 9.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarTitle(
                    text:
                        '${widget.user.name ?? 'нулл'} ${widget.user.surName ?? 'нулл'}'),
                AppbarSubtitle(text: 'В сети'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color(0xFFEDF2F6),
          height: 1.0,
        ),
      ),
    );
  }

//
//
  ///------------------- AppBar ---------------------------------------
  Padding _buildSectonTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomFloatingTextField(
        controller: _messageController,
        hintText: 'Enter a message...',
        prefix: Icon(Icons.message, color: Colors.grey),
        suffix: IconButton(
          icon: Icon(Icons.send, color: Colors.blue),
          onPressed: _sendMessage,
        ),
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
