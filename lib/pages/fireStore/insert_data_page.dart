import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InsertDataPage extends StatefulWidget {
  static const String routeName = '/InsertDataPage';
  const InsertDataPage({Key? key}) : super(key: key);

  @override
  State<InsertDataPage> createState() => _InsertDataPageState();
}

class _InsertDataPageState extends State<InsertDataPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("FireStore add data"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Age",
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: "City",
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: addData,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addData() async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully Added Data')));
    Navigator.of(context).pop();
    String docId = DateTime.now().microsecondsSinceEpoch.toString();
    return users
        .doc(docId)
        .set({
          "id": docId,
          "Name": nameController.text.toString(),
          "Age": ageController.text,
          "City": cityController.text.toString(),
        })
        .then((value) => print("Data Added Sucessfully"))
        .onError((error, stackTrace) => print('There is Error: $error'));
  }
}
