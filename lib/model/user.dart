class AppUser{
  String? uid;
  String? name;
  String? email;
  bool? isAdmin=false;

  AppUser({this.email, this.name, this.uid,this.isAdmin});

  @override
  String toString() {
    return 'AppUser{uid: $uid, name: $name, email: $email, "isAdmin": $isAdmin}';
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "isAdmin": isAdmin
    };
  }
}
