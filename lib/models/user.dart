
class User {
  final String uid;
  final String? email;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? phoneNumber;
  final String? address;
  final String? postCode;

  User({
    required this.uid,
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.postCode,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      firstName: data['firstName'],
      middleName: data['middleName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      postCode: data['postCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
      'postCode': postCode,
    };
  }
}
