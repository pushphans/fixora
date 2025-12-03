class RegisterRequestModel {
  String username;
  String email;
  String password;
  String confirmPassword;
  String accountType;

  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.accountType,
  });

  RegisterRequestModel copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? accountType,
  }) => RegisterRequestModel(
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    accountType: accountType ?? this.accountType,
  );

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        accountType: json["accountType"],
      );

  Map<String, dynamic> toMap() => {
    "username": username,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "accountType": accountType,
  };
}
