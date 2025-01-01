import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
import 'utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //ensure flutter engine properly initialized for use within flutter app
  await Firebase.initializeApp(); //initialize firebase features for use within flutter app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _skillslist = [];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() { // to add a listener to listen to text in the textbox,
      // whenever textbox changes(got input etc),
      // it calls API and passes that input to the API via the onQueryChanged function.
      onQueryChanged(_controller.text);
    });
  }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    Future <void> onQueryChanged(String query) async {
      final token = await getUserToken();

      if (query.isEmpty) {
        setState(() {
          _skillslist = [];
        });
        return;
      }

      try {
        var skills = await fetchSkill(token!, query);
        setState(() {
          _skillslist = skills!;
        });
      } catch (e) {
        print('Error: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold( // Scaffold is just something that provides the basic tools for material design layout eg all the buttons etc
        // Scaffold expands to fill the entire home page.
        appBar: AppBar(
          title: const Text("SkillsSG",
              style:
              TextStyle(
                color: Colors.purple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Customize button color
                  elevation: 0, // Optional: Make it flat like an icon button
                ),
                child: const Text(
                  "Login/Register",
                  style: TextStyle(color: Colors.white), // Customize text color
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SettingsPage()));
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                    }
                ),
              ],
            )
        ),
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              width: 500,
              height: 500,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Key in desired skill",
                  filled: true,
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: onQueryChanged, //onChanged expects a string or an action, but fetchSkill returns a list, thus we need to wrap the fetchSkill function in another function that returns a string.
              ),
            ),
          ],
        ),
      );
    }
  }