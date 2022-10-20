import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgets = [];
  // this is the list for the controllers
  List<TextEditingController> controllers = [];
  int inde = 0;
  List<List> blogList = [];

  // you need to add this in order to dispose
  // the controllers when the widget is disposed
  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Note'),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: widgets.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: widgets[index],
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Delete?'),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widgets.removeAt(index);
                                        // dispose the controller
                                        //controllers[index].dispose();
                                        // remove the controller from list
                                        controllers.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.check))
                              ],
                            ));
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                // create a new controller and add it to the list
                final newController = TextEditingController();
                controllers.add(newController);

                widgets.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2),
                        color: const Color.fromARGB(255, 76, 178, 204),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.circle),
                        // assign the controller to the field
                        title: TextField(controller: newController),
                      )),
                ));
              });
            },
            child: const Icon(Icons.add),
          ),
        ]));
  }
}
