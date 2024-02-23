import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({super.key});

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
   FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent'),
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
                      'Recent',
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
                // Action when Item 1 is tapped
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Action when Item 2 is tapped
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
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.history,
                          size: 70,
                          color: Colors.grey,
                          ),
                          Text("Recent",
                          style: TextStyle(
                            fontSize: 30,
                          color: Colors.grey,
                          ),
                          ),
                          Text("Your recent items will appear here",
                          style: TextStyle(
                            fontSize: 15,
                          color: Colors.grey,
                          ),
                          )
                        ],
                      ),
                    )
        ],
      )),
     
    );
  }
}