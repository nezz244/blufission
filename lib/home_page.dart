
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;

  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceInfo.androidInfo;
  }

  Widget showCard(String name, String value) {
    return Card(
        child: ListTile(
          title: Text(
            "$name : $value",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) =>
      Scaffold(


          appBar: AppBar(
            title: const Text('Home'),

          ),
          body: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Column(
                        children: [
                          SafeArea(
                              child: FutureBuilder<AndroidDeviceInfo>(
                                  future: getInfo(),
                                  builder: (context, snapshot) {
                                    final data = snapshot.data!;

                                    return Column(
                                        children: [
                                          showCard('brand', data.brand),
                                            showCard('device name', data.device),
                                              showCard('model', data.model),
                                              showCard('manufacturer', data.manufacturer),
                                            showCard('product', data.product),


                                          SizedBox(height: 40),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size
                                                  .fromHeight(50),
                                            ),
                                            icon: const Icon(Icons.arrow_back,
                                                size: 32),
                                            label: const Text(
                                              'Sign Out',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            onPressed: () =>
                                                FirebaseAuth.instance.signOut(),

                                          ),
                                        ]
                                    );
                                  }
                              )
                          )
                        ]

                    ),
                  ]
              )
          )

      );


}
