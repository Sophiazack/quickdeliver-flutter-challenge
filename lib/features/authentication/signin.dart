import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quick_deliver/features/authentication/register.dart';
import 'package:quick_deliver/theme/text_style.dart';
import 'package:quick_deliver/theme/theme.dart';
import 'package:quick_deliver/services.dart/auth_service.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
String errorMessage = '';
bool isLogin = true;

User? user = AuthService().currentUser;



  final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
  });
  bool isCheck = false;
  bool showPassword = true;

  Future<void> signInWithEmailAndPassword(context)async{
  try{
   await AuthService().signIn(form.control('email').value, form.control('password').value, context);
    
  }on FirebaseAuthException catch(e){
    setState(() {
      errorMessage = e.message!;
    });

  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView(
          children: [
            ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(errorMessage),
                  Align(
                    alignment: Alignment.center,
                    child: Card(
                      shadowColor: AppTheme.primary,
                      color: AppTheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: SvgPicture.asset('images/logo.svg'),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Hello Again!",
                            style: AppTheme.themeData().textTheme.titleLarge,
                          ),
                          const Text(
                            'Enter your details to sign into you account.',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: AppTheme.themeData().textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReactiveTextField(
                    formControlName: 'email',
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                        Icons.mail_outline
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      hintText: 'example@gmail.com',
                      hintStyle: AppTheme.themeData().textTheme.bodyMedium,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validationMessages: {
                      'required': (error) =>
                          'The email number must not be empty',
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: AppTheme.themeData().textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReactiveTextField(
                    formControlName: 'password',
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.key
                        ),
                      ),
                      suffixIcon: showPassword == true
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPassword = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove_red_eye_outlined
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPassword = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                 CupertinoIcons.eye_slash
                                ),
                              ),
                            ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      hintText: 'Create password',
                      hintStyle: AppTheme.themeData().textTheme.bodyMedium,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validationMessages: {
                      'required': (error) => 'The password must not be empty',
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: isCheck,
                              onChanged: (val) {
                                setState(() {
                                  isCheck = val!;
                                });
                              }),
                          const Text('Remember me')
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text('Forgot password?'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                     
                      return GestureDetector(
                        onTap: () {
                         form.valid ? signInWithEmailAndPassword(context) : ScaffoldMessenger(child: Text('Sorry Try again'));

                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppTheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: bodyMedium(color: Colors.white),
                              ),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
           
            const SizedBox(
              height: 20,
            ),
            
            const SizedBox(
              height: 20,
            ),
           
            const SizedBox(
              height: 40,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: AppTheme.themeData().textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Register',
                          style: bodyMedium(color: AppTheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()  => Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
                            )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
