import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _Id(),
            SizedBox(height: 20.0),
            _Password(),
            SizedBox(height: 20.0),
            _PasswordAgain(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/',
                );
                /// 메인 페이지로 이동
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
class _Id extends StatelessWidget {
  const _Id({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: '아이디',
              hintText: '아이디',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
class _Password extends StatefulWidget {
  const _Password({Key? key});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<_Password> {
  TextEditingController _passwordController = TextEditingController();
  bool _isValid = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _isValid = _validatePassword(value);
              });
            },
            decoration: InputDecoration(
              labelText: '비밀번호',
              hintText: '비밀번호 (영문, 숫자 조합 8~20자리)',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: _isValid ? Colors.grey : Colors.red, // 테두리 색상 변경
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        if (!_isValid)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: Text(
              '영문, 숫자 조합 8~20자리를 입력해주세요',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  bool _validatePassword(String value) {
    // 비밀번호 유효성 검사를 수행하는 함수
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
class _PasswordAgain extends StatefulWidget {
  const _PasswordAgain({Key? key});

  @override
  _PasswordAgainState createState() => _PasswordAgainState();
}

class _PasswordAgainState extends State<_PasswordAgain> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isValid = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _isValid = _validatePasswordMatch(
                    _passwordController.text, value);
              });
            },
            decoration: InputDecoration(
              hintText: '비밀번호 재입력',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: _isValid ? Colors.grey : Colors.red, // 테두리 색상 변경
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        if (!_isValid)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0),
            child: Text(
              '동일한 비밀번호를 입력해주세요',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  bool _validatePasswordMatch(String password, String confirmPassword) {
    // 비밀번호와 재입력한 비밀번호가 일치하는지 확인하는 함수
    bool isValid = password == confirmPassword;
    if (isValid) {
      // 비밀번호가 일치하면 문구를 숨김
      _isValid = true;
    }
    return isValid;
  }
}

