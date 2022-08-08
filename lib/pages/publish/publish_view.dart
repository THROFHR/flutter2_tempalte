import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter2_template/common/values/values.dart';
import 'package:get/get.dart';

import '../../common/services/photo.dart';
import '../../common/store/store.dart';
import '../../components/components.dart';
import '../../utils/request.dart';
import 'publish_logic.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final logic = Get.find<PublishLogic>();
  final state = Get.find<PublishLogic>().state;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "发布",
      body: SingleChildScrollView(
        child: Column(
          children: [
            inputTextAreaEdit(
              hintText: "说点啥呢..."
            ),
            dividerPx(),
            Container(
              width: double.infinity,
              child: uploadFile(maxAssets: 9, media: []),
            ),
            ElevatedButton(onPressed: (){
              UserStore.to.updateProfile({"nickname":"${DateTime.now()}"});
            }, child: Text("测试")),
            ElevatedButton(
              onPressed: () {
                PhotoService.to.getFiles(context).then((data) async{
                  if(data.length > 0){
                    final File? originFile = await data[0].originFile; // 原图或者原视频
                    List<File> files = [];
                    files.add(originFile!);
                    // Request().uploadFile(files);
                  }
                });
              },
              child: Text("图片"),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<PublishLogic>();
    super.dispose();
  }
}