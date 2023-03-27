import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider/repository/auth_repository.dart';
import 'package:mvvm_provider/utils/Routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signupLoading = false;
  bool get signupLoading => _loading;

  setSignupLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo
        .loginApi(data)
        .then((value) => {
              setLoading(false),
              Utils.toastMessage("Login Successfully !"),
              Navigator.pushNamed(context, RoutesName.homeRoute)
            })
        .onError((error, stackTrace) => {
              setLoading(false),
              Utils.flushBarErrorMessages(error.toString(), 'Error', context),
            });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    _myRepo
        .registerApi(data)
        .then((value) => {
              setSignupLoading(false),
              Utils.toastMessage("Account Created Successfully !"),
              Navigator.pushNamed(context, RoutesName.loginRoute),
              print(value.toString())
            })
        .onError((error, stackTrace) => {
              setSignupLoading(false),
              Utils.flushBarErrorMessages(error.toString(), 'Error', context),
            });
  }
}
