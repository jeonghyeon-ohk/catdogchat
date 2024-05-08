import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isInputValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              _EmailTextField(
                controller: emailController,
                onChanged: (_) => _checkInput(),
              ),
              SizedBox(height: 20.0),
              _PasswordTextField(
                controller: passwordController,
                onChanged: (_) => _checkInput(),
              ),
              SizedBox(height: 20.0),
              _LoginButton(
                onPressed: _isInputValid
                    ? () {
                        Navigator.of(context).pushNamed(
                          '/',
                        );
                      }
                    : null,
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/join',
                      );
                    },
                    child: Text('회원가입'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkInput() {
    setState(() {
      _isInputValid =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }
}

class _EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const _EmailTextField({
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: '이메일',
        hintText: '이메일을 입력하세요',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const _PasswordTextField({
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: true,
      decoration: InputDecoration(
        labelText: '비밀번호',
        hintText: '비밀번호를 입력하세요',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _LoginButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? Color(0xFFD0BE9F) : Colors.grey,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        '로그인',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
