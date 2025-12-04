class ProfileResponseModel {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePhotoUrl;
  final String bio;
  final String defaultCity;
  final String phoneNumber;
  final String dateOfBirth;

  ProfileResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePhotoUrl,
    required this.bio,
    required this.defaultCity,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  ProfileResponseModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? profilePhotoUrl,
    String? bio,
    String? defaultCity,
    String? phoneNumber,
    String? dateOfBirth,
  }) => ProfileResponseModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    bio: bio ?? this.bio,
    defaultCity: defaultCity ?? this.defaultCity,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  );

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      ProfileResponseModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePhotoUrl: json["profilePhotoUrl"],
        bio: json["bio"],
        defaultCity: json["defaultCity"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "profilePhotoUrl": profilePhotoUrl,
    "bio": bio,
    "defaultCity": defaultCity,
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth,
  };
}
