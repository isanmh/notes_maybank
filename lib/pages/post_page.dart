import 'package:flutter/material.dart';
import 'package:notes_maybank/models/api_response.dart';
import 'package:notes_maybank/services/post_service.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // buat varible untuk menampung list album
  List<dynamic> _listPosts = [];
  bool isLoading = true;

  // panggil service
  Future<void> getAll() async {
    ApiResponse response = await getPost();
    // jika res berhasil
    if (response.error == null) {
      setState(() {
        debugPrint(response.data.toString());
        isLoading = false;
        _listPosts = response.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Post"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body:
          (isLoading)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _listPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.album, color: Colors.deepPurple),
                      // title: Text(_listPosts[index]['title']),
                      // subtitle: Text("ID: ${_listPosts[index]['id']}"),
                    ),
                  );
                },
              ),
    );
  }
}
