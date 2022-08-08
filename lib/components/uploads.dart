import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../common/services/services.dart';
import '../common/values/values.dart';
import '../pages/full_view/full_view_view.dart';
import '../router/app_pages.dart';

class uploadMedia {
  int? type;
  String? url;
  String? thumb;

  uploadMedia({this.type, this.url, this.thumb});

  uploadMedia.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['thumb'] = this.thumb;
    return data;
  }
}

class uploadFile extends StatefulWidget {
  final int maxAssets;
  final RequestType requestType;
  final List<uploadMedia> media; //已经上传的
  uploadFile({
    Key? key,
    this.maxAssets = 1,
    this.requestType = RequestType.common,
    required this.media,
  }) : super(key: key);

  @override
  State<uploadFile> createState() => _uploadFileState();
}

class _uploadFileState extends State<uploadFile> {
  List<AssetEntity> filesAsset = [];

  addMore(int addMax) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.all(5),
      color: AppColors.primaryBackground,
      child: GestureDetector(
        onTap: () {
          PhotoService.to
              .getFiles(context, maxAssets: addMax)
              .then((data) async {
            data.forEach((element) {
              filesAsset.add(element);
            });
            setState(() {
              filesAsset = filesAsset;
            });
          });
        },
        child: Center(
          child: Icon(Icons.add, color: AppColors.ignoreText, size: 64),
        ),
      ),
    );
  }

  rowsChildren() {
    List<Widget> children = [];
    filesAsset.forEach((asset) {
      var tag = asset.id;
      children.add(Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(5),
        color: AppColors.defaultText,
        child: FullBox(
          tag: tag,
          onTap: (){
            Get.toNamed(AppRoutes.fullViewPage, parameters: {"tag": tag },arguments: asset);
          },
          child: Stack(children: [
            Image(
              image: AssetEntityImageProvider(
                asset,
                isOriginal: false,
              ),
              fit: BoxFit.cover,
            ),
            if (asset.duration > 0)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: Radii.k6pxRadius,
                      color: AppColors.primaryBackground.withOpacity(0.7),
                    ),
                    child: Icon(Icons.play_arrow),
                  ),
                ),
              ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  print("remove");
                  filesAsset.remove(asset);
                  setState(() {
                    filesAsset = filesAsset;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(10)),
                    color: AppColors.primaryBackground.withOpacity(0.7),
                  ),
                  child:
                      Icon(Icons.close, color: AppColors.dangerColor, size: 16),
                ),
              ),
            ),
          ]),
        ), // imageSkeleton(isCircularImage: false),
      ));
    });

    var addMax = widget.maxAssets - (widget.media.length + filesAsset.length);
    if (addMax > 0) {
      children.add(addMore(addMax));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: rowsChildren(),
      ),
    );
  }
}
