<h1>
<img src="https://raw.githubusercontent.com/talsec/Free-RASP-Community/master/visuals/freeRASP.png" width=100%>
</h1>

# freeRASP for iOS

FreeRASP for iOS is a lightweight and easy-to-use mobile app protection and security monitoring SDK. It is designed to combat reverse engineering, tampering, or similar attack attempts. FreeRASP covers several attack vectors and enables you to set a response to each threat.

iOS version detects security issues such as:
* App installed on a jailbroken device (e.g., unc0ver, check1rain, ...)
* Runtime manipulations (e.g., Shadow or Frida) or running the app in the simulator
* Tampering with the application
* Attaching a debugger to the application

To learn more about freeRASP features, visit our main GitHub [repository](https://github.com/talsec/Free-RASP-Community).

# Usage
The installation guide will lead you through the following steps:
* [Prepare Talsec library](#step-1-prepare-talsec-library)
* [Setup the configuration](#step-2-setup-the-configuration-for-your-app)
	+ [Debug vs Release version](#debug-vs-release-version)
* [Handle detected threats](#step-3-handle-detected-threats)
* [App Store User Data Policy](#step-4-app-store-user-data-policy)

## Step 1: Prepare Talsec library

- Copy folder `Talsec` into your Application folder
- Drag & drop Talsec folder to your `.xcworkspace`
- Add **TalsecRuntime** framework to **Target > Build Phases > Link Binary With Libraries**
- In the **General > Frameworks, Libraries, and Embedded Content** choose **Embed & Sign**

Note: In case you are using Carthage, the zipped version of frameworks are included in the Releases.

## Step 2: Setup the Configuration for your App

- In the `AppDelegate` import `TalsecRuntime` and add the following code (e.g., in the `didFinishLaunchingWithOptions` method.:
```swift
let config = TalsecConfig(appBundleIds: ["YOUR_APP_BUNDLE_ID"], appTeamId: "YOUR TEAM ID", watcherMailAddress: "WATCHER EMAIL ADDRESS", isProd: true)

Talsec.start(config: config)
```
The value of watcherMail is automatically used as the target address for your security reports. Mail has a strict form `'name@domain.com'`.


### Debug vs Release version
The Debug version is used to not complicate the development process of the application, e.g. if you would implement killing of the application on the debugger callback. It disables some checks which won't be triggered during the development process:
* Debugging
* Tampering
* Simulator
* Unofficial store

If you want to use the Debug version, set the **isProd** parameter to **false**. Make sure, that you have the Release version in the production (i.e. **isProd** set to **true**)!

## Step 3: Handle detected threats
Anywhere in your project, add the following code as an extension:
```swift
import TalsecRuntime

extension SecurityThreatCenter: SecurityThreatHandler {
    public func threatDetected(_ securityThreat: TalsecRuntime.SecurityThreat) {
        print("Found incident: \(securityThreat.rawValue)")
    }
}
```
If you decide to kill the application from the callback, make sure that you use an appropriate way of killing it. Use the code above for handling these types of threats:
```swift
public enum SecurityThreat: String, Codable, CaseIterable, Equatable {
    /// app integrity / repackaging / tampering
    case signature = "appIntegrity"
    /// jailbreak
    case jailbreak = "privilegedAccess"
    /// debugger
    case debugger = "debug"
    /// runtime manipulation / hooks
    case runtimeManipulation = "hooks"
    /// disabled passcode
    case passcode
    /// passcode change
    case passcodeChange
    /// simulator
    case simulator
    /// missing Secure Enclave
    case missingSecureEnclave
    /// device binding
    case deviceChange = "device binding"
    /// changed deviceID
    case deviceID
    /// unofficial store or Xcode build
    case unofficialStore
}
```

To learn more about these checks, visit our [wiki](https://github.com/talsec/Free-RASP-Community/wiki/Threat-detection) page that provides an explanation for them.

## Step 4: App Store User Data policy
App Store App Privacy Details indicate that applications should inform users of the data that they are collecting and processing, and therefore Apple rejects the apps which do not comply with the policy. To comply with the policy, in the App Privacy section, it is important to check the following:
* Identifiers -> Device ID -> App Functionality
    * It is an anonymous device identifier for the App vendor as per:  https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor
    * Talsec Security SDK can not link the device identifier to the user
* Diagnostics -> Performance Data -> App Functionality, Other Purposes, No for linking to the user
* Diagnostics -> Other diagnostics data -> App Functionality, Other Purposes, No for linking to the user
* Other data -> App Functionality, No for linking to the user
    * Security diagnostics data (such as jailbreak)

It is also essential to include the information in the privacy policy of the application, see the [Data Collection, Processing, and GDPR compliance](https://github.com/talsec/Free-RASP-Community#data-collection-processing-and-gdpr-compliance).

After installation, please go through this [checklist](https://github.com/talsec/Free-RASP-Community/wiki/Installation-checklist) to avoid potential issues or solve them quickly.

And you're done 🎉! You can open an issue if you get stuck anywhere in the guide or show your appreciation by starring this repository ⭐!
