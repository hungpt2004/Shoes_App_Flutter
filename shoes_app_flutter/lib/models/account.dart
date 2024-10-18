class Account {
  int? accountId; // Biến có thể null
  late String email;
  late String password;
  late String cmnd;
  late String name;
  late String gender;
  late DateTime dateOfBirth;
  late String phoneNumber;
  late String avatarUrl;
  late String address;
  late int role;
  late int status;

  // Constructor cho tài khoản với đầy đủ thông tin
  Account({
    this.accountId, // Có thể null, không cần thiết phải nhập
    required this.email,
    required this.password,
    required this.cmnd,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.address,
    required this.role,
    required this.status,
  });

  // Constructor cho việc đăng nhập
  Account.signin({
    required this.email,
    required this.password,
    required this.name,
    this.cmnd = '',
    this.gender = '',
    DateTime? dateOfBirth, // Nhận giá trị từ bên ngoài
    this.phoneNumber = '',
    this.avatarUrl = "https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg",
    this.address = '',
    this.role = 1,
    this.status = 1,
  }) : dateOfBirth = dateOfBirth ?? DateTime(1999, 1, 1); // Gán giá trị mặc định

  // Phương thức chuyển đổi đối tượng thành Map
  Map<String, dynamic> toMap() {
    return {
      'Email': email,
      'Password': password,
      'CMND': cmnd,
      'Name': name,
      'Gender': gender,
      'DateOfBirth': dateOfBirth.toIso8601String(),
      'PhoneNumber': phoneNumber,
      'AvatarURL': avatarUrl,
      'Address': address,
      'Role': role,
      'Status': status,
    };
  }

  // Phương thức tạo đối tượng từ Map
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      accountId: map['Account_ID'], // Trường này sẽ được gán sau khi tạo
      email: map['Email'],
      password: map['Password'],
      cmnd: map['CMND'],
      name: map['Name'],
      gender: map['Gender'],
      dateOfBirth: DateTime.parse(map['DateOfBirth']),
      phoneNumber: map['PhoneNumber'],
      avatarUrl: map['AvatarURL'],
      address: map['Address'],
      role: map['Role'],
      status: map['Status'],
    );
  }
}
