
# freeRASP for iOS

freeRASP for iOS is a part of security SDK for the app shielding and security monitoring. Learn more about provided features on the [freeRASP's main repository](https://github.com/talsec/Free-RASP-Community) first.

# Usage

## Step 1: Prepare Talsec library

- Copy folder `Talsec` into your Application folder
- D&D Talsec folder to your `.xcworkspace`
- Go to your **Target > Build Phases > New Run Script Phase**
- Use the following code to use an appropriate Talsec for a release or debug build:
!!! **Do clean build before change Debug <-> Release version** !!!
```sh
cd "${SRCROOT}/Talsec"
if [ "${CONFIGURATION}" = "Release" ]; then
	rm -rf ./TalsecRuntime.xcframework
	ln -s ./Release/TalsecRuntime.xcframework/ TalsecRuntime.xcframework
else
	rm -rf ./TalsecRuntime.xcframework
	ln -s ./Debug/TalsecRuntime.xcframework/ TalsecRuntime.xcframework
fi
```
- Add **TalsecRuntime** framework to **Target > Build Phases > Link Binary With Libraries**

### Debug vs. Release version
Debug version is used during the development of application. It separates development and production data and disables some checks which won't be triggered during development process:
* Debugging
* Signing
* Simulator
* Secure Enclave

## Step 2: Setup the Configuration for your App
Add following code in the `AppDelegate`:
```swift
let config = TalsecConfig(appBundleIds: ["[YOUR_APP_BUNDLE_ID]"], appTeamId: "[YOUR TEAM ID]", watcherMailAddress: "[WATCHER EMAIL ADDRESS]")

Talsec.start(config: config)
```
The value of watcherMail is automatically used as target address for your security reports. Mail has a strict form `'name@domain.com'`.
## Step 3: Handle detected threats
- Anywhere in your project, add following code as an extension:
```swift
import TalsecRuntime

extension SecurityThreatCenter: SecurityThreatHandler {
	public func threatDetected(_ securityThreat: TalsecRuntime.SecurityThreat) {
		print("Found incident: \(securityThreat.rawValue)")
	}
}
```
Use the code above for handling these types of threats:
```swift
public enum SecurityThreat: String, Codable, CaseIterable, Equatable {
	/// Broken signature
	case signature
	/// Detected jailbreak, not performed in MacCatalyst
	case jailbreak
	/// Detected attached debugger
	case debugger
	/// Runtime manipulation detected e.g. Frida, Cycript, Cynject
	case runtimeManipulation
	/// Detected disabled passcode
	case passcode
	/// Detected passcode change
	case passcodeChange
	/// Detected running in simulator
	case simulator
	/// Detected missing secure enclave
	case missingSecureEnclave
	/// Device change
	case deviceChange
}
```

## Step 4: App Store User Data policy
App Store App Privacy Details indicate that applications should inform users of the data that they are collecting and processing, and therefore Apple rejects the apps which do not comply with the policy. To comply with the policy, in the App Privacy section, it is important to check the following:
* Identifiers -> Device ID -> App Functionality
	* It is anonymous device identifier for App vendor as per:  https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor
	* Talsec Security SDK can not link the device identifier to the user
* Diagnostics -> Performance Data -> App Functionality, Other Purposes, No for linking to the user
* Diagnostics -> Other diagnostics data -> App Functionality, Other Purposes, No for linking to the user
* Other data -> App Functionality, No for linking to the user
	* Security diagnostics data (such as jailbreak)

It is also important to include the information in the privacy policy of the application, see the [Data Collection, Processing, and GDPR compliance](https://github.com/talsec/Free-RASP-Community#data-collection-processing-and-gdpr-compliance).

And you're done 🎉! You can open issue if you get stuck anywhere in the guide or show your appreciation by starring this repository ⭐!
