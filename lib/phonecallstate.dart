import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:developer' as developer;

typedef void ErrorHandler(String message);

// TODO need to implement in IOS
class Phonecallstate {
  static const MethodChannel _channel = const MethodChannel('com.plusdt.phonecallstate');

  Function incomingHandler;
  Function dialingHandler;
  Function connectedHandler;
  Function disconnectedHandler;
  ErrorHandler errorHandler;

  Phonecallstate() {
    _channel.setMethodCallHandler(platformCallHandler);
  }

  Future<dynamic> setTestMode(double seconds) =>
      _channel.invokeMethod('phoneTest.PhoneIncoming', seconds);

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
    developer.log('_platformCallHandler call ${call.method} ${call.arguments}');

    switch (call.method) {
      case 'phone.incoming':
        developer.log('PhoneCallState: incoming');
        if (incomingHandler != null) {
          incomingHandler(call.arguments);
        }
        break;
      case 'phone.dialing':
        developer.log('PhoneCallState: dialing');
        if (dialingHandler != null) {
          dialingHandler(call.arguments);
        }
        break;
      case 'phone.connected':
        developer.log('PhoneCallState: connected');
        if (connectedHandler != null) {
          connectedHandler(call.arguments);
        }
        break;
      case 'phone.disconnected':
        developer.log('PhoneCallState: disconnected');
        if (disconnectedHandler != null) {
          disconnectedHandler(call.arguments);
        }
        break;
      case 'phone.onError':
        developer.log('PhoneCallState: error');
        if (errorHandler != null) {
          errorHandler(call.arguments);
        }
        break;
      default:
        developer.log('PhoneCallState: Unknowm method ${call.method} ');
    }
  }
}
