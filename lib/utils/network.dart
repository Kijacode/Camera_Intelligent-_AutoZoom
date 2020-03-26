import 'package:connectivity/connectivity.dart';

class Utils {
  //method to initialize network connection of the phone
  Future<bool> connection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network. or I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }
}
