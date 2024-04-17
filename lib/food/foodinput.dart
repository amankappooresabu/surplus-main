import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surplus/food/fooddetails.dart';

class UserInputPage extends StatelessWidget {
  final foodNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final expiryDateController = TextEditingController();
  final kilogramController = TextEditingController();
  final imageController = TextEditingController(); // For food image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: foodNameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: expiryDateController,
              decoration:
                  InputDecoration(labelText: 'Expiry Date (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: kilogramController,
              decoration: InputDecoration(labelText: 'Kilogram'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Food Image URL'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Add data to Firestore
                await FirebaseFirestore.instance.collection('foods').add({
                  'food_name': foodNameController.text,
                  'description': descriptionController.text,
                  'expiry_date': expiryDateController.text,
                  'kilogram': kilogramController.text,
                  'image_url': imageController.text,
                });
                // Navigate back to previous screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FoodDetailsPage(foodId: '',)));
              },
              child: Text('Add Food'),
            ),
          ],
        ),
      ),
    );
  }
}
