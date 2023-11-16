class Users {
  /*
  This class encapsulates the json response from the api
  {
      'userId': '1908789',
      'username': username,
      'name': 'Peter Clarke',
      'lastLogin': "23 March 2020 03:34 PM",
      'email': 'x7uytx@mundanecode.com'
  }
  */
  //String _userId = '';
  //String _name = '';
  //String _username = '';
  String _access_token = '';
  String _userEmail = '';

  // Properties
  //String get userId => _userId;
  //set userId(String userId) => _userId = userId;

  // String get username => _username;
  // set username(String username) => _username = username;
  //
  // String get name => _name;
  // set name(String name) => _name = name;

  String get access_token => _access_token;
  set access_token(String access_token) => _access_token = access_token;

  String get userEmail => _userEmail;
  set userDetail(String userEmail) => _userEmail = userEmail;

// create the user object from json input
  Users.fromJson(Map<String, dynamic> json) {
    // _userId = json['userId'];
    // _username = json['username'];
    // _name = json['name'];
    _access_token = json['access_token'];
    _userEmail = json['email'];
  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['userId'] = this._userId;
    // data['username'] = this._username;
    // data['name'] = this._name;
    data['access_token'] = this._access_token;
    data['email'] = this._userEmail;
    return data;
  }
}