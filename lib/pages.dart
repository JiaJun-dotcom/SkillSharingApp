import 'package:flutter/material.dart';
import 'model.dart';
import 'utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center( // Centers the ConstrainedBox in the available space
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // Maximum width for the form
          ),
          child: Column(
            // ensures that the text fields are not too stretched out and are centered by wrapping them inside a constrained box, setting specific width.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  contentPadding: EdgeInsets.all(10),
                ),
                obscureText: true, // Hides password characters
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                onPressed: () {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  loginUser(username, password);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = Future.value(Profile.empty());
    loadprofile();
  }

  void loadprofile() async {
    final token = await getUserToken();
    if (token != null) {
      setState(() {
        futureProfile = fetchProfile(token);
      });
    } else {
      // Handle user not logged in
      Navigator.pushReplacementNamed(context, '/login');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: futureProfile,
          builder: (context, snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While the future is loading, show a loading indicator
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // If the future encounters an error, show an error message
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData) {
        // If the future resolves successfully with data, display the profile details
        final profile = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profile.profilepic != null)
          Container(width: 100, height: 100, decoration:
            const BoxDecoration(shape: BoxShape.circle), child: profile.profilepic)
              else
                  Container(
                      width: 100,
                      height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  child: Icon(
                    Icons.person, // Placeholder icon
                    size: 50,
                    color: Colors.grey[700],
                  ),
                  ),
              const SizedBox(height: 10),
              Text('Name: ${profile.name}', style: const TextStyle(fontSize: 18)),
              Text('Email: ${profile.email}', style: const TextStyle(fontSize: 18)),
              Text('Skills: ${profile.skills.join(", ")}',
                  style: const TextStyle(fontSize: 18)),
              Text('Number: ${profile.hpnumber}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      } else {
        // If there’s no data (unexpected), display a placeholder
        return const Center(child: Text('No profile data available'));
      }
    },
    ));
  }
}

class SkillDetailsPage extends StatelessWidget {
  final Map<String, dynamic> skill;

  const SkillDetailsPage({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> profiles = skill['teachers'] ?? [];

    return Scaffold(
      appBar: AppBar(title: skill['name'],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill Description
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                skill['description'] ?? 'No description available.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(profile['name'] ?? 'Anonymous'),
                      trailing: TextButton(
                        onPressed: () {
                          // Navigate to Profile Details Page
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                            //make link to each profile's details etc
                          ),
                          );
                        },
                        child: const Text('More Details'),
                      ),
                      //can have one more button for chat function, so that people interested to learn can enquire with teachers through chat.
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
