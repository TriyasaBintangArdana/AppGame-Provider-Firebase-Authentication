class LoginBody {
  String? username;
  String? password;

  LoginBody({
    this.username,this.password
  });
  Map<String,dynamic> toMap() => {"username" : username,"password":password};
}