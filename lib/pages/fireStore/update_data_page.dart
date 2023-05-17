import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire/pages/fireStore/fetch_data_list.dart';

class UpdateDataPage extends StatefulWidget {
  static const String routeName = '/UpdateDataPage';
  const UpdateDataPage({Key? key}) : super(key: key);

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var cityController = TextEditingController();
  CollectionReference userData = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as UserModel;
    cityController.text = data.cityName;
    nameController.text = data.userName;
    ageController.text = data.userAge;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("FireStore Update data"),
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
              controller: nameController..text = data.userName,
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
              controller: ageController..text = data.userAge,
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
              controller: cityController..text = data.cityName,
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
                onPressed: () => saveData(data.docId),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveData(String docId) async {
    await userData
        .doc(docId)
        .update({
          'Name': nameController.text.toString(),
          'Age': ageController.text,
          'City': cityController.text.toString(),
        })
        .then((value) => print("Data updated Sucessfully"))
        .onError((error, stackTrace) => print('There is Error: $error'));
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully updated')));

    Navigator.of(context).pop();
  }
}
