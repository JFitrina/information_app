import 'package:flutter/material.dart';
import 'package:information_app/controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  // สร้างตัวควบคุมสำหรับเก็บค่าที่ป้อนใน TextField
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  final _authController = AuthService();

  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _roleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      print('name:${_nameController.text}');
      print('surname:${_surnameController.text}');
      print('email:${_emailController.text}');
      print('username:${_usernameController.text}');
      print('password:${_passwordController.text}');
      print('role:${_roleController.text}');
    }

    try {
      final user = AuthService().register(
          _nameController.text,
          _surnameController.text,
          _emailController.text,
          _usernameController.text,
          _passwordController.text,
          _roleController.text);

      if (user != null) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomePage()),
        // );
      } else {
        //ถ้าลงทะเบียนไม่สำเร็จ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),

                // ช่องสำหรับกรอกชื่อ
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'name',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // ช่องสำหรับกรอกนามสกุล
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    labelText: 'surname',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // ช่องสำหรับกรอกอีเมล
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // ช่องสำหรับกรอกชื่อผู้ใช้
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'username',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // ช่องสำหรับกรอกรหัสผ่าน
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(color: Colors.blueAccent),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 10) {
                      return 'Password must be at least 10 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                //role
                TextFormField(
                  controller: _roleController,
                  decoration: InputDecoration(labelText: 'ROLE'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your role';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // ปุ่มสมัครสมาชิก
                ElevatedButton(
                  onPressed: () {
                    _register();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
