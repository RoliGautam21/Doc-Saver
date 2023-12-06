import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../model/fileCardModel.dart';

class FileCard extends StatelessWidget {
  final FileCardModel filecard;
  const FileCard({super.key, required this.filecard});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white,
          boxShadow: [
            BoxShadow(color: grey.shade200, blurRadius: 4, spreadRadius: 4)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/images/337946.png',
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filecard.title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  filecard.note,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Date Added :${filecard.date.substring(0, 10)}',
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: red,
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  'View',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: indigo),
                ))
          ],
        ),
      ),
    );
  }
}
