# flutter2_template

A new Flutter project.

## Getting Started


#### 更改应用名
```
//For Android edit android/app/src/main/AndroidManifest.xml
<application
        android:name="io.flutter.app.FlutterApplication"
        android:label="your_app_name"
        android:icon="@mipmap/ic_launcher">

//For iOS， edit ios/Runner/Info.plist
<key>CFBundleName</key>
<string>your_app_name</string>

```

#### 更改包名
```
flutter pub run change_app_package_name:main com.example.flutter
```

#### 更改Icon
```
flutter pub run flutter_launcher_icons:main
```

#### 更改DeepLink
```
// 查看文档 https://github.com/avioli/uni_links/tree/master/uni_links
app://com.example.flutter2_template
```