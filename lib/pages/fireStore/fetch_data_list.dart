import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/pages/fireStore/update_data_page.dart';

import 'insert_data_page.dart';

class FetchDataList extends StatefulWidget {
  static const String routeName = '/FetchDataList';
  const FetchDataList({Key? key}) : super(key: key);

  @override
  State<FetchDataList> createState() => _FetchDataListState();
}

class _FetchDataListState extends State<FetchDataList> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InsertDataPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("FireStore Fetch/Get Data"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text("Something Went Wrong");
              }
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                    final cityName = snapshot.data!.docs[index]['City'];
                    final userName = snapshot.data!.docs[index]['Name'];
                    final userAge = snapshot.data!.docs[index]['Age'];
                    final docId = snapshot.data!.docs[index].id;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        dense: true,
                        tileColor: Colors.purple.shade50,
                        style: ListTileStyle.list,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        leading: Text(cityName.toString()),
                        title: Text(userName.toString()),
                        subtitle: Text(userAge.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  final userData = UserModel(
                                      cityName: cityName,
                                      userAge: userAge,
                                      userName: userName,
                                      docId: docId);
                                  Navigator.pushNamed(
                                      context, UpdateDataPage.routeName,
                                      arguments: userData);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'You have successfully deleted')));
                                  return userData
                                      .doc(docId.toString())
                                      .delete()
                                      .then((value) => print("User Deleted"))
                                      .catchError((error) => print(
                                          "Failed to delete user: $error"));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
// ListView(
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// children:
// snapshot.data!.docs.map((DocumentSnapshot document) {
// Map<String, dynamic> data =
// document.data()! as Map<String, dynamic>;
// return ListTile(
// title: Text(data['Name']),
// subtitle: Text(data['Age']),
// leading: Text(data['City']),
// );
// }).toList(),
// ),

class UserModel {
  final String cityName;
  final String userName;
  final String userAge;
  final String docId;
  UserModel(
      {required this.cityName,
      required this.userName,
      required this.userAge,
      required this.docId});
}
