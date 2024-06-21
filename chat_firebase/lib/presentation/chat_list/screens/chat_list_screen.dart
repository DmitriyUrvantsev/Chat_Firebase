import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_export.dart';
import '../../../data/models/user/user_app.dart';
import '../../../servises/auth_servises.dart';
import '../../../servises/data_base.dart';
import '../../../widgets/custom_text_field.dart';
import '../../auth_screen/provider/maim_screen_provider.dart';
import 'user_item.dart';

class ChatScreenWidget extends StatelessWidget {
  const ChatScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    final read = context.read<MainScreenProvider>();

    return StreamProvider<List<UserAppData>>.value(
      value: DatabaseService(uid: read.uid ?? '').allUsers,
      initialData: [],
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          title: const Text(
            'Чаты',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Color(0xFF1FDB5F),
              ),
              onPressed: () async {
                await auth.signOut();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomFloatingTextField(
                autofocus: false,
                labelStyle: CustomTextStyles.bodyLargeGray80020,
                labelText: 'Поиск',
                prefix: const Icon(Icons.search, color: Color(0xFF5E7A90)),
                onChanged: (value) {
                  // Implement search functionality here
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
            Expanded(child: UserItem()),
          ],
        ),
      ),
    );
  }
}
