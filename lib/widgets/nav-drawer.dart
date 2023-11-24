import 'package:flutter/material.dart';
// import '../models/users.dart';
// import '../screens/OrderTrackingPage.dart';
// import '../screens/gg_map_screen.dart';
import '../screens/home.dart';
// import '../screens/intro_screen.dart';
import '../screens/photo_list_screen.dart';
// import '../screens/photo_section_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /*
    final Users? args = ModalRoute.of(context)?.settings.arguments as Users?;
    String? userEmail;
    String? userName;
    if(args?.access_token != null) {
      String? userToken = args?.access_token;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(userToken!);
      userEmail = decodedToken['user']['email'];
      userName = decodedToken['user']['username'];
      print(decodedToken);
    }

     */

    return Drawer(
      child: ListView(
        children:  <Widget>[
          /*
          if(args?.access_token != null)...[
          UserAccountsDrawerHeader(
            accountName: Text(userEmail!),
            accountEmail: Text(userName!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ] else...[
            ListTile(
              title: Text('Đăng Nhập'),
              leading: Icon(Icons.lock),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', ModalRoute.withName('/login'));
                //Navigator.pop(context);
              },
            ),
          ],

           */
          ListTile(
            title: const Text("Home Screen"),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));

              // Navigator.pop(context);
              //Navigator.push(
                  //context, MaterialPageRoute( builder: (context) => MyHomePage(title: 'Trang Chủ',))
              //);
            },
          ),
          const Divider(
            height: 0.2,
          ),
          ListTile(
            title: const Text("My Information"),
            leading: const Icon(Icons.book_online),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("My Album"),
            leading: const Icon(Icons.add_business),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: const Text("History"),
              leading: const Icon(Icons.account_tree),

              onTap: () {
                Navigator.pop(context);
              },
            ),
          ListTile(
            title: const Text("Get Photo"),
            leading: const Icon(Icons.account_tree),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute( builder: (context) => IntroScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
