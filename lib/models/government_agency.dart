class GovernmentAgency {
  final String code;
  final String title;
  final String link;
  final String tel;
  final String email;
  final String address;

  GovernmentAgency({
    required this.code,
    required this.title,
    required this.link,
    required this.tel,
    required this.email,
    required this.address,
  });

  factory GovernmentAgency.fromJson(Map<String, dynamic> json) {
  return GovernmentAgency(
    code: json['code'] ?? '',
    title: json['title'] ?? '',
    link: json['link'] ?? '',
    tel: json['tel'] ?? '',
    email: json['email'] ?? '',
    address: json['adres'] ?? '', 
  );
}

}