import 'package:flutter/material.dart';

import '../../data/models/chat/chat_model.dart';

class ItemChatWidget extends StatelessWidget {
  const ItemChatWidget({
    super.key,
    required this.isMe,
    required this.message,
  });

  final bool isMe;
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message.text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// // import 'package:flutter/material.dart';
// // import '../../../core/app_export.dart';
// // import '../../data/models/chat/chat_model.dart';
// // import 'provider/chat_provider.dart';


// // //Виджет Item в чате ListView===================================================
// // class ItemChatWidget extends StatelessWidget {
// //   const ItemChatWidget({
// //     super.key,
// //     required this.message,
// //      required this.isMe,
// //     //!required this.photo,
// //     //required this.chatIndex,
// //    // this.shouldAnimate = false,
// //     //required this.newMassage,
// //     //required this.newMessageSlow,
// //   });

// //   final ChatMessage message;
// //  final bool isMe;
// //   //!final String? photo;
// //  // final int chatIndex;
// //   //final bool shouldAnimate;
// //   //final bool newMassage;
// //  // final bool newMessageSlow;

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.read<ChatProvider>();

// //     return Column(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
            

// //               Expanded(
// //                   child: Align(
// //                 //!=====================================
// //                 alignment: isMe
// //                     ? Alignment.centerRight
// //                     : Alignment.centerLeft,
// //                 //!--------------------------------------
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       width: 201.h,
// //                       //margin: EdgeInsets.only(right: 189.h),
// //                       padding:
// //                           EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.v),
// //                       //!=====================================
// //                       decoration: isMe
// //                           ? AppDecoration.fillGray
// //                           : AppDecoration.fillAmber,
// //                       //!--------------------------------------
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           SizedBox(height: 1.v),
// //                           // isMe
// //                           //     ? 
// //                               Text(message.text,
// //                                   maxLines: 10,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: CustomTextStyles
// //                                       .bodySmallffffb700)
// //                               // : 
// //                               // AnimatedTextKit(
// //                               //     // onFinished: () async {
// //                               //     //   if (message.trim().length > 10) {
// //                               //     //     await Future.delayed(
// //                               //     //      //!   const Duration(milliseconds: 2000));
// //                               //     //    //! provider.isAutoScrolling = false;
// //                               //     //   }
// //                               //     // },
// //                               //     animatedTexts: [
// //                               //       TypewriterAnimatedText(
// //                               //         speed: const Duration(microseconds: 500),
// //                               //         message.trim(),
// //                               //         textStyle: CustomTextStyles
// //                               //             .bodySmallInterErrorContainer
// //                               //             .copyWith(height: 1.23),
// //                               //       ),
// //                               //     ],
// //                               //     totalRepeatCount: 1,
// //                               //   ),
// //                         ],
// //                       ),
// //                     ),

// // //!-------------------- фотка ----------------------

// //                   //  if (chatIndex != 0) ...[
// //                       // Column(
// //                       //   children: [
// //                       //     // const SizedBox(height: 10),
// //                       //     if (photo != null) ...[
// //                       //       const SizedBox(height: 10),
// //                       //       SizedBox(
// //                       //         height: 208.v,
// //                       //         width: 201.h,
// //                       //         child: ClipRRect(
// //                       //           borderRadius: BorderRadius.circular(15.0),
// //                       //           clipBehavior: Clip.hardEdge,
// //                       //           child: FittedBox(
// //                       //             alignment: Alignment.topCenter,
// //                       //             fit: BoxFit.cover,
// //                       //             child: SizedBox(
// //                       //               height: 288.v,
// //                       //               width: 201.h,
// //                       //               child: CustomImageView(
// //                       //                 onTap: () {
// //                       //                   // provider.vipStatus
// //                       //                   //     ? provider.showPhoto()
// //                       //                   //     : provider.unlockPhoto();
// //                       //                 },
// //                       //                 imagePath: photo,
// //                       //               ),
// //                       //             ),
// //                       //           ),
// //                       //         ),
// //                       //       ),
// //                       //     ],
// //                       //   ],
// //                       // ),
// //                     //]
// //                   ],
// //                 ),
// //               )),
// //             ],
// //           ),
// //         ),
// //         // Row(
// //         //   children: [
// //         //     const SizedBox(width: 15),
// //         //     SizedBox(
// //         //       width: 200.h,
// //         //       // height: 35.v,
// //         //       child: (provider.ratingTimeOut == 0 && newMassage)
// //         //           ? ConstrainedBox(
// //         //               constraints: BoxConstraints(
// //         //                 maxHeight: 60.v,
// //         //                 minHeight: 60.v,
// //         //               ),
// //         //               child: const AnimatedRatingStars())
// //         //           : (chatIndex != 0 && newMessageSlow)
// //         //               ? Container(
// //         //                   height: 60.v,
// //         //                   decoration: AppDecoration.outlineErrorContainer
// //         //                       .copyWith(
// //         //                           borderRadius:
// //         //                               BorderRadiusStyle.circleBorder12,
// //         //                           color: Colors.black.withOpacity(0.1)),
// //         //                   // color: Colors.black.withOpacity(0.4),
// //         //                   child: Center(
// //         //                       child: Padding(
// //         //                     padding: const EdgeInsets.only(left: 15.0),
// //         //                     child: Text(
// //         //                         provider.scr21ModelObj
// //         //                             .thankYouList[provider.indexThankYouList],
// //         //                         maxLines: 10,
// //         //                         overflow: TextOverflow.ellipsis,
// //         //                         style: CustomTextStyles
// //         //                             .bodySmallInterThanksContainer
// //         //                             .copyWith(
// //         //                           height: 1.23,
// //         //                         )),
// //         //                   )

// //         //                       // Text(
// //         //                       //   provider.scr21ModelObj
// //         //                       //       .thankYouList[provider.indexThankYouList],
// //         //                       //   style: const TextStyle(color: Colors.white),
// //         //                       // ),
// //         //                       ))
// //         //               : const SizedBox.shrink(),
// //         //     ),
// //         //   ],
// //         // ),
// //       ],
// //     );
// //   }
// // }
