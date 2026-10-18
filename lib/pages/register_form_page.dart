import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  State<RegisterFormPage> createState() {
    return _RegisterFormPage();
  }
}

class _RegisterFormPage extends State<RegisterFormPage> {
  bool _hidePass = true;
  bool _hideCon = true;

  final _name = TextEditingController();
  final _number = TextEditingController();
  final _email = TextEditingController();
  final _story = TextEditingController();
  final _pass = TextEditingController();
  final _con = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _number.dispose();
    _email.dispose();
    _story.dispose();
    _pass.dispose();
    _con.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("form is valid");
      print("Name: ${_name.text}");
      print("Number: ${_number.text}");
      print("Email: ${_email.text}");
      print("Story: ${_story.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight(600)),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Full Name*',
                hintText: 'Whats you name?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  onPressed: () {
                    _name.clear();
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (val) {
                return _validateName(val ?? '');
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _number,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Phone Number*',
                hintText: 'Whats your number?',
                helperText: 'Phone Format: +7 (XXX)XXX XXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: IconButton(
                  onPressed: () {
                    _number.clear();
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (val) {
                return _validatePhone(val ?? '');
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter Email address',
                icon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _story,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell Us About Yourself',
                helperText: 'Write It Simple',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _pass,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password*',
                hintText: 'Enter The Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: Icon(
                    _hidePass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                icon: Icon(Icons.security),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Password is required';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _con,
              obscureText: _hideCon,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password*',
                hintText: 'Confirm The Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hideCon = !_hideCon;
                    });
                  },
                  icon: Icon(
                    _hideCon ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                icon: Icon(Icons.border_color),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please confirm your password';
                } else if (val != _pass.text) {
                  return 'Passwords do not match';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Submit Form', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z]+$');
    if (value.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please try again';
    } else {
      return null;
    }
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 11) {
      return 'Phone number must contain 11 digits';
    } else {
      return null;
    }
  }
}
