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
              leading: Icon(Icons.folder_outlined),
              title: Text('My Drive'),
              onTap: () {Navigator.pushNamed(context, "drive_storage");
                // Action when Item 1 is tapped
              },
              
            ),
            ListTile(
              leading: Icon(Icons.folder_zip_outlined),
              title: Text('Settings'),
              onTap: () {
                context.push('/setting');
              },
            ),
            ListTile(
              leading: Icon(Icons.folder_shared_outlined),
              title: Text('Shared with me'),
              onTap: () {Navigator.pushNamed(context, "Shared_page");
              
              },
            ),
            ListTile(
              leading: Icon(Icons.timelapse_outlined),
              title: Text('Recent'),
              onTap: (){Navigator.pushNamed(context, "recent_page");

              },
            ),
            ListTile(
              leading: Icon(Icons.star_outline),
              title: Text('Favorite'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Trash'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload_outlined),
              title: Text('Upload manager'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Settings'),
              onTap: (){

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

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
