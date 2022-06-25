// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eling/services/PushNotificationService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  await PushNotificationService().setupInteractedMessage();
  runApp(MyApp());
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application
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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DatabaseReference debe = FirebaseDatabase.instance.ref();
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  var valtaskName = TextEditingController();
  var valtaskDesc = TextEditingController();
  var dateinput = TextEditingController();
  var timeinput = TextEditingController();
  final List listTaskName = [];
  final List listCats = [];
  final List lisDesc = [];
  final List lisTime = [];
  // let ref = Database.database("https://<databaseName><region>.firebasedatabase.app")
  String? kindTask;
  @override
  void initState() {
    _read();
  }

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
          child: Text('TASK REMINDER',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      // body: Center(
      //     child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     // ignore: prefer_const_literals_to_create_immutables
      //     children: <Widget>[
      //       const Text(
      //         'Tester commit :(',
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = listTaskName[index];
          // return Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Text(datalist[index], style: TextStyle(fontSize: 30)),
          //   ),
          // );
          return ListTile(
            title: Text(listTaskName[index]),
            subtitle: Text(lisDesc[index] + ' - ' + lisTime[index]),
          );
        },
        itemCount: listTaskName.length,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSimpleDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showSimpleDialog(context) {
    final _formKey = GlobalKey<FormState>();
    // String? kindTask;

    //set texteditingcontroller variable

    //inisialize firebase instance
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    CollectionReference? users;
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
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
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
                items: ['Forum', 'Quiz', 'Tugas'],
                onChanged: (text) {
                  setState(() {
                    kindTask = text;
                    print("tasknya: $kindTask");
                  });
                },
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
                controller: valtaskName,
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
                controller: valtaskDesc,
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
                        _showSimpleDialog2(context);
                        // Navigator.push(
                        // context, MaterialPageRoute(builder: (context) => TanggalPicker()));
                      },
                    )
                  ],
                ))
          ],
        );
      },
    );
  }

  void _showSimpleDialog2(BuildContext context) {
    // sleep(Duration(seconds: 3));
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController dateinput = TextEditingController();
          TextEditingController timeinput = TextEditingController();
          return SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "ADD NEW TASK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "When to notify?",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(3000));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement
                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  controller: timeinput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.access_time), //icon of text field
                      labelText: "Enter Time" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: time);

                    if (pickedTime != null) {
                      var min = pickedTime.minute.toString();
                      var hour = pickedTime.hour.toString();
                      if (hour.length == 1) {
                        hour = '0' + hour;
                      }
                      if (min.length == 1) {
                        min = '0' + min;
                      }
                      setState(() {
                        timeinput.text = hour + ":" + min;
                      });
                      print(timeinput);
                    } else {
                      print("Date is not selected");
                    }
                  },
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
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          createRecord(dateinput.text, timeinput.text);
                          Navigator.of(context).pop();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                      )
                    ],
                  ))
            ],
          );
        });
  }

  Future<void> createRecord(String tgl, String jam) async {
    DateTime now = DateTime.now();
    try {
      await firestore.collection('users').doc('testusers').set({
        'taskCats': kindTask,
        'taskName': valtaskName.text,
        'taskDesc': valtaskDesc.text,
        'remindTime': tgl + ' ' + jam,
      });
      // print(tgl);
      // print(jam);
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testusers').get();
      print(documentSnapshot.data());
      print('udah masuk');
      var taskname = documentSnapshot.get('taskName');
      var taskCats = documentSnapshot.get('taskCats');
      var taskDesc = documentSnapshot.get('taskDesc');
      var remindTime = documentSnapshot.get('remindTime');
      setState(() {
        listTaskName.add(taskname);
        listCats.add(taskCats);
        lisDesc.add(taskDesc);
        lisTime.add(remindTime);
      });
    } catch (e) {
      print(e);
    }
  }
}
