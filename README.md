
<h1>
<img src="https://raw.githubusercontent.com/talsec/Free-RASP-Community/master/visuals/freeRASP.png" width=100%>
</h1>

![GitHub Repo stars](https://img.shields.io/github/stars/talsec/Free-RASP-Community?color=green) ![GitHub](https://img.shields.io/github/license/talsec/Free-RASP-Community) ![GitHub](https://img.shields.io/github/last-commit/talsec/Free-RASP-iOS) ![Publisher](https://img.shields.io/pub/publisher/freerasp) [![42matters](https://42matters.com/badges/sdk-installations/talsec)](https://42matters.com/sdks/android/talsec)

[<img src="https://assets.42matters.com/badges/2024/04/rising-star.svg?m=04" width="100"/>](https://42matters.com/sdks/ios/talsec)

# freeRASP for iOS

FreeRASP for iOS is a lightweight and easy-to-use mobile app protection and security monitoring SDK. It is designed to combat reverse engineering, tampering, or similar attack attempts. FreeRASP covers several attack vectors and enables you to set a response to each threat.

iOS version detects security issues such as:
* App installed on a jailbroken device (e.g., unc0ver, check1rain, ...)
* Runtime manipulations (e.g., Shadow or Frida) or running the app in the simulator
* Tampering with the application
* Attaching a debugger to the application

To learn more about freeRASP features, visit our main GitHub [repository](https://github.com/talsec/Free-RASP-Community).

# :notebook_with_decorative_cover: Table of contents

- [Usage](#usage)
  - [Step 1: Prepare Talsec library](#step-1-prepare-talsec-library)
  - [Step 2: Setup the Configuration for your App](#step-2-setup-the-configuration-for-your-app)
    - [Debug vs Release version](#debug-vs-release-version)
  - [Step 3: Handle detected threats](#step-3-handle-detected-threats)
  - [Step 4: App Store User Data policy](#step-4-app-store-user-data-policy)
- [Security Report](#security-report)
- [Talsec Commercial Subscriptions](#money_with_wings-talsec-commercial-subscriptions)
    * [Plans comparison](#plans-comparison)
- [About Us](#about-us)
- [License](#license)

# Usage
The installation guide will lead you through the whole implementation, such as adding the SDK to the dependencies, configuring it for your app, handling detected threats. It will also instruct you about required user data policies.

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
    /// Detected system VPN
    case systemVPN
}
```

To learn more about these checks, visit our [wiki](https://github.com/talsec/Free-RASP-Community/wiki/Threat-detection) page that provides an explanation for them.

## Step 4: App Store User Data policy
See the generic info about freeRASP data collection [here](https://github.com/talsec/Free-RASP-Community/tree/master#data-collection-processing-and-gdpr-compliance).

App Store App Privacy Details indicate that applications should inform users of the data that they are collecting and processing, and therefore Apple rejects the apps which do not comply with the policy. To comply with the policy, in the App Privacy section, it is important to check the following:
* Identifiers -> Device ID -> App Functionality
    * It is an anonymous device identifier for the App vendor as per:  https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor
    * Talsec Security SDK can not link the device identifier to the user
* Diagnostics -> Performance Data -> App Functionality, Other Purposes, No for linking to the user
* Diagnostics -> Other diagnostics data -> App Functionality, Other Purposes, No for linking to the user
* Other data -> App Functionality, No for linking to the user
    * Security diagnostics data (such as jailbreak)

It is also essential to include the information in the privacy policy of the application, see the [Data Collection, Processing, and GDPR compliance](https://github.com/talsec/Free-RASP-Community/tree/master#data-collection-processing-and-gdpr-compliance).

After installation, please go through this [checklist](https://github.com/talsec/Free-RASP-Community/wiki/Installation-checklist) to avoid potential issues or solve them quickly.

And you're done 🎉! You can open an issue if you get stuck anywhere in the guide or show your appreciation by starring this repository ⭐!

# Security Report

The Security Report is a weekly summary describing the application's security state and characteristics of the devices it runs on in a practical and easy-to-understand way.

The report provides a quick overview of the security incidents, their dynamics, app integrity, and reverse engineering attempts. It contains info about the security of devices, such as OS version or the ratio of devices with screen locks and biometrics. Each visualization also comes with a concise explanation.

To receive Security Reports, fill out the _watcherMail_ field in [Talsec config](#step-2-setup-the-configuration-for-your-app).

![enter image description here](https://raw.githubusercontent.com/talsec/Free-RASP-Community/master/visuals/dashboard.png)

# :money_with_wings: Talsec Commercial Subscriptions 
Talsec offers commercial plans on top of freeRASP (Business RASP+):
* No limits of Fair Usage Policy (100K App Downloads) 
* No Data Collection from your app
* FinTech grade security, features and SLA (see more in [this post](https://github.com/orgs/talsec/discussions/5))
* Protect APIs and risk scoring by AppiCrypt®

Learn more at [talsec.app](https://talsec.app).

Not to overlook, the one of the most valued commercial features is [AppiCrypt®](https://www.talsec.app/appicrypt) - App Integrity Cryptogram.

It allows easy-to-implement API protection and App Integrity verification on the backend to prevent API abuse:

-   Bruteforce attacks
-   Botnets
-   API abuse by App impersonation
-   Session-hijacking
-   DDoS

It is a unified solution that works across all mobile platforms without dependency on external web services (i.e., without extra latency, an additional point of failure, and maintenance costs).

Learn more about commercial features at [talsec.app](https://talsec.app).

**TIP:** You can try freeRASP and then upgrade easily to an enterprise service.


## Plans Comparison
<i>
freeRASP is freemium software i.e. there is a Fair Usage Policy (FUP) that impose some limitations on the free usage. See the FUP section in the table below
</i>
<br/>
<br/>
<table>
    <thead>
        <tr>
            <th></th>
            <th>freeRASP</th>
            <th>Business RASP+</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan=5><strong>Runtime App Self Protection (RASP, app shielding)</strong></td>
        </tr>
        <tr>
            <td>Advanced root/jailbreak protections (including Magisk)</td>
            <td>basic</td>
            <td>advanced</td>
        </tr>
        <tr>
            <td>Runtime reverse engineering controls 
                <ul>
                    <li>Debugger</li>
                    <li>Emulator / Simulator</li>
                    <li>Hooking and reversing frameworks (e.g. Frida, Magisk, XPosed, Cydia Substrate and more)</li>
                </ul>
            </td>
            <td>basic</td>
            <td>advanced</td>
        </tr>
        <tr>
            <td>Runtime integrity controls 
                <ul>
                    <li>Tampering protection</li>
                    <li>Repackaging / Cloning protection</li>
                    <li>Device binding protection</li>
                    <li>Unofficial store detection</li>
                </ul>
            </td>
            <td>basic</td>
            <td>advanced</td>
        </tr>
        <tr>
            <td>Device OS security status check 
                <ul>
                    <li>HW security module control</li>
                    <li>Screen lock control</li>
                    <li>Google Play Services enabled/disabled</li>
                    <li>Last security patch update</li>
					<li>System VPN control</li>
					<li>Developer mode control</li>
                </ul>
            </td>
            <td>yes</td>
            <td>yes</td>
        </tr>
        <tr>
            <td>UI protection 
                <ul>
                    <li>Overlay protection</li>
                    <li>Accessibility services misuse protection</li>
                </ul>
            </td>
            <td>no</td>
            <td>yes</td>
        </tr>
        <tr>
            <td colspan=5><strong>Hardening suite</strong></td>
        </tr>
        <tr>
            <td>Security hardening suite 
                <ul>                
                    <li>End-to-end encryption</li>
                    <li>Strings protection (e.g. API keys)</li>
                    <li>Dynamic TLS certificate pinning</li>
                </ul>
            </td>
            <td>no</td>
            <td>yes</td>
        </tr>
        <tr>
            <td colspan=5><strong>AppiCrypt® - App Integrity Cryptogram</strong></td>
        </tr>
        <tr>
            <td>API protection by mobile client integrity check, online risk scoring, online fraud prevention, client App integrity check. The cryptographic proof of app & device integrity.</td>
            <td>no</td>
            <td>yes</td>
        </tr>
        <tr>
            <td colspan=5><strong>Security events data collection, Auditing and Monitoring tools</strong></td>
        </tr>
        <tr>
            <td>Threat events data collection from SDK</td>
            <td>yes</td>
            <td>configurable</td>
        </tr>
        <tr>
            <td>AppSec regular email reporting service</td>
            <td>yes (up to 100k devices)</td>
            <td>yes</td>
        </tr>
        <tr>
            <td>UI portal for Logging, Data analytics and auditing</td>
            <td>no</td>
            <td>yes</td>
        </tr>
        <tr>     
          <td colspan=5><strong>Support and Maintenance</strong></td>
        </tr>
        <tr>
            <td>SLA</td>
            <td>Not committed</td>
            <td>yes</td>
        </tr>
        <tr>
            <td>Maintenance updates</td>
            <td>Not committed</td>
            <td>yes</td>
        </tr>
        <tr>
            <td colspan=5><strong>Fair usage policy</strong></td>
        </tr>
        <tr>
            <td>Mentioning of the App name and logo in the marketing communications of Talsec (e.g. "Trusted by" section on the web).</td>
            <td>over 100k downloads</td>
            <td>no</td>
        </tr>
        <tr>
            <td>Threat signals data collection to Talsec database for processing and product improvement</td>
            <td>yes</td>
            <td>no</td>
        </tr>
    </tbody>
</table>

For further comparison details (and planned features), follow our [discussion](https://github.com/talsec/Free-RASP-Community/discussions/5).
  
# About Us
Talsec is an academic-based and community-driven mobile security company. We deliver in-App Protection and a User Safety suite for Fintechs. We aim to bridge the gaps between the user's perception of app safety and the strong security requirements of the financial industry.

Talsec offers a wide range of security solutions, such as App and API protection SDK, Penetration testing, monitoring services, and the User Safety suite. You can check out offered products at [our web](https://www.talsec.app).
# License
This project is provided as freemium software i.e. there is a fair usage policy that impose some limitations on the free usage. The SDK software consists of opensource and binary part which is property of Talsec. The opensource part is licensed under the MIT License - see the [LICENSE](https://github.com/talsec/Free-RASP-Community/blob/master/LICENSE) file for details.
