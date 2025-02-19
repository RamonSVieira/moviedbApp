import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = _usernameController.text.trim();
                if (username.isNotEmpty) {
                  Provider.of<UserProvider>(context, listen: false)
                      .setUsername(username);
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
