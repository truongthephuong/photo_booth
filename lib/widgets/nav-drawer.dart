import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            title: Text("Trang chủ"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));

              // Navigator.pop(context);
              //Navigator.push(
                  //context, MaterialPageRoute( builder: (context) => MyHomePage(title: 'Trang Chủ',))
              //);
            },
          ),
          Divider(
            height: 0.2,
          ),
          ListTile(
            title: Text("Sổ Tay Nhà Nông"),
            leading: Icon(Icons.book_online),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Thị Trường Nông Sản"),
            leading: Icon(Icons.add_business),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: Text("Trang Trại"),
              leading: Icon(Icons.account_tree),

              onTap: () {
                Navigator.pop(context);
              },
            ),
          ListTile(
            title: Text("Bản đồ"),
            leading: Icon(Icons.map),

            onTap: () {
              Navigator.pop(context);
              //Navigator.push(
                //context,
                //MaterialPageRoute(builder: (context) => GGMapScreen()),
                //MaterialPageRoute( builder: (context) => OrderTrackingPage()),
              //);
            },
          ),
          ListTile(
            title: Text("Chỉnh sửa ảnh"),
            leading: Icon(Icons.account_circle_outlined),

            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute( builder: (context) => PhotoListScreen()),
              );
            },
          ),
          /*
          if(args?.access_token != null)...[
            ListTile(
              title: Text('Thoát'),
              leading: Icon(Icons.logout_rounded),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('access_token');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', ModalRoute.withName('/home'));
                //Navigator.pop(context);
              },
            ),
          ],

           */
          ListTile(
            title: Text("Video Giới Thiệu"),
            leading: Icon(Icons.add_a_photo_sharp),
            onTap: () {
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));

              // Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute( builder: (context) => IntroScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}
