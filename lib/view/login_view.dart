import 'package:flutter/material.dart';
import 'package:mvvm_provider/res/components/round_button.dart';
import 'package:mvvm_provider/utils/Routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Now"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: "Enter Email",
                  prefixIcon: Icon(Icons.email)),
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    focusNode: passwordFocusNode,
                    controller: _passwordTextController,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Enter Password",
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: _obsecurePassword.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)),
                        prefixIcon: Icon(Icons.password)),
                  );
                }),
            SizedBox(
              height: height * .1,
            ),
            RoundButton(
                title: "Login Now",
                loading: authViewModel.loading,
                onPress: () {
                  if (_emailTextController.text.isEmpty) {
                    Utils.flushBarErrorMessages(
                        "Enter Email", 'Email', context);
                  } else if (_passwordTextController.text.length < 6) {
                    Utils.flushBarErrorMessages(
                        "Password must be more than 6 char",
                        'Password',
                        context);
                  } else if (_passwordTextController.text.isEmpty) {
                    Utils.flushBarErrorMessages(
                        "Enter Password", 'Password', context);
                  } else {
                    Map data = {
                      'email': _emailTextController.text.toString(),
                      'password': _passwordTextController.text.toString()
                    };
                    authViewModel.loginApi(data, context);
                  }
                }),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.signupRoute);
              },
              child: const Text("Don't have account Sign Up !"),
            )
          ],
        ),
      )),
    );
  }
}
