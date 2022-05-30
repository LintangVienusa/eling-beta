import 'package:dropdown_search/dropdown_search.dart';
import 'package:eling/datepicker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('TASK REMINDER'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              'No task yet :(',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSimpleDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showSimpleDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "ADD NEW TASK",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "What kind of task?",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              items: ['A','B'],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Task Name",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.5, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Description of the task \n\n\n\n\n\n",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.5, horizontal: 15.0),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  color: Colors.cyan,
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TanggalPicker()));
                },
                )
              ],
            )
          )
        ],
      );
    },
  );
}