import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:household_app/db_helper.dart';
import 'package:household_app/vendor_details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future<List<Vendor>> vendors;
  TextEditingController controller = TextEditingController();
  String name;
  int id;
  final formKey = new GlobalKey<FormState>();
  var dbhelper;
  bool isUpdating;

  _Screen1State() {
    dbhelper = DBhelper();
  }
  @override
  void setState(fn) {
    super.setState(fn);
    isUpdating = false;
  }

  clearName() {
    controller.text = "";
  }

  refreshList() {
    setState(() {
      vendors = dbhelper.getVendor();
    });
  }

  add() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Vendor v = Vendor(name, id);
        dbhelper.update(v);
        setState(() {
          isUpdating = false;
        });
        clearName();
      } else {
        Vendor v = Vendor(name, null);
        dbhelper.save(v);
      }
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: controller,
              style: TextStyle(fontSize: 20),
              validator: (val) =>
                  val.length == 0 ? 'Enter name of vendor' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: add,
                  child: Text('ADD'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  data(List<Vendor> vendors) {
    return Column(
      children: vendors.map<Widget>((vendor)=>
          Text(vendor.id.toString())
        ).toList()
      // <Widget>[
      //   Text("Vendor list"),
        
      //   ListView.builder(
      //       itemCount: vendors.length,
      //       itemBuilder: (BuildContext ctx, int index) {
      //         return ListTile(
      //           title: Text("some vendor"),
      //           trailing: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               IconButton(icon: Icon(Icons.settings), onPressed: () {}),
      //               IconButton(icon: Icon(Icons.settings), onPressed: () {}),
      //             ],
      //           ),
      //         );
      //       }),
      // ],
    );
  }

  list() {
    return FutureBuilder(
        future: dbhelper.getVendor(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return data(snapshot.data);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Vendors List',
                style: TextStyle(
                  fontSize: 20,
                ))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //form(),
            list()
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            /*
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => Registration()));*/
          },
          label: Text(
            'Register',
            style: TextStyle(fontSize: 15),
          ),
        ));
  }
}
