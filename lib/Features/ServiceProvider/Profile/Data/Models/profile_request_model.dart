class ProfileRequestModel {
  final String firstName;
  final String lastName;
  final String bio;
  final String defaultCity;
  final String phoneNumber;
  final String dateOfBirth;

  ProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.defaultCity,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  ProfileRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? bio,
    String? defaultCity,
    String? phoneNumber,
    String? dateOfBirth,
  }) => ProfileRequestModel(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    bio: bio ?? this.bio,
    defaultCity: defaultCity ?? this.defaultCity,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  );

  factory ProfileRequestModel.fromMap(Map<String, dynamic> json) =>
      ProfileRequestModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        bio: json["bio"],
        defaultCity: json["defaultCity"],
        phoneNumber: json["phoneNumber"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toMap() => {
    "firstName": firstName,
    "lastName": lastName,
    "bio": bio,
    "defaultCity": defaultCity,
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth,
  };
}
