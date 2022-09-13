import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/db.dart';
import 'firebase_options.dart';
import 'models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    title: 'learning',
    home: TestApp(),
  ));
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final db = DatabaseService();

  final Stream<QuerySnapshot> profiles =
      FirebaseFirestore.instance.collection('profiles').snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 5.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'WEIGHTED',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              },
            )
          ],
        ),
        body: Stack(alignment: Alignment.center, children: <Widget>[
          karte(),
        ]),
        persistentFooterButtons: [
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.disabled_by_default),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      )),
                ),
              ),
              // const Spacer(),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.check_circle_outline),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 43, 156, 102),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*
class Profile {
  final String? ime;
  final String? bio;
  final String? image;

  Profile({this.ime, this.bio, this.image});

  Profile.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  )   : ime = doc.data()!['ime'],
        bio = doc.data()!['bio'],
        image = doc.data()!['image'];

  Map<String, dynamic> ToFirestore() {
    return {'ime': ime, 'bio': bio, 'image': image};
  }
}
*/

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');

  TextEditingController nameController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  final de = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Ime',
                ),
              ),
              TextFormField(
                controller: imageController,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Imageurl',
                ),
              ),
              TextFormField(
                controller: bioController,
                keyboardType: TextInputType.text,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'bio',
                ),
              ),
              ElevatedButton(
                onPressed: () => de.addSkica({
                  'name': nameController.text,
                  'bio': bioController.text,
                  'image': imageController.text
                }),
                child: Text("Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Object> dragabbleItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Chat'),
      centerTitle: true,
    ));
  }

  Future readlist() async {
    var data = await FirebaseFirestore.instance.collection('profiles').get();

    return dragabbleItems =
        List.from(data.docs.map((doc) => skica.fromSnapshot(doc)));
  }
}

Widget _buildStack(BuildContext, DocumentSnapshot document) {
  return Positioned(
    child: Card(
      elevation: 8,
      child: Container(
        height: 580,
        width: 340,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  document['image'],
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: 340,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        document['name'],
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        document['bio'],
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class karte extends StatelessWidget {
  const karte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('profiles').snapshots(),
        builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('loading..');

          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) => Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      _buildStack(context, data.docs[index]),
                    ],
                  ));
        });
  }
}

class BackgroudCurveWidget extends StatelessWidget {
  const BackgroudCurveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(64),
            bottomRight: Radius.circular(64),
          ),
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFD0E42),
            Color(0xFFC30F31),
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 46.0, left: 20.0),
        child: Text(
          'Discover',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
