import 'dart:async';

import 'package:flutter/services.dart';

typedef void ErrorHandler(String message);


// TODO need to implement in IOS
class Phonecallstate {
  static const MethodChannel _channel =
      const MethodChannel('com.plusdt.phonecallstate');

  
  Function incomingHandler;
  Function dialingHandler;
  Function connectedHandler;
  Function disconnectedHandler;
  ErrorHandler errorHandler;


  Phonecallstate(){
    _channel.setMethodCallHandler(platformCallHandler);
  }

  Future<dynamic> setTestMode(double seconds) => _channel.invokeMethod('phoneTest.PhoneIncoming', seconds);

  void setIncomingHandler(Function callback) {
    incomingHandler = callback;
  }
  void setDialingHandler(Function callback) {
    dialingHandler = callback;
  }
  void setConnectedHandler(Function callback) {
    connectedHandler = callback;
  }
  void setDisconnectedHandler(Function callback) {
    disconnectedHandler = callback;
  }

  void setErrorHandler(ErrorHandler handler) {
    errorHandler = handler;
  }

  Future platformCallHandler(MethodCall call) async {
    print("_platformCallHandler call ${call.method} ${call.arguments}");
    switch (call.method) {
      case "phone.incoming":
        //print("incoming");
        if (incomingHandler != null) {
          print("number: "+ call.arguments);
          incomingHandler(call.arguments);
        }
        break;
      case "phone.dialing":
        //print("dialing");
        if (dialingHandler != null) {
          dialingHandler(call.arguments);
        }
        break;
      case "phone.connected":
        //print("connected");
        if (connectedHandler != null) {
          connectedHandler(call.arguments);
        }
        break;
      case "phone.disconnected":
        //print("disconnected");
        if (disconnectedHandler != null) {
          disconnectedHandler(call.arguments);
        }
        break;
      case "phone.onError":
        if (errorHandler != null) {
          errorHandler(call.arguments);
        }
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
  
  }
}
