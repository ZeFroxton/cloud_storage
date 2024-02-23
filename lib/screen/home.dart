import 'package:cloud_storage_app/component/fab.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

@immutable
class Home extends StatefulWidget {
  

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  //fungsi untuk menjalankan Floating Button
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
  //fungsi untuk image picker
  FilePickerResult? result;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyDrive'),
        elevation: 4,
       actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.more_vert,
          size: 30,
          ),
        )
       ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu,
              size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: 
          Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mydrive',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.list,
                    size: 30,
                    ),
                  ],
                ),
              
            ),
          ),
        ),
      
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  Text('Your Name')
                ],
              )
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () { 
                context.push("/recent");
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                context.push("/trash");
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
        children: [
          if(result != null)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const Text('Selected file:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                            itemBuilder: (context, index) {
                          return Text(result?.files[index].name ?? '', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
                        })
                      ],
                    ),),
        ],
      )),
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
          ActionButton(
            onPressed: () async{
                     result = await FilePicker.platform.pickFiles(allowMultiple: true );
                      if (result == null) {
                          print("No file selected");
                        } else {
                        setState(() {
                        });
                         result?.files.forEach((element) {
                           print(element.name);
                         });
                        }
                  },
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}


