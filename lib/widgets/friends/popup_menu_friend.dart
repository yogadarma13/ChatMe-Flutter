import 'package:flutter/material.dart';
import '../../screens/add_friend_screen.dart';
import '../../screens/friend_request_screen.dart';

// class FriendMenu {
//   final Text title;
//   final String navigateRoute;
//   final String assetImage;

//   const FriendMenu({
//     this.title,
//     this.navigateRoute,
//     this.assetImage,
//   });
// }

// const List<FriendMenu> friendMenus = [
//   const FriendMenu(
//     title: Text('Search friend'),
//     navigateRoute: AddFriendScreen.routeName,
//     assetImage: 'assets/images/search_friend.png',
//   ),
//   const FriendMenu(
//     title: Text('Friend request'),
//     navigateRoute: FriendRequestScreen.routeName,
//     assetImage: 'assets/images/friend_req.png',
//   )
// ];

class PopupMenuFriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AddFriendScreen.routeName,
          child: Text('Search friend'),
        ),
        PopupMenuItem(
          value: FriendRequestScreen.routeName,
          child: Text('Friend request'),
        ),
      ],
      // itemBuilder: (context) => friendMenus
      //     .map(
      //       (friendMenu) => PopupMenuItem(
      //         value: friendMenu.navigateRoute,
      //         child: ListTile(
      //           leading: Image.asset(friendMenu.assetImage),
      //           title: friendMenu.title,
      //         ),
      //       ),
      //     )
      //     .toList(),
      onSelected: (value) {
        Navigator.pushNamed(context, value);
      },
    );
  }
}
