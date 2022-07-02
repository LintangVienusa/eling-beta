// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eling/services/PushNotificationService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'database/db_helper.dart';
import 'model/tasks.dart';
// ignore: unused_import
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
  const MyHomePage({Key? key, required this.title, this.tasks}) : super(key: key);

  final String title;
  final Tasks? tasks;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final DatabaseReference debe = FirebaseDatabase.instance.ref();
  // final Future<FirebaseApp> _future = Firebase.initializeApp();
  var valtaskName = TextEditingController();
  var valtaskDesc = TextEditingController();
  var dateinput = TextEditingController();
  var timeinput = TextEditingController();
  final List listTaskName = [];
  final List listCats = [];
  final List lisDesc = [];
  final List lisTime = [];
  
  List<Tasks> listtasks = [];
  DbHelper db = DbHelper();
  // let ref = Database.database("https://<databaseName><region>.firebasedatabase.app")
  String? kindTask;
  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getTasks();
    super.initState();
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

      body: ListView.builder(
          itemCount: listtasks.length,
          itemBuilder: (context, index) {
            Tasks tasks = listtasks[index];
            final xremindAt = tasks.remindAt;
            var converteddata = DateTime.fromMillisecondsSinceEpoch(xremindAt!);
            return Padding(
            padding: const EdgeInsets.only(
                top: 20
            ),
            child: ListTile(
              leading: Icon(
              Icons.edit_note, 
              size: 50,
              ),
              title: Text(
              '${tasks.taskCats}'
              ),
              subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Padding(
                      padding: const EdgeInsets.only(
                          top: 8, 
                      ),
                      child: Text("${tasks.taskName}"),
                      ), 
                      Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                      ),
                      child: Text("${tasks.taskDesc}"),
                      ),
                      Padding(
                      padding: const EdgeInsets.only(
                          top: 8,
                      ),
                      child: Text("${tasks.remindAt}"),
                      )
                  ],
                  ),
                  trailing: 
                  FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                      children: [
                      // button edit 
                      // IconButton(
                      //     onPressed: () {
                      //     _openFormEdit(kontak);
                      //     },
                      //     icon: Icon(Icons.edit)
                      // ),
                      // button hapus
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                              title: Text("Information"),
                              content: Container(
                              height: 100, 
                              child: Column(
                                  children: [
                                  Text(
                                      "Yakin ingin Menghapus Reminder ${tasks.taskName} ?"
                                  )
                                  ],
                              ),
                              ),
                              //terdapat 2 button.
                              //jika ya maka jalankan _deleteKontak() dan tutup dialog
                              //jika tidak maka tutup dialog
                              actions: [
                              TextButton(
                                  onPressed: (){
                                  _deleteTasks(tasks, index);
                                  Navigator.pop(context);
                                  }, 
                                  child: Text("Ya")
                              ), 
                              TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                  Navigator.pop(context);
                                  },
                              ),
                              ],
                          );
                          showDialog(context: context, builder: (context) => hapus);
                          }, 
                      )
                      ],
                  ),
                  ),
              ),
              );
          }),
          //membuat button mengapung di bagian bawah kanan layar
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add), 
              onPressed: (){
              _showSimpleDialog(context);
              },
          ),
            
        );
        
        

    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       _showSimpleDialog(context);
    //     },
    //     child: const Icon(
    //       Icons.add,
    //       color: Colors.white,
    //     ),
    //   ),
    // );

    
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

  void _showSimpleDialog2(BuildContext context) {
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
                          upsertTask(dateinput.text, timeinput.text);
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

  Future<void> _getTasks() async {
    //list menampung data dari database
    var list = await db.getTasks();
        //ada perubahanan state
    setState(() {
            //hapus data pada listKontak
      listtasks.clear();
            //lakukan perulangan pada variabel list
      list!.forEach((tasks) {
        //masukan data ke listKontak
        listtasks.add(Tasks.fromMap(tasks));
      });
    });
  }

  Future<void> _deleteTasks(Tasks tasks, int position) async {
    await db.deleteTasks(tasks.id!);
    setState(() {
        listtasks.removeAt(position);
    });
  }

  Future<void> upsertTask(dateinput, timeinput) async {
    var dateandtime = dateinput+' '+timeinput;
    DateTime valdateandtime = DateTime.parse(dateandtime);
    int epoch = valdateandtime.millisecondsSinceEpoch;
    // var converteddata = DateTime.fromMillisecondsSinceEpoch(epoch);
    if (widget.tasks != null) {
        //update
        await db.updateTasks(Tasks.fromMap({
        // 'id' : widget.tasks!.id,
        'taskCats' : kindTask!,
        'taskName' : valtaskName.text,
        'taskDesc' : valtaskDesc.text,
        'remindAt' : valdateandtime
        }));
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyApp()));
    } else {
        //insert
        await db.storeTask(Tasks(
            // id: int? taskId!.text,
            taskCats: kindTask,
            taskName: valtaskName.text,
            taskDesc: valtaskDesc.text,
            remindAt: epoch
        ));
        // Navigator.pop(context, 'save');
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

}

