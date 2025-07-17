class ContactModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  DateTime? dateCreated;

  ContactModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.dateCreated
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    profilePicture: json['profilePicture'] as String,
    dateCreated: DateTime.parse(json['dateCreated']),
  );
}