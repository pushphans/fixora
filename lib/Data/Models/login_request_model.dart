class LoginRequestModel {
  String username;
  String password;
  String deviceId;

  LoginRequestModel({
    required this.username,
    required this.password,
    required this.deviceId,
  });

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(
        username: json["username"],
        password: json["password"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
    "deviceId": deviceId,
  };
}
