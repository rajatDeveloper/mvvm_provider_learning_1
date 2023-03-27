import 'package:flutter/material.dart';
import 'package:mvvm_provider/utils/Routes/routes_name.dart';
import 'package:mvvm_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
        title: const Text("Sign-Up Now"),
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
                title: "Sign-Up Now",
                loading: authViewModel.signupLoading,
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
                    authViewModel.signUpApi(data, context);
                  }
                }),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.loginRoute);
              },
              child: const Text("have account Login !"),
            )
          ],
        ),
      )),
    );
  }
}
