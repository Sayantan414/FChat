import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_chat/main.dart';
import 'package:f_chat/models/chat_user.dart';
import 'package:f_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});

  final ChatUser user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .02, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // color: Colors.blue.shade50,
      // elevation: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: ListTile(
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.circular(mq.height * .3),
          //   child: CachedNetworkImage(
          //     width: mq.height * .040,
          //     height: mq.height * .040,
          //     imageUrl: widget.user.image,
          //     // placeholder: (context, url) => const CircularProgressIndicator(),
          //     errorWidget: (context, url, error) =>
          //         const CircleAvatar(child: Icon(CupertinoIcons.person)),
          //   ),
          // ),
          leading: CircleAvatar(
            backgroundImage: widget.user.image != ''
                ? NetworkImage(widget.user.image)
                : null,
            child: widget.user.image == '' ? const Icon(Icons.person) : null,
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color: Colors.greenAccent.shade400,
                borderRadius: BorderRadius.circular(10)),
          ),

          // trailing: const Text(
          //   '12:00 AM',
          //   style: TextStyle(color: Colors.black54),
          // ),
        ),
      ),
    );
  }
}
