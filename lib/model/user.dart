class AppUser{
  String? uid;
  String? name;
  String? email;

  AppUser({this.email, this.name, this.uid});

  @override
  String toString() {
    return 'AppUser{uid: $uid, name: $name, email: $email}';
  }

  toMap(){
    return {
      uid: uid,
      name: name,
      email: email
    };
  }
}
