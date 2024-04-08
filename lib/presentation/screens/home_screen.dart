import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:final_project_with_firebase/presentation/blocs/app/app_bloc.dart';
import 'package:final_project_with_firebase/presentation/blocs/news/news_bloc.dart';
import 'package:final_project_with_firebase/presentation/screens/login_screen.dart';
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
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            
                          },
                          child: Padding(
                            padding: EdgeInsets.all(AppVariable.STANDARD_PADDING/2),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Image(
                                    image: NetworkImage(newsList[index].urlImage ?? ""),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image(
                                        image: NetworkImage("https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg"),
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: AppVariable.STANDARD_PADDING),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(newsList[index].title ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month, size: 18, color: Colors.grey[600]),
                                          SizedBox(width: 4),
                                          Text(newsList[index].datetime ?? "", style: TextStyle(color: Colors.grey[600])),
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
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
                        child: Text(user.displayName![0],
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
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
                            BlocProvider.of<AppBloc>(context).add(
                                ChangeThemeAppEvent(
                                    isNightMode:
                                        !appState.appModel.isNightMode));
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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
