class UserData {
  final String uid; // Can be a string representation of a numerical ID
  final String name;

  UserData({required this.uid, required this.name});

  factory UserData.fromMap(Map<String, dynamic> data) => UserData(
    uid: data['uid'].toString(), // Convert to string if necessary
    name: data['name'] as String,
  );
}
