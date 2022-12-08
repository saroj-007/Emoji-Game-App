import 'dart:async';
import 'dart:developer';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:providerapp/controller/auths.dart';
import 'package:providerapp/login.dart';

class LogoutTimer {

  late Timer _timer;
  int second = 0;

  AuthServices au = AuthServices();

  void initializeTimer() {
     _timer = Timer.periodic(Duration(seconds: 1)
     , (timer) {
      startSecond();
        if (second == 25) {
        autoLogout();
        print("Successfully log out");
      }
      });
   
  }

  void startSecond() {
    second ++;
  }

  
  void autoLogout() {
    _timer.cancel();
   // au.logoutUser();
   Get.to(login());
  }

  // You'll probably want to wrap this function in a debounce
        
        void _handleUserInteraction([_]) {
            if (_timer != null && !_timer.isActive) {
              // This means the user has been logged out
              return;
            }
        
            _timer.cancel();
            initializeTimer();
          }
  
  
  
}