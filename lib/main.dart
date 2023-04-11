import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebaseApp(),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  const FirebaseApp({Key? key}) : super(key: key);

  @override
  State<FirebaseApp> createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My name is $name',
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
            //Crud Operation
            ElevatedButton(
              onPressed: () {
                //database name in firebase
                var firestore = FirebaseFirestore.instance.collection('users');

                print("object");
                //adding document in fire store it will store user details
                var store = firestore.doc('my_doc');
                store.set({
                  'name': 'chuma',
                  'username': 'sheby460',
                  'gender': 'male',
                  'email': 'chuma@gmail.com',
                  'contact': '0713105050'
                });
              },
              child: const Text('Create'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                var firestore = FirebaseFirestore.instance
                    .collection('users')
                    .doc('my_doc');

                firestore.get().then((value) {
                  name = value.data()!['name'];
                  setState(() {});
                });
              },
              child: const Text('View'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                var firestore = FirebaseFirestore.instance
                    .collection('users')
                    .doc('my_doc');
                firestore.update({
                  'name': "chuma",
                });
              },
              child: const Text('Update'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                var firestore = FirebaseFirestore.instance
                    .collection('users')
                    .doc('my_doc');
                firestore.delete();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
