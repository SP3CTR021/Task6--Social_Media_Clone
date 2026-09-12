import 'friend.dart';
import 'userpost.dart';
import 'account.dart';

class Userdata {
  List<Userpost> userList = [
    Userpost(
      userimg: 'assets/p1.jpeg', // Make sure you have these assets
      username: 'Santy Awanon',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the School!',
      postimg: 'assets/upod2.jpeg',
      numcomments: 24,
      numshare: '5',
      isliked: false,
    ),
    Userpost(
      userimg: 'assets/p5.jpeg',
      username: 'Benhard Awanon',
      time: '3 hrs ago',
      postcontent: 'Feeling the vibe!.',
      postimg: 'assets/upod3.jpeg',
      numcomments: 18,
      numshare: '3',
      isliked: true,
    ),
    Userpost(
      userimg: 'assets/p4.jpeg',
      username: 'Nukie Blaze',
      time: '5 hrs ago',
      postcontent: 'New Cafe spot in Davao! 🏃‍♂️',
      postimg: 'assets/upod8.jpeg',
      numcomments: 10,
      numshare: '7',
      isliked: false,
    ),
    Userpost(
      userimg: 'assets/p6.jpeg',
      username: 'John Awanon',
      time: '5 hrs ago',
      postcontent: 'Just finished Insidious Out in the Further! 🏃‍♂️',
      postimg: 'assets/upod7.jpeg',
      numcomments: 10,
      numshare: '7',
      isliked: false,
    ),


     Userpost(
      userimg: 'assets/p3.jpeg',
      username: 'John Awanon',
      time: '5 hrs ago',
      postcontent: 'Had a great day at the beach',
      postimg: 'assets/upod11.jpeg',
      numcomments: 10,
      numshare: '7',
      isliked: false,
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/p1.jpeg', name: 'Nukieblaze'),
    Friend(img: 'assets/p4.jpeg', name: 'Awanon'),
    Friend(img: 'assets/p3.jpeg', name: 'Jojo'),
    Friend(img: 'assets/p2.jpeg', name: 'Benhard'),
    Friend(img: 'assets/p6.jpeg', name: 'Santy'),
    Friend(img: 'assets/p5.jpeg', name: 'John'),
  ];

  Account myUserAccount = Account(
    name: 'Gerald Wynn R. Belena',
    email: 'spectro@gmail.com',
    img: 'assets/p0.jpeg',
    numFollowers: '350k',
    numPosts: '20',
    numFollowing: '100',
    numFriends: '6',
  );
}
