import 'package:flutter/material.dart';
import 'package:information_app/pages/login.dart';
import 'package:information_app/pages/register.dart'; // เพิ่มการนำเข้า RegisterPage
import 'package:information_app/provider/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return Center(
            child: Container(
              width: width * 0.8, // ใช้ 80% ของความกว้างหน้าจอ
              height: height * 0.5, // ใช้ 50% ของความสูงหน้าจอ
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // นำทางไปยังหน้า login
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('ไปยังหน้า Login'),
                  ),
                  SizedBox(height: 20), // เพิ่มระยะห่างระหว่างปุ่ม
                  ElevatedButton(
                    onPressed: () {
                      // นำทางไปยังหน้า register
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text('ไปยังหน้า Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
