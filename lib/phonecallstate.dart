import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import 'package:permission_handler/permission_handler.dart';

typedef void ErrorHandler(String? message);

// TODO need to implement in IOS
class PhoneCallState {
  static const MethodChannel _channel = const MethodChannel('com.plusdt.phonecallstate');

  Function? incomingHandler;
  Function? dialingHandler;
  Function? connectedHandler;
  Function? disconnectedHandler;
  ErrorHandler? errorHandler;

  Future<PhoneCallState> Instance() async {
    _channel.setMethodCallHandler(platformCallHandler);

    developer.log('Phone init permission: ${await Permission.phone.status}', name: 'PSC');
    if (await Permission.phone.request().isGranted) {
      developer.log('Phone requested permission: ${await Permission.phone.status}', name: 'PSC');
    }

    return this;
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
    switch (call.method) {
      case 'phone.incoming':
        developer.log('PhoneCallState: incoming. ${call.method} ${call.arguments}', name: 'PSC');
        if (incomingHandler != null) {
          incomingHandler!(call.arguments);
        }
        break;
      case 'phone.dialing':
        developer.log('PhoneCallState: dialing. ${call.method} ${call.arguments}', name: 'PSC');
        if (dialingHandler != null) {
          dialingHandler!(call.arguments);
        }
        break;
      case 'phone.connected':
        developer.log('PhoneCallState: connected. ${call.method} ${call.arguments}', name: 'PSC');
        if (connectedHandler != null) {
          connectedHandler!(call.arguments);
        }
        break;
      case 'phone.disconnected':
        developer.log('PhoneCallState: disconnected. ${call.method} ${call.arguments}', name: 'PSC');
        if (disconnectedHandler != null) {
          disconnectedHandler!(call.arguments);
        }
        break;
      case 'phone.onError':
        developer.log('PhoneCallState: error. ${call.method} ${call.arguments}', name: 'PSC');
        if (errorHandler != null) {
          errorHandler!(call.arguments);
        }
        break;
      default:
        developer.log('PhoneCallState: Unknowm method ${call.method} ', name: 'PSC');
    }
  }
}
