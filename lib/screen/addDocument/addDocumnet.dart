import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';
import '../../widget/gradientBack.dart';
import '../../widget/mywidget.dart';
import '../../widget/sizedBoxHelper.dart';
import '../../logic/k/provider/documentProvider.dart';

class AddDocumentPage extends StatelessWidget {
  static String routeName = '/AddDocumentPage';
  const AddDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleCont = TextEditingController();

    TextEditingController noteCont = TextEditingController();
    final _provider = Provider.of<documentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: indigo,
        title: Text(
          'Add Document',
          style: TextStyle(color: white),
        ),
      ),
      body: GradientBackground(
        child: Center(
          child: Column(
            children: [
              SizedBoxHelper().SizedBox20x(),
              CustomContainer(
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: titleCont,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please enter the title '),
                ),
              ),
              SizedBoxHelper().SizedBox20x(),
              CustomContainer(
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: noteCont,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Please enter the Note '),
                ),
              ),
              SizedBoxHelper().SizedBox20x(),
              CustomContainer(
                Row(
                  children: [
                    Icon(Icons.file_copy),
                    Consumer<documentProvider>(
                        builder: (context, provider, child) {
                      return Text(provider.fileName);
                    }),
                  ],
                ),
              ),
              SizedBoxHelper().SizedBox20x(),
              GestureDetector(
                onTap: () {
                  _provider.pickFile(context);

                  // provider.pickFile(context);
                },
                child: CustomContainer(
                  Row(
                    children: [
                      Icon(Icons.add),
                      Text('Upload file'),
                    ],
                  ),
                ),
              ),
              SizedBoxHelper().SizedBox40x(),
              Consumer<documentProvider>(builder: (context, provider, child) {
                return _provider.isFileUploading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          _provider.sendDocument(
                              title: titleCont.text, note: noteCont.text);
                        },
                        child: Text('Upload Document'));
              })
            ],
          ),
        ),
      ),
    );
  }
}
