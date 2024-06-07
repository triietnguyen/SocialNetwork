import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() {
              if (_authController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    _authController.register(
                      _usernameController.text,
                      _passwordController.text,
                    );
                  },
                  child: Text('Register'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
