import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import 'profileview.dart'; 

class Postlist extends StatefulWidget {
  final Userdata userdata;
  const Postlist({super.key, required this.userdata});

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {

  Widget showPost(Userpost userPost) => Column(
    children: [
      const Divider(),
      ListTile(
         leading: CircleAvatar(backgroundImage: AssetImage(userPost.userimg)),
         title: Text(userPost.username, style: const TextStyle(fontWeight: FontWeight.bold)),
         subtitle: Row(
           children: [
             Text(userPost.time),
             const Text(' . '),
             const Icon(Icons.group, size: 15, color: Colors.grey),
           ]
         ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(userPost.postcontent)
        ),
      ),
      const SizedBox(height: 10),
      Image.asset(userPost.postimg, fit: BoxFit.cover),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('👍 ${userPost.isliked ? 'You and others' : 'Others'}'),
            Text('${userPost.numcomments} Comments  ${userPost.numshare} Shares'),
          ],
        ),
      ),
      const Divider(),
      Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           TextButton.icon(
             style: TextButton.styleFrom(foregroundColor: userPost.isliked ? Colors.blue : Colors.grey),
             onPressed: () { setState(() { userPost.isliked = !userPost.isliked; }); },
             icon: const Icon(Icons.thumb_up, size: 20),
             label: const Text('Like')
           ),
           TextButton.icon(
             style: TextButton.styleFrom(foregroundColor: Colors.grey),
             onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileView(userPost: userPost, userData: widget.userdata))
                );
             },
             icon: const Icon(Icons.chat_bubble, size: 20),
             label: const Text('Comment')
           ),
           TextButton.icon(
             style: TextButton.styleFrom(foregroundColor: Colors.grey),
             onPressed: () {},
             icon: const Icon(Icons.share, size: 20),
             label: const Text('Share')
           ),
         ],
      ),
      SizedBox(height: 10, child: Container(color: Colors.grey)),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Scroll fix applied here
      children: widget.userdata.userList.map((userPost) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileView(userPost: userPost, userData: widget.userdata)
              )
            );
          },
          child: showPost(userPost),
        );
      }).toList(),
    );
  }
}