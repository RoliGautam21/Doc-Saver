import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../screen/settings/settingpage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final Function onSerach;
  final TextEditingController controller;
  const CustomAppBar(
      {super.key, required this.controller, required this.onSerach});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: Container(
        color: indigo,
        child: Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Container(
                      height: 70,
                      child: Image.asset('assets/images/savelogo.png')),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
                          ));
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: white,
                    ))
              ],
            ),
            Container(
              // height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) {
                    onSerach();
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for document',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.arrow_forward),
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(190);
}
