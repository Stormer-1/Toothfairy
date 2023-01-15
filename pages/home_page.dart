import 'dart:convert';
import "package:flutter/material.dart";
import 'package:google_nav_bar/google_nav_bar.dart';
import "package:http/http.dart" as http;
import 'package:toothfairy/pages/users.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>> usersFuture = getUsers();

  static Future<List<User>> getUsers() async {
    const url =
        "https://raw.githubusercontent.com/JohannesMilke/futurebuilder_example/master/assets/users.json";
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,

        // body with API

        body: Card(
          child: FutureBuilder<List<User>>(
            future: usersFuture,
            builder: (context, snapshot) {
              // Is it done loading? Then show team data.
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.deepPurple.shade300,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return buildUsers(users);
              } else {
                return const Text("No user data");
              }
            },
          ),
        ),

        // Bottom navigation bar using google-nav

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20,
          ),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Colors.deepPurple[300],
            activeColor: Colors.white,
            tabBackgroundColor: Colors.deepPurple.shade300,
            gap: 8,
            onTabChange: (index) {
              print(index);
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.feed,
                text: "News",
              ),
              GButton(
                icon: Icons.person,
                text: "People",
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.favorite,
                text: "Favorite",
              ),
              GButton(
                icon: Icons.map_outlined,
                text: "Places",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(user.urlAvatar),
            ),
            title: Text(user.username),
            subtitle: Text(user.email),
          ),
        );
      });
}
