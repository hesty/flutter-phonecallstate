# phonecallstate

Flutter plugin to receive Phone Call State for both iOS and Android.

Update:
- Modified pubspec.yaml file to Dart2+
- Named version as 1.0.2


```
enum PhonecallState { incoming, dialing, connected, disconnected, none }
enum PhonecallStateError { notimplementedyet  }

...
  Phonecallstate  phonecallstate;
  PhonecallState phonecallstatus;
  
...
  Future<CallService> init() async {
    phonecallstate = await PhoneCallState().Instance();
    phonecallstatus = PhonecallState.none;


    phonecallstate.setIncomingHandler((number) {
      setState(() {
        phonecallstatus = PhonecallState.incoming;
        phonecallstatuslog =  phonecallstatuslog.toString() + PhonecallState.incoming.toString()+"\n";
      });
    });

    phonecallstate.setDialingHandler((number) {
      setState(() {
        phonecallstatus = PhonecallState.dialing;
        phonecallstatuslog =  phonecallstatuslog.toString() + PhonecallState.dialing.toString()+"\n";
      });
    });

    phonecallstate.setConnectedHandler((number) {
      setState(() {
        phonecallstatus = PhonecallState.connected;
        phonecallstatuslog =  phonecallstatuslog.toString() + PhonecallState.connected.toString()+"\n";
      });
    });

    phonecallstate.setDisconnectedHandler((number) {
      setState(() {
        phonecallstatus = PhonecallState.disconnected;
        phonecallstatuslog =  phonecallstatuslog.toString() + PhonecallState.disconnected.toString()+"\n";
      });
    });

    phonecallstate.setErrorHandler((msg) {
          print('Call Error: $msg');
    });
   }


    ```
