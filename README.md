# flutter_notoficaton_test

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# run 순서입니다.
가장 중요한 것은 8,9,10 번과 13번 입니다.
GoogleService-info 의 API_KEY를 xcode에서 인식하고
파일 링크를 만들어 줘야 합니다.
단순히 파일을 카피해서 넣으면 xcode에서 API_KEY를 인식하지 못하는 경우가 있습니다.

1. github로 부터 Clone 또는 Download ZIP 으로 code를 준비합니다.
2. 준비한 code의 포로젝트 폴더로 이동 합니다. ex) flutter_notofication_test
3. vs-code의 터니널이나 mac의 터미널을 열기합니다.
4. flutter clean 을 실행합니다.
5. /ios/Podfile 와 /ios/Podfile.lock를 삭제합니다.
6. Finder을 실행합니다.
7. Finder에서 /ios/Runner.xcworkspace 를 열기합니다.
8. Xcode가 실행되면 왼쪽의 Runner/Runner에 GoogleService-Info 가 있는지 확인 합니다.
9. GoogleService-info를 선택하고 오른쪽에 CLIENT_ID, API_KEY등이 보이는지 확인합니다.
10. 8,9번이 확인 되지 않으면 Runner/Runner를 오른쪽 클릭하고 Add Files to "Runner"... 선택하고 GoogleService-Info.plist 파일을 선택해줍니다.
11. 터미널로 돌아옵니다.
12. cd ios 로 현재 위치를 /ios 로 변경합니다.
13. pod install 을 실행합니다.
14. cd .. 으로 프로젝트 폴더로 이동합니다.
15. flutter pub get 을 실행합니다.
16. flutter run 을 실행합니다. (시뮬레이터에 기기가 실행중이여야 합니다.)
17. 터미널에서 token 값을 확인 합니다.
