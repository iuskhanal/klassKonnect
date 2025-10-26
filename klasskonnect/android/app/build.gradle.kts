plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // 
    id("dev.flutter.flutter-gradle-plugin")
}

// ...existing code...
android {
    namespace = "com.example.klasskonnect"

    // Read Flutter-generated properties safely in Kotlin DSL
    val flutterCompileSdkVersion = (project.property("flutter.compileSdkVersion") as String).toInt()
    val flutterNdkVersion = project.property("flutter.ndkVersion") as String
    val flutterMinSdkVersion = (project.property("flutter.minSdkVersion") as String).toInt()
    val flutterTargetSdkVersion = (project.property("flutter.targetSdkVersion") as String).toInt()
    val flutterVersionCode = (project.property("flutter.versionCode") as String).toInt()
    val flutterVersionName = project.property("flutter.versionName") as String

    compileSdk = flutterCompileSdkVersion
    ndkVersion = flutterNdkVersion

    defaultConfig {
        applicationId = "com.example.klasskonnect"
        minSdk = flutterMinSdkVersion
        targetSdk = flutterTargetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName
        multiDexEnabled = true // ✅ prevents 64k method limit issues
    }

    // ...existing code...
}