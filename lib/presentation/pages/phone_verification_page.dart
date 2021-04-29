
import 'package:t_amo/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:t_amo/presentation/pages/set_initial_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:t_amo/presentation/widgets/theme/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
class PhoneVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationPage({Key key, this.phoneNumber}) : super(key: key);

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  int _counter = 10;
  Timer _timer;
  String get _phoneNumber => widget.phoneNumber;
  TextEditingController _pinCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(""),
              Text("Verify your phone number",
                style: TextStyle(
                    fontSize: 20,
                    color: greenColor,
                    fontWeight: FontWeight.w500
                ),
              ),
              Icon(Icons.more_vert)
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text("TAmo will send an SMS message to verify your phone number (carrier charges may apply).",
            style: TextStyle(fontSize: 14,),
          ),
          _pinCodeWidget(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: greenColor,
                onPressed: _submitSmsCode,
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
    );
  }

  Widget _pinCodeWidget() {

    return Container(
      margin: EdgeInsets.symmetric(horizontal:30),
      child: Column(
        children: <Widget>[
          Text("\n"),
          Text("Start timer to enter code",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 15
              )),
          Text("\n"),

          Text(
            '$_counter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 48,
            ),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            color: Colors.greenAccent,
            onPressed: () => _startTimer(),
            child: Text("Start 10 second counter"),
          ),
          (_counter > 0)
              ? Text("")
              :PinCodeTextField(
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            obscureText: true,
            autoDisposeControllers: false,
            onChanged: (pinCode){
              print(pinCode);
            },
          ),
          Text("Enter 6 Digit code"),

        ],
      ),
    );
  }
  @override
  void _submitSmsCode(){
    if (_pinCodeController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitSmsCode(smsCode: _pinCodeController.text);
    }
  }
  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
}
