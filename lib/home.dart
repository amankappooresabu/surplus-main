import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:surplus/chat_main.dart';
import 'package:surplus/chatscreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          // Greeting section and search bar with padding at the top
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 20.0), // Adjust padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting section
                Row(
                  children: [
                    SizedBox(height: 70.0),
                    Text(
                      'Welcome back,',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300, // Light font weight
                      ),
                    ),
                    SizedBox(width: 5.0), // Add some space between texts
                    Text(
                      'User',
                      style: TextStyle(
                        fontSize: 20.0, // Increased font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Add space between greeting and search bar
                // Curved search bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 50.0, // Adjust search bar height
                    width: MediaQuery.of(context).size.width -
                        40.0, // Adjust width
                    color: Colors.grey[200], // Light grey background
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for items...',
                        border: InputBorder.none, // Remove default border
                        contentPadding: EdgeInsets.only(
                          left: 15.0,
                          top: 10.0,
                        ), // Adjust padding
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container with green gradient background below search bar
          Positioned(
            top: 170.0, // Adjust bottom padding as needed
            left: 20.0, // Adjust left padding as needed
            right: 20.0, // Adjust right padding (optional)
            child: Container(
              height: 200.0, // Adjust container height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.green[400]!, // Lighter green
                    Colors.green[700]!, // Darker green
                  ],
                ),
              ),
              // Add your content here (optional)
            ),
          ),
          Positioned(
            top: 210.0, // Adjust button position from bottom
            left: 40.0, // Adjust button position from left (optional)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Give back,',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  'change lives now!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 290.0, // Adjust button position from bottom
            left: 40.0, // Adjust button position from left (optional)
            child: ElevatedButton(
              onPressed: () {
                // Handle button press action
              },
              child: Text(
                "Share now",
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // Set text color to black
                elevation: 3, // Add a bit of shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minimumSize: Size(100.0, 30.0), // Set desired width and height
              ),
            ),
          ),
          SizedBox(height: 20), // Heading "Categories"
          Positioned(
            top: 380.0, // Adjust top padding as needed
            left: 20.0, // Adjust left padding as needed
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Row with three buttons
          Positioned(
            top: 420.0, // Adjust top padding as needed
            left: 20.0, // Adjust left padding as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => EventsPage()),
                    // );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(
                        3), // Add a bit of shadow
                  ),
                  child: Text(
                    'Food',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 20), // Add space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyWidget()),
                    // );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStateProperty.all<double>(
                        3), // Add a bit of shadow
                  ),
                  child: Text(
                    'Non-food',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRect(
        child: Container(
          height: 60.0, // Adjust the height as needed
          child: BottomAppBar(
            shape:
                CircularNotchedRectangle(), // Rounded shape for the bottom app bar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    // Navigate to home page
                  },
                  icon: Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    // Navigate to search page
                  },
                  icon: Icon(Icons.search),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // Green circle
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Add action for plus button
                    },
                    icon: Icon(Icons.add),
                    color: Colors.white, // White plus icon
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(UserListScreen());
                  },
                  icon: Icon(Icons.message),
                ),
                IconButton(
                  onPressed: () {
                    // Navigate to user profile page
                  },
                  icon: Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
