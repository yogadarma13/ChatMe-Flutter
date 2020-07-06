import 'package:flutter/material.dart';

import '../../models/friend.dart';
import '../../screens/all_photos_screen.dart';

class RoomChatAppbar extends StatelessWidget implements PreferredSizeWidget {
    final Friend dataFriend;
    final void Function(String routeName, BuildContext context, Friend friend) navigateMenuRoomChat;

  RoomChatAppbar(this.dataFriend, this.navigateMenuRoomChat);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 6),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 6,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: dataFriend.imageUrl.isEmpty
                    ? AssetImage('assets/images/default_avatar.png')
                    : NetworkImage(dataFriend.imageUrl),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dataFriend.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AllPhotosScreen.routeName,
                    child: Text('All Photos'),
                  ),
                ],
                onSelected: (value) {
                  navigateMenuRoomChat(value, context, dataFriend);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
