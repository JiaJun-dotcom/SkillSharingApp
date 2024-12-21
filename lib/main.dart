import 'package:flutter/material.dart';
import 'pages.dart';
import 'utils.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
    //fetchData();
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Customize button color
                  elevation: 0, // Optional: Make it flat like an icon button
                ),
                child: const Text(
                  "Login",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
              ),
        /*      ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ), */
           ListTile(
             leading: const Icon(Icons.person), title: const Text('Profile'),
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
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

/*class SkillsPage extends StatelessWidget {  Skills skills = Skills.fromJson(name: response['name'], Description: response['Description']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: ListView.builder( itemCount: Skillslist.length(),              itemBuilder: (BuildContext context, int index) {
               return ListTile(

                ),
            ),
          ),
        ],
      )
    );
    }
*/