import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';
import '../../logic/k/provider/mprovider.dart';

class SettingPage extends StatelessWidget {
  static String routName = '/SettingPage';

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<MyProivder>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: white),
            backgroundColor: indigo,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.person, color: indigo),
                title: Text('profile'),
              ),
              ListTile(
                leading: IconButton(
                    onPressed: () {
                      provider.logout(context);
                    },
                    icon: Icon(Icons.login_outlined, color: indigo)),
                title: Text('logout'),
              )
            ],
          ),
        );
      }),
    );
  }
}
