import 'dart:convert';

class RegisterRequestModel {
  String phoneNumber;
  String email;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;
  String accountType;

  RegisterRequestModel({
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.accountType,
  });

  RegisterRequestModel copyWith({
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? confirmPassword,
    String? accountType,
  }) => RegisterRequestModel(
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    accountType: accountType ?? this.accountType,
  );

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        phoneNumber: json["phoneNumber"] as String,
        email: json["email"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        password: json["password"] as String,
        confirmPassword: json["confirmPassword"] as String,
        accountType: json["accountType"] as String,
      );

  Map<String, dynamic> toMap() => {
    "phoneNumber": phoneNumber,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "confirmPassword": confirmPassword,
    "accountType": accountType,
  };
}
