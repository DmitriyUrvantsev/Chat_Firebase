import 'package:flutter/material.dart';
import 'package:chat_firebase/core/app_export.dart';
import 'package:chat_firebase/data/models/user_avatar_file/user_avatar_file.dart';
import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';

class AvatarIconWidget extends StatefulWidget {
  const AvatarIconWidget({
    super.key,
  });

  @override
  State<AvatarIconWidget> createState() => _AvatarIconWidgetState();
}

class _AvatarIconWidgetState extends State<AvatarIconWidget> {
  late Future<List<FirebaseStorageFile>> futureFiles;

  //! @override
  //! void initState() {
  //!   super.initState();
  //!   futureFiles = FirebaseApi.listAll('files/');
  //! }

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    final watch = context.watch<MainScreenProvider>();
    return Stack(
      children: [
        if (read.photo != null)
          Container(
            height: 76.adaptSize,
            width: 76.adaptSize,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.file(
              watch.photo!,
              //!currentAvatar!,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),


        // FutureBuilder<List<FirebaseStorageFile>>(
        //     future: futureFiles,
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //           return const Center(
        //               child: CircularProgressIndicator(
        //             color: Colors.transparent,
        //           ));
        //         default:
        //           if (snapshot.hasError) {
        //             return const Center(child: Text('Some error occurred!'));
        //           } else if (snapshot.hasData) {
        //             if (snapshot.data!.isNotEmpty) {
        //               final files = snapshot.data!;
        //               final file = files.first;

        //               return Container(
        //                 height: 76.adaptSize,
        //                 width: 76.adaptSize,
        //                 clipBehavior: Clip.hardEdge,
        //                 decoration: const BoxDecoration(
        //                   shape: BoxShape.circle,
        //                 ),
        //                 child: Image.network(
        //                   watch.currentAvatar ?? file.url,
        //                   width: 76,
        //                   height: 76,
        //                   fit: BoxFit.cover,
        //                 ),
        //               );
        //             }
        //           } else {
        //             return const SizedBox.shrink();
        //           }
        //       }
        //       return const SizedBox.shrink();
        //     }),




      ],
    );
  }
}
