import 'package:flutter/material.dart';
import '../model/userpost.dart';
import '../model/userdata.dart';
import '../model/usercomment.dart';

class ProfileView extends StatefulWidget {
  final Userpost userPost;
  final Userdata userData;

  const ProfileView({super.key, required this.userPost, required this.userData});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  Widget userline(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userPost.userimg),
          radius: 20,
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userPost.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(userPost.time),
                const Text(' . '),
                const Icon(Icons.group, size: 15, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget postimage(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userPost.postcontent),
        const SizedBox(height: 15),
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(userPost.postimg),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );

  Widget buttons(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: userPost.isliked ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                 setState(() { userPost.isliked = !userPost.isliked; });
              },
              icon: const Icon(Icons.thumb_up, size: 20),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () => _commentFocusNode.requestFocus(),
              icon: const Icon(Icons.chat_bubble, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sharing is not available yet.')),
                );
              },
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey),
    ],
  );

  Widget commenters() => const Padding(
    padding: EdgeInsets.all(10.0),
    child: Text('All Comments', style: TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget userpostdetails(Usercomment userComment) => ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage(userComment.commenterImg),
    ),
    title: Text(userComment.commenterName, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userComment.commentContent),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(userComment.commentTime, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 10),
            const Text('Like', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            const Text('Reply', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    ),
  );

  // LOGIC FOR THE NEW COMMENTING FEATURE
  void _addComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      setState(() {
        widget.userPost.comments.add(
          Usercomment(
            commenterImg: widget.userData.myUserAccount.img,
            commenterName: widget.userData.myUserAccount.name,
            commentTime: 'Just now',
            commentContent: comment,
          )
        );
        widget.userPost.numcomments += 1;
        _commentController.clear();
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                userline(widget.userPost),
                postimage(widget.userPost),
                buttons(widget.userPost),
                commenters(),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Scroll fix applied here
                  children: widget.userPost.comments
                      .map((userComment) => userpostdetails(userComment))
                      .toList(),
                ),
              ],
            ),
          ),
          // COMMENT INPUT FIELD
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
