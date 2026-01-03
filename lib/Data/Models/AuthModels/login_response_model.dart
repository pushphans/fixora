class LoginResponseModel {
  String accessToken;
  String refreshToken;
  String accountType;
  String accessTokenExpiresAt;
  String refreshTokenExpiresAt;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accountType,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });

  LoginResponseModel copyWith({
    String? accessToken,
    String? refreshToken,
    String? accountType,
    bool? isProfileInitiated,
    String? accessTokenExpiresAt,
    String? refreshTokenExpiresAt,
  }) => LoginResponseModel(
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    accountType: accountType ?? this.accountType,
    accessTokenExpiresAt: accessTokenExpiresAt ?? this.accessTokenExpiresAt,
    refreshTokenExpiresAt: refreshTokenExpiresAt ?? this.refreshTokenExpiresAt,
  );

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        accountType: json["accountType"],
        accessTokenExpiresAt: json["accessTokenExpiresAt"],
        refreshTokenExpiresAt: json["refreshTokenExpiresAt"],
      );

  Map<String, dynamic> toMap() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "accountType": accountType,
    "accessTokenExpiresAt": accessTokenExpiresAt,
    "refreshTokenExpiresAt": refreshTokenExpiresAt,
  };
}
