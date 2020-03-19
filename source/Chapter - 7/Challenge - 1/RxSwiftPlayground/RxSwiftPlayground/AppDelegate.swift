//
//  AppDelegate.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 2/27/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let convert: (String) -> UInt? = { value in
    if let number = UInt(value),
        number < 10 {
        return number
    }
    
    let keyMap: [String: UInt] = [
        "abc": 2, "def": 3, "ghi": 4,
        "jkl": 5, "mno": 6, "pqrs": 7,
        "tuv": 8, "wxyz": 9
    ]
    
    let converted = keyMap
        .filter { $0.key.contains(value.lowercased()) }
        .map { $0.value }
        .first
    
    return converted
}

let contacts = [
    "603-555-1212": "Florent",
    "212-555-1212": "Junior",
    "408-555-1212": "Marin",
    "617-555-1212": "Scott"
]

let format: ([UInt]) -> String = {
    var phone = $0.map(String.init).joined()
    
    phone.insert("-", at: phone.index(
        phone.startIndex,
        offsetBy: 3)
    )
    
    phone.insert("-", at: phone.index(
        phone.startIndex,
        offsetBy: 7)
    )
    
    return phone
}

let dial: (String) -> String = {
    if let contact = contacts[$0] {
        return "Dialing \(contact) (\($0))..."
    } else {
        return "Contact not found"
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        let disposeBag = DisposeBag()
        
        let input = PublishSubject<String>()
        
        input
            .skipWhile({ $0 == "0" })
            .flatMap({ element -> Observable<UInt> in
                if element == "0" || element == "1" {
                    return Observable.just(UInt(element)!)
                } else {
                    return convert(element) != nil
                        ? Observable.just(convert(element)!)
                        : Observable.empty()
                }
            })
            .take(10)
            .toArray()
            .subscribe(onNext: {
                print($0)
                
                let phone = format($0)
                
                let status = dial(phone)
                
                print(status)
            })
            .disposed(by: disposeBag)
        
        input.onNext("0")
        input.onNext("abcd")
        
        input.onNext("abc")
        input.onNext("1")
        
        // Confirm that 7 results in "Contact not found," and then change to 2 and confirm that Junior is found
        input.onNext("abc")
        
        ["jkl", "jkl", "jkl", "1", "abc", "1", "abc"].forEach {
            input.onNext($0)
        }
        
        input.onNext("wxyz")
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

