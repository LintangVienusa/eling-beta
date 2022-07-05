
// import 'package:flutter/material.dart';
// import 'database/db_helper.dart';
// import 'model/Tasks.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:eling/main.dart';
    
//     class FormTasks extends StatefulWidget {
//         final Tasks? tasks;
    
//         FormTasks({this.tasks});
    
//         @override
//         _FormEditState createState() => _FormEditState();
//     }
    
//     class _FormEditState extends State<FormTasks> {
//         DbHelper db = DbHelper();
    
//         String? taskCats;
//         TextEditingController? taskName;
//         TextEditingController? taskDesc;
//         String? kindTask;
//         // TextEditingController? remindAt;
    
//         @override
//         void initState() {
//         taskCats = taskCats;
    
//         taskName = TextEditingController(
//             text: widget.tasks == null ? '' : widget.tasks!.taskName);
    
//         taskDesc = TextEditingController(
//             text: widget.tasks == null ? '' : widget.tasks!.taskDesc);
    
//         // remindAt = TextEditingController(
//         //     text: widget.kontak == null ? '' : widget.kontak!.company);
            
//         super.initState();
//         }
    
//         @override
//         Widget build(BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//             title: Text('Edit Tasks'),
//             ),
//             body: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 // child: TextField(
//                 //     controller: name,
//                 //     decoration: InputDecoration(
//                 //         labelText: 'Name',
//                 //         border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(8),
//                 //         )),
//                 // ),
//                 child: DropdownSearch<String>(
//                 mode: Mode.MENU,
//                 items: const ['Forum', 'Quiz', 'Tugas'],
//                 onChanged: (text) {
//                   setState(() {
//                     print("tasknya: $taskCats");
//                   });
//                 },
//               ),
//                 ),
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 child: TextField(
//                     controller: taskName,
//                     decoration: InputDecoration(
//                         labelText: 'Task Name',
//                         border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         )),
//                 ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(
//                 //       top: 20,
//                 //   ),
//                 //   child: TextField(
//                 //       controller: taskDesc,
//                 //       decoration: InputDecoration(
//                 //         labelText: 'Task Description',
//                 //         hintText: "\n\n\n\n\n\n",
//                 //         border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(8),
//                 //         )
//                 //       ),
//                 //     ),
//                 //   ),

//                 //   Padding(
//                 //   padding: const EdgeInsets.only(
//                 //       top: 20,
//                 //   ),
//                 //   child: TextField(
//                 //       controller: company,
//                 //       decoration: InputDecoration(
//                 //           labelText: 'Company',
//                 //           border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.circular(8),
//                 //           )),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20
//                   ),
//                   child: ElevatedButton(
//                       child: (widget.tasks == null)
//                           ? Text(
//                               'Add',
//                               style: TextStyle(color: Colors.white),
//                           )
//                           : Text(
//                               'Update',
//                               style: TextStyle(color: Colors.white),
//                           ),
//                       onPressed: () async {
//                       upsertTask();
//                       Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => MyApp()));
//                       },
//                   ),
//                 )
//             ],
//             ),
//         );
//         }

//         Future<void> upsertTask(dateinput, timeinput) async {
//     var dateandtime = dateinput+' '+timeinput;
//     DateTime valdateandtime = DateTime.parse(dateandtime);
//     int epoch = valdateandtime.millisecondsSinceEpoch;
//     DateTime idTask = DateTime.now();
//     int convertedID = idTask.millisecondsSinceEpoch;

//     // var converteddata = DateTime.fromMillisecondsSinceEpoch(epoch);
//     if (widget.tasks != null) {
//         //update
//         await db.updateTasks(Tasks.fromMap({
//         'taskID' : convertedID,
//         'taskCats' : kindTask!,
//         'taskName' : valtaskName.text,
//         'taskDesc' : valtaskDesc.text,
//         'remindAt' : valdateandtime
//         }));
//         Navigator.push(context,
//         MaterialPageRoute(builder: (context) => MyApp()));
//     }
//   }
    
//     }