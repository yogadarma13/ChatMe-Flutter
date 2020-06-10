import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../widgets/chat/chat_list.dart';
import './room_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chat'),
      //   actions: <Widget>[
      //     DropdownButton(
      //       // Underline diisi container memiliki tujuan agar menghilangkan garis abu yang ada pada menu item jika diperhatikan
      //       underline: Container(),
      //       icon: Icon(
      //         Icons.more_vert,
      //         color: Theme.of(context).primaryIconTheme.color,
      //       ),
      //       items: [
      //         DropdownMenuItem(
      //           child: Container(
      //             child: Row(
      //               children: <Widget>[
      //                 Icon(Icons.exit_to_app),
      //                 SizedBox(width: 8),
      //                 Text('Logout')
      //               ],
      //             ),
      //           ),
      //           value: 'logout',
      //         ),
      //       ],
      //       // itemIdentifier ini akan berisikan value dropdownmenuitem yg dipilih
      //       onChanged: (itemIdentifier) {
      //         if (itemIdentifier == 'logout') {
      //           FirebaseAuth.instance.signOut();
      //         }
      //       },
      //     )
      //   ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue[50],
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'New',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                // filled itu seperti memberikan background color
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                // Ini bisa membuat efek bounce diatasnya menjadi hilang jadi hanya dibawah
                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, _) => ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RoomChatScreen.routeName);
                      },
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(
                            'https://www.biography.com/.image/t_share/MTM2OTI2NTY2Mjg5NTE2MTI5/justin_bieber_2015_photo_courtesy_dfree_shutterstock_348418241_croppedjpg.jpg'),
                      ),
                      title: Text('Yoga Darma'),
                      subtitle: Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      trailing: Text(
                        '12 Jan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    )
                // ChatList(
                //   userName: 'Yoga Darma',
                //   message: 'Hello',
                //   image:
                //       'https://www.biography.com/.image/t_share/MTM2OTI2NTY2Mjg5NTE2MTI5/justin_bieber_2015_photo_courtesy_dfree_shutterstock_348418241_croppedjpg.jpg',
                //   time: '12 Jan',
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
