import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Model
class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});
}

// Controller
class UserController extends GetxController {
  var user = UserModel(name: 'FirstName LastName', email: 'first_name@example.com').obs;

  void updateUser(String name, String email) {
    user.value = UserModel(name: name, email: email);
  }
}

// Home Page
class HomePage extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GetX Simple Example')),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${controller.user.value.name}', style: TextStyle(fontSize: 18)),
              Text('Email: ${controller.user.value.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => Get.to(() => EditPage()), child: Text('Edit Profile')),
            ],
          ),
        ),
      ),
    );
  }
}

// Edit Page
class EditPage extends StatelessWidget {
  final UserController controller = Get.find();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    nameController.text = controller.user.value.name;
    emailController.text = controller.user.value.email;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateUser(nameController.text, emailController.text);
                Get.back();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(home: HomePage()));
}
