import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final databaseRef =
      FirebaseDatabase.instance.reference().child("User Registration");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text("Entire Data")),
      ),
      body: FutureBuilder(
          future: databaseRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              lists.clear();

              Map<dynamic, dynamic> values = snapshot.data!.value;
              values.forEach((key, value) {
                lists.add(value);
              });

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Name" + lists[index]["name"]),
                            Text("Email" + lists[index]["email"]),
                            Text("Phone" + lists[index]["phone"]),
                            Text("Address" + lists[index]["address"]),
                            Text("Password" + lists[index]["password"]),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
