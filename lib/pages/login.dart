import 'package:flutter/material.dart';
import 'package:information_app/models/user.dart';
import 'package:information_app/controller/auth_controller.dart';
import 'package:information_app/pages/register.dart';
import 'package:information_app/main.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final userModel = await _authService.login(
          _usernameController.text,
          _passwordController.text,
        );

        if (userModel != null) {
          Provider.of<UserProvider>(context, listen: false)
              .requestToken(userModel.accessToken);

          // นำผู้ใช้ไปยังหน้าหลัก
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Login failed')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/TSU.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
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
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildUsernameField(),
                    _buildPasswordField(),
                    SizedBox(height: 20),
                    _buildSignUpLink(context),
                    SizedBox(height: 20),
                    _buildLoginButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.blueAccent),
          border: InputBorder.none,
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
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: const Color.fromARGB(255, 35, 2, 114),
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _login(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}
