import 'package:cloud_firestore/cloud_firestore.dart';

class skica {
  final String? name;
  final String? bio;
  final String? image;

  skica({this.name, this.bio, this.image});

  Map<String, dynamic> toJson() => {
        'name': name,
        'bio': bio,
        'image': image,
      };

  skica.fromSnapshot(snapshot)
      : name = snapshot.data()['name'] ?? '',
        bio = snapshot.data()['bio'] ?? '',
        image = snapshot.data()['image'] ?? '';
}
