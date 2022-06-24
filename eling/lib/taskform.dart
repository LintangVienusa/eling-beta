import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class FormPage extends StatefulWidget {
//constructor have one parameter, optional paramter
//if have id we will show data and run update method
//else run add data
const FormPage({this.id});

final String? id;

@override
State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
//set form key
  final _formKey = GlobalKey<FormState>();
  
  //set texteditingcontroller variable
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  
  //inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? users;
  
  void getData() async {
    //get users collection from firebase
    //collection is table in mysql
    users = firebase.collection('users');
  
    //if have id
    if (widget.id != null) {
      //get users data based on id document
      var data = await users!.doc(widget.id).get();
  
      //we get data.data()
      //so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;
  
      //set state to fill data controller from data firebase
      setState(() {
        nameController = TextEditingController(text: item['name']);
        phoneNumberController = TextEditingController(text: item['phoneNumber']);
        emailController = TextEditingController(text: item['email']);
        addressController = TextEditingController(text: item['address']);
      });
    }
  }
  
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}