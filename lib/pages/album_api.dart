import 'package:flutter/material.dart';
import 'package:notes_maybank/models/api_response.dart';
import 'package:notes_maybank/services/album_service.dart';

class AlbumApi extends StatefulWidget {
  const AlbumApi({super.key});

  @override
  State<AlbumApi> createState() => _AlbumApiState();
}

class _AlbumApiState extends State<AlbumApi> {
  // buat varible untuk menampung list album
  List<dynamic> _listAlbum = [];
  bool isLoading = true;

  // panggil service
  Future<void> getAll() async {
    ApiResponse response = await getAlbum();
    // jika res berhasil
    if (response.error == null) {
      setState(() {
        debugPrint(response.data.toString());
        isLoading = false;
        _listAlbum = response.data as List<dynamic>;
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
        title: Text("Data Album"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body:
          (isLoading)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _listAlbum.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Icon(Icons.album, color: Colors.deepPurple),
                      title: Text(_listAlbum[index]['title']),
                      subtitle: Text("ID: ${_listAlbum[index]['id']}"),
                    ),
                  );
                },
              ),
    );
  }
}
