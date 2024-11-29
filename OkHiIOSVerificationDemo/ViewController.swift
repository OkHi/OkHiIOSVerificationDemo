//
//  ViewController.swift
//  OkHiIOSVerificationDemo
//
//  Created by Julius Kiano on 13/11/2024.
//

import UIKit
import OkHi

class ViewController: UIViewController {
    
    private let okCollect = OkCollect()
    private let okVerify = OkVerify()
    private let okhiConfig = OkHiConfig().withUsageTypes(usageTypes: [.addressBook]).enableAppBar().enableStreetView()
    private let okHiTheme = OkHiTheme().with(logoUrl: "https://cdn.okhi.co/icon.png").with(appBarColor: "#333").with(appName: "OkHi")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        okCollect.delegate = self
        okVerify.delegate = self
    }
    
    @IBAction func onVerifyAddressClick(_ sender: UIButton) {
        startAddressCreation()
    }
    
    private func startAddressCreation() {
        guard let vc = okCollect.viewController(with: createOkHiUser(), okHiTheme: okHiTheme, okHiConfig: okhiConfig) else { return }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func startAddressVerification(response: OkCollectSuccessResponse) {
        okVerify.startAddressVerification(response: response)
    }
    
    private func createOkHiUser() -> OkHiUser {
        return OkHiUser(phoneNumber: "+2457...")
            .with(email: "jane@okhi.co")
            .with(firstName: "Jane")
            .with(lastName: "Doe")
            .with(appUserId: "abcd1234")
    }
    
    private func showMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - OkCollectDelegate
extension ViewController: OkCollectDelegate {
    func collect(didEncounterError error: OkHiError) {
        showMessage(title: "Error: \(error.code)", message: error.message)
    }
    
    func collect(didSelectAddress response: OkCollectSuccessResponse) {
        startAddressVerification(response: response)
    }
}


// MARK: - OkVerifyDelegate
extension ViewController: OkVerifyDelegate {
    func verify(_ okverify: OkVerify, didChangeLocationPermissionStatus requestType: OkVerifyLocationPermissionRequestType, status: Bool) {
        print("permission changed")
    }
    
    func verify(_ okverify: OkVerify, didInitialize result: Bool) {
        print("init done")
    }
    
    func verify(_ okverify: OkVerify, didEncounterError error: OkVerifyError) {
        showMessage(title: "Error: \(error.code)", message: error.message)
    }
    
    func verify(_ okverify: OkVerify, didStartAddressVerificationFor locationId: String) {
        showMessage(title: "Success", message: "Started verification for \(locationId)")
    }
    
    func verify(_ okverify: OkVerify, didStopVerificationFor locationId: String) {
        showMessage(title: "Success", message: "Stopped verification for \(locationId)")
    }
    
    func verify(_ okverify: OkVerify, didUpdateLocationPermissionStatus status: CLAuthorizationStatus) {
        print("permission updated")
    }
    
    func verify(_ okverify: OkVerify, didUpdateNotificationPermissionStatus status: Bool) {
        print("notification permission updated")
    }
}

