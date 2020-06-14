import 'package:flutter/material.dart';

import '../rounded_button.dart';

class PopupActionFriendRequest extends StatelessWidget {
  final String username;
  final String imageUrl;
  final void Function() acceptFriend;
  final void Function() declineFriend;
  // final bool isLoading;

  PopupActionFriendRequest({
    @required this.username,
    @required this.imageUrl,
    @required this.acceptFriend,
    @required this.declineFriend,
    // @required this.isLoading
  });

  void _cencelDialod(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => _cencelDialod(context),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue[50],
                ),
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 45),
            child: CircleAvatar(
              maxRadius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 16, bottom: 45),
            child: Text(username),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RoundedButton(
                  'Decline',
                  Colors.red,
                  declineFriend,
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: RoundedButton(
                  'Accept',
                  Colors.green,
                  acceptFriend,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
