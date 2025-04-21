import 'package:flutter/material.dart';
import 'package:notes_maybank/models/user_model.dart';
import 'package:notes_maybank/services/user_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  UserService userService = UserService();

  show() async {
    users = await userService.getUsers();
    setState(() {
      users = users;
    });
  }

  @override
  void initState() {
    super.initState();
    show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data User"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(users[index].avatar),
              ),
              title: Text(
                users[index].first_name + " " + users[index].last_name,
              ),
              subtitle: Text(users[index].email),
            ),
          );
        },
      ),
    );
  }
}
