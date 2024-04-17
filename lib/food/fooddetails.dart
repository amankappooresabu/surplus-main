import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodDetailsPage extends StatelessWidget {
  final String foodId;

  FoodDetailsPage({required this.foodId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('foods')
            .doc(foodId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Food not found.'));
          }

          final foodData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  foodData['food_name'],
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                if (foodData['image_url'] != null)
                  Image.network(
                    foodData['image_url'],
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 20.0),
                Text('Description: ${foodData['description']}'),
                SizedBox(height: 10.0),
                Text('Expiry Date: ${foodData['expiry_date']}'),
                SizedBox(height: 10.0),
                Text('Kilogram: ${foodData['kilogram']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
