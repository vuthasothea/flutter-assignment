import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:final_project_with_firebase/presentation/blocs/app/app_bloc.dart';
import 'package:final_project_with_firebase/presentation/blocs/news/news_bloc.dart';
import 'package:final_project_with_firebase/presentation/screens/login_screen.dart';
import 'package:final_project_with_firebase/presentation/widgets/news_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    var appState = BlocProvider.of<AppBloc>(context).state;

    if (appState is AppLoadedState) {
      return BlocProvider(
        create: (context) => NewsBloc()..add(GetNewsEvent(newsCategory: "home")),
        child: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("News App"),
              ),
              body: ((){
                if(state is NewsLoadedState) {
                  List<NewsModel> newsList = state.newsList;

                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return NewListItem(newsModel: newsList[index]);
                    },
                  );
                }

                return Center(child: CircularProgressIndicator());
              }()),
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      accountName: Text(user.displayName!),
                      accountEmail: Text(user.email!),
                      currentAccountPicture: CircleAvatar(
                        child: Text(
                          user.displayName![0].toUpperCase(),
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Icon(Icons.newspaper),
                          title: Text("Latest News"),
                          onTap: () {
                            BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(newsCategory: "home"));
                            Navigator.pop(context);
                          }
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.paid_outlined),
                          title: Text("Business news"),
                          onTap: () {
                            BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(newsCategory: "business"));
                            Navigator.pop(context);
                          }
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.sports_soccer),
                          title: Text("Sport news"),
                          onTap: () {
                            BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(newsCategory: "sport"));
                            Navigator.pop(context);
                          }
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.palette_outlined),
                          title: Text("Entertainment news"),
                          onTap: () {
                            BlocProvider.of<NewsBloc>(context).add(GetNewsEvent(newsCategory: "entertainment"));
                            Navigator.pop(context);
                          }
                        ),
                        Divider(),
                        SwitchListTile(
                          value: appState.appModel.isNightMode,
                          secondary: Icon(Icons.nightlight_outlined),
                          title: Text("Night Mode"),
                          onChanged: (value) {
                            BlocProvider.of<AppBloc>(context).add(ChangeThemeAppEvent(isNightMode: !appState.appModel.isNightMode));
                          },
                        ),
                        Divider(),
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
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
    return Scaffold();
  }
}
