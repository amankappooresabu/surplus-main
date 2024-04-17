import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surplus/login.dart';

void main() {
  runApp(SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 164, 201, 232), // Set background color to blue
        body: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    // Check if any field is empty and display message
    if (_nameController.text.isEmpty) {
      _showErrorSnackBar('Please enter your name.');
    } else if (_emailController.text.isEmpty) {
      _showErrorSnackBar('Please enter your email.');
    } else if (_phoneNumberController.text.isEmpty) {
      _showErrorSnackBar('Please enter your phone number.');
    } else if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('Please enter your password.');
    } else {
      // All fields are filled, proceed with signup
      String name = _nameController.text;
      String email = _emailController.text;
      String phoneNumber = _phoneNumberController.text;
      String password = _passwordController.text;

      // Sign up user with Firebase Authentication
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCredential) {
        // User created successfully, store additional details in Firestore
        String uid = userCredential.user!.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          // Add more fields as needed
        }).then((_) {
          // Clear text fields after successful signup
          _nameController.clear();
          _emailController.clear();
          _phoneNumberController.clear();
          _passwordController.clear();

          // Display a success message
          _showSuccessSnackBar('Signup successful!');

          // Navigate to login screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  LoginPage(), // Replace LoginScreen with your login screen widget
            ),
          );
        }).catchError((error) {
          // Handle errors while writing to Firestore
          _showErrorSnackBar('An error occurred. Please try again.');
        });
      }).catchError((error) {
        // Handle errors while creating user with Firebase Authentication
        _showErrorSnackBar(
            'Signup failed. Please check your credentials and try again.');
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Increase duration
    ));
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Increase duration
    ));
  }
}
