import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/views/registerpage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth, ctrwidth, ctrheight;
  bool passwordVisible = true;
  bool remember = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800){
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth <800){
      ctrwidth = screenWidth;
    } 
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: ctrwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: screenHeight / 2.5,
                        width: screenWidth,
                        child: Image.asset('assets/images/mytutor logo.png')),
                    const Text(
                      "Login",
                      style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return ' Please enter valid email';
                            }
                            return null;
                          },
                        ),
                    ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              )),                              
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'Please enter your password';
                                }
                                if(value.length <6){
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                      ),
                      Row(
                        children:[
                          Checkbox(
                            value: remember,
                            onChanged: (bool? value){
                              _onRememberMe(value!);
                            },
                            ),
                            const Text("Remember Me",
                            style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                          ),
                        Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: ElevatedButton(
                          child: const Text("Login",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                          ),
                          onPressed: _showMessage,)
                      )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) =>
                                          RegisterPage()))
                            },
                            child: const Text(
                              "Not a Member?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }            
void _showMessage(){
  Fluttertoast.showToast(
            msg: "Login Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
}

  void _onRememberMe(bool bool) {
    Fluttertoast.showToast(
            msg: "Remember Me Enabled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
}
  }
