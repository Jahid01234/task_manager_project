import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/data/models/network_response.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/utilities/urls.dart';
import 'package:task_manager_project/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager_project/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';
import 'package:task_manager_project/ui/widgets/background_widget.dart';
import 'package:task_manager_project/ui/widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  bool _pinVerificationInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Pin Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "A 6 digits verification pin has been sent to your email address.",
                    style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 25),
                  // Pin Text Field
                  _buildPinCodeTextField(),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: _pinVerificationInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapVerifyOtpButton,
                      child: const Text("Verify"),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildSignInSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Have an account? ",
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            //letterSpacing:
          ),
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                    _onTapSignInButton();
                },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColors.themeColor,
        inactiveColor: Colors.cyan
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _pinTEController,
      keyboardType: TextInputType.number,
      appContext: context,
    );
  }

  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen(),
      ),
    );
  }


  void _onTapVerifyOtpButton() {
    _pinVerification();
  }

  Future<void> _pinVerification() async {
    _pinVerificationInProgress = true;
    if(mounted){
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(

      Urls.recoverVerifyOTP( widget.email, _pinTEController.text),
    );

    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ResetPasswordScreen(
          email:widget.email ,
          otp:_pinTEController.text,
        ),
        ),
      );
    } else {
      if(mounted){
        showSnackBarMessage(context, response.errorMessage ?? 'Failed to send verification pin.');
      }
    }
    _pinVerificationInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pinTEController.dispose();
  }
}
