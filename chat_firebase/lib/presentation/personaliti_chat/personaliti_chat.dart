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
  final UserAppData user;

  const ChatScreen({required this.user, Key? key}) : super(key: key);

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
    final currentUserId = AuthService().currentUser?.uid ??
        'нулл'; // Использование реального user ID
    chatProvider.createChat(currentUserId, widget.user.uid);

    print(currentUserId);
    print(widget.user.uid);
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
    final currentUserId = AuthService().currentUser?.uid ??
        'нулл'; // Использование реального user ID

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
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: _sectionCustomAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: chatProvider.getMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var messagesOrign = snapshot.data ?? [];

                  var messages = messagesOrign.reversed.toList();

                  // Прокрутка к последнему добавленному сообщению при первой загрузке
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      bool isMe = message.senderId ==
                          AuthService()
                              .currentUser
                              ?.uid; // Использование реального user ID

                      return ItemChatWidget(isMe: isMe, message: message);
                    },
                  );
                },
              ),
            ),
            _buildSectionTextField(),
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
            EdgeInsets.only(left: 8.0, top: 19.0, bottom: 20.0, right: 10.0),
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
          SizedBox(width: 12.0),
          Padding(
            padding: EdgeInsets.only(top: 2.0, bottom: 9.0),
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
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          color: Color(0xFFEDF2F6),
          height: 1.0,
        ),
      ),
    );
  }

  Padding _buildSectionTextField() {
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}
