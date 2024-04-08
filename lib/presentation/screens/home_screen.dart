import 'package:final_project_with_firebase/presentation/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text(user.displayName!),
              accountEmail: Text(user.email!),
              currentAccountPicture: CircleAvatar(
                child: Text(user.displayName![0], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),              
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text("Home"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.paid_outlined),
                  title: Text("Business news"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text("Sport news"),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.palette_outlined),
                  title: Text("Enterainment news"),
                ),
                Divider(),
              ],
            ),
            ListTile(
              iconColor: Colors.red[900],
              textColor: Colors.red[900],
              leading: Icon(Icons.logout_rounded),
              title: Text("Logout"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }

}