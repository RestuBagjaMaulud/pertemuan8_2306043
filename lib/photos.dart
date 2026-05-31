import 'package:flutter/material.dart';
import 'package:pertemuan8_1/providers/photo_provider.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PhotoProvider>().fetchPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhotoProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Foto",
          style: TextStyle(
            color: Colors.white,
            fontWeight: .bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false
      ),
      body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text('provider.errorMessage'),);
          }

        return ListView.builder(
              itemCount: provider.photos.length,
              itemBuilder: (context, index) {
                final photo = provider.photos[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(photo.author),
                    subtitle: Image.network(photo.url),
                    // leading: CircleAvatar(child: Text(photo.id.toString())),
                  ),
                );
              },
            );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Icon(Icons.home),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/photos');
            },
            child: Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
