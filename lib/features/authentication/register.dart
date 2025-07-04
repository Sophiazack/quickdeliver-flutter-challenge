import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quick_deliver/features/authentication/signin.dart';
import 'package:quick_deliver/theme/text_style.dart';
import 'package:quick_deliver/theme/theme.dart';
import 'package:quick_deliver/services.dart/auth_service.dart' show AuthService;
import 'package:reactive_forms/reactive_forms.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
  });
  bool showPassword = true;
  String errorMessage ='';

 Future<void> signUpWithEmailAndPassword(context)async{
  try{
   await AuthService().signUp(form.control('email').value, form.control('password').value, context);
  showOrderConfirmationDialog(context: context);
  }on FirebaseAuthException catch(e){
    
    setState(() {
      errorMessage = e.message!;
    });

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReactiveForm(
                formGroup: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                        shadowColor: AppTheme.primary,
                        color: AppTheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                              'Enter your details to sign up.',
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
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            CupertinoIcons.mail,
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: AppTheme.themeData().textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validationMessages: {
                        'required': (error) => 'The email must not be empty',
                        'email': (error) => 'The email must be a valid lastname'
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
                                   CupertinoIcons.eye_slash,
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
                                    Icons.remove_red_eye_outlined
                                  ),
                                ),
                              ),
                        hintText: 'Password',
                        hintStyle: AppTheme.themeData().textTheme.bodyMedium,
                        border: OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validationMessages: {
                        'required': (error) => 'The password must not be empty',
                        'password': (error) =>
                            'The password must be a valid email'
                      },
                    ),
                    const SizedBox(height: 30),
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return GestureDetector(
                          onTap: () {
                            form.valid ? signUpWithEmailAndPassword(context): ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                            content: Text("Complate the form"),
                          backgroundColor: Colors.red,
                             duration: Duration(seconds: 3),
                                   ),
                              );
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
                                  'Register',
                                  style: bodyMedium(color: Colors.white),
                                ),
                              )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: AppTheme.themeData().textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Login ',
                                  style: bodyMedium(color: AppTheme.primary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn())),)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


Future<bool?> showOrderConfirmationDialog({
  required BuildContext context,
}) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Sucessfully SignUp'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Go back to sign into your account')
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: ()  => Navigator.pushReplacement(
                context,
                  MaterialPageRoute(
                    builder: (context) =>
                       const SignIn())),
            child: const Text('Login'),
          ),
        ],
      );
    },
  );
}
