// import 'package:flutter/cupertino.dart';
import 'package:eling/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TanggalPicker extends StatefulWidget {
  const TanggalPicker({Key? key}) : super(key: key);

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<TanggalPicker> {

  @override 
  void initState() {  
    // _showSimpleDialog(context);
    super.initState();
    dialogAsync();
  }
  dialogAsync() async{
  await Future.delayed(const Duration(milliseconds: 500));

    _showSimpleDialog(context);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('TASK REMINDER'),
        ),
      ),
    );
  }
}

void _showSimpleDialog(BuildContext context) {
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
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
            Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: const InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Enter Date" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(3000)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      // setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      // });
                  }else{
                      print("Date is not selected");
                  }
                },
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
                controller: timeinput, //editing controller of this TextField
                decoration: const InputDecoration( 
                   icon: Icon(Icons.access_time), //icon of text field
                   labelText: "Enter Time" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: time 
                  );
                  
                  if(pickedTime != null ){

                        var min = pickedTime.minute.toString();
                        var hour = pickedTime.hour.toString();
                        if (hour.length == 1) {
                          hour = '0'+hour;
                        }
                        if (min.length == 1) {
                          min = '0'+min;
                        }
                        timeinput.text = hour+":"+min;
                        print(timeinput);
                  }else{
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
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
                },
                )
              ],
            )
          )
        ],
      );
    }
  );
}



