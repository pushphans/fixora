class ProfileResponseModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? profilePhotoUrl;
  final String? bio;
  final String? defaultCity;
  final String? phoneNumber;
  final String? dateOfBirth;

  ProfileResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePhotoUrl,
    this.bio,
    this.defaultCity,
    this.phoneNumber,
    this.dateOfBirth,
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

  factory ProfileResponseModel.fromMap(Map<String, dynamic> json) {
    return ProfileResponseModel(
      id: json["id"] as String?,
      firstName: json["firstName"] as String?,
      lastName: json["lastName"] as String?,
      profilePhotoUrl: json["profilePhotoUrl"] as String?,
      bio: json["bio"] as String?,
      defaultCity: json["defaultCity"] as String?,
      phoneNumber: json["phoneNumber"] as String?,
      dateOfBirth: json["dateOfBirth"] as String?,
    );
  }

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
