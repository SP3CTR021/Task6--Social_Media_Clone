import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/friend.dart';

class Friendlist extends StatelessWidget {
  const Friendlist({super.key, required this.userdata});
  final Userdata userdata;

  final followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friend(Friend friend) => Card(
    child: Column(
      children: [
        Expanded(child: Image.asset(friend.img, fit: BoxFit.cover)),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(friend.name)),
      ],
    ),
  );

  Widget friendListGrid() => LayoutBuilder(
    builder: (context, constraints) {
      const spacing = 10.0;
      final itemWidth = (constraints.maxWidth - (spacing * 2)) / 3;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: userdata.friendList
            .map((item) => SizedBox(width: itemWidth, height: 140, child: friend(item)))
            .toList(),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Friends\n${userdata.myUserAccount.numFriends} Friends', style: followTxtStyle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
          child: friendListGrid(),
        ),
        SizedBox(height: 10, child: Container(color: Colors.grey)),
      ],
    );
  }
}
