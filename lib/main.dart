import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//이 소스로 테스트를 해보시고 만약 실기기에서 토큰값을 가져온다면 아래의 문제로 예상됩니다.
//토큰값을 가져오기 위해서는 권한승인이 필요합니다. 
//권한은 앱이 처음 실행될 때 물어보고 이 때 승인을 누릅니다.
//그러나, 내부적으로 getToken()으로 가져오는 타이밍에서는 이 승인 값이 업데이트가 안된 타이밍인 것 같습니다.
//그러면 왜,시뮬레이터에서는 토큰값이 찍히냐면 시뮬레이터에서는 fcm을 받기 힘들기 때문에 권한승인을 무시하고 토큰값을 발행해 주는 것 같습니다.
//그러므로 아래와 같은 방법으로 해결 된 것으로 생각합니다.
//방법은 requestPermission()을 해준 후에 곧바로 getToken()을 하는 것이 아니라 FirebaseMessaging.instance.getNotificationSettings()로 상태를 가져오는 것입니다.
//FirebaseMessaging.instance.getNotificationSettings()는 FirebaseMessaging에서 제공하는 기능 중 하나로 현재 앱에 알림 권한 및 설정 상태를 가져오는 역할을 합니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = 'Waiting for token...';
  AuthorizationStatus _authorizationStatus = AuthorizationStatus.notDetermined;

  @override
  void initState() {
    super.initState();
    _checkPermissionAndToken();
  }

  Future<void> _checkPermissionAndToken() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

//이 부분에서 getNotificationSettings()으로 가져오지 않으면 settings의 결과가 계속 notDetermind로 남게됩니다.
//아마도 화면상에서 권한을 승인해도 다시 getNotificationSettings()을 통해서 값을 가져오지 않으면 업데이트가 되지앟은 듯합니다.
    var settings = await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      _authorizationStatus = settings.authorizationStatus;

    });

    if (_authorizationStatus == AuthorizationStatus.authorized) {
      await _getToken();
    }
  }

  Future<void> _getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _token = token!;
    });
    print('FCM Token: $_token');
  }

  void _refreshAuthorizationStatus() async {
    var settings = await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      _authorizationStatus = settings.authorizationStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Permission and Token Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('FCM Permission and Token Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Authorization Status:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                _authorizationStatus.toString(),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'FCM Token:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                _token,
                style: TextStyle(fontSize: 16),
              ),
  
             
            ],
          ),
        ),
      ),
    );
  }
}