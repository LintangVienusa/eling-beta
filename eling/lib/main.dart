import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eling Task Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Eling Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  // final String title;

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
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input nama lengkap",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Kontak",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input kontak",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "SIMPAN",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          )
        ],
      );
    },
  );
}
