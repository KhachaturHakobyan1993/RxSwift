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

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

let contacts = [
    "603-555-1212": "Florent",
    "212-555-1212": "Junior",
    "408-555-1212": "Marin",
    "617-555-1212": "Scott"
]

func phoneNumber(from inputs: [Int]) -> String {
    var phone = inputs.map(String.init).joined()
    
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        example(of: "Ignore Elements") {
        //            // 1
        //            let strikes = PublishSubject<String>()
        //
        //            let disposeBag = DisposeBag()
        //
        //            // 2
        //            strikes
        //                .elementAt(1)
        //                .subscribe(onNext: { (a) in
        //                    print(a)
        //                }, onCompleted: {
        //                    print("onCompleted are out.")
        //
        //                }, onDisposed: {
        //                    print("onDisposed are out.")
        //                })
        //                .disposed(by: disposeBag)
        //
        //            strikes.onNext("A")
        //            strikes.onNext("B")
        //            strikes.onNext("C")
        //            strikes.onCompleted()
        //        }
        //
        //        example(of: "Filter") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of(1, 2, 3, 4, 5, 6)
        //                // 2
        //                .filter { value in
        //                    value % 2 == 0
        //
        //            }
        //                // 3
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "Skip") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of("A", "B", "C", "D", "E", "F")
        //            // 2
        //            .skip(2)
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //            .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "SkipWhile") {
        //            let dispoeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of(4, 4, 2, 2, 3, 4, 4)
        //                // 2
        //                .skipWhile { integer in
        //                    integer % 2 == 0
        //            }.subscribe(onNext: {
        //                print($0)
        //            })
        //                .disposed(by: dispoeBag)
        //        }
        //
        //        example(of: "SkipUntil") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            let subject = PublishSubject<String>()
        //            let trigger = PublishSubject<String>()
        //
        //            // 2
        //            subject
        //            .skipUntil(trigger)
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //            .disposed(by: disposeBag)
        //
        //            subject.onNext("A")
        //            subject.onNext("B")
        //
        //            trigger.onNext("X")
        //
        //            subject.onNext("C")
        //        }
        //
        //
        //        example(of: "Take") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of(1, 2, 3, 4, 5, 6)
        //                .take(2)
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //        }
        //
        //
        //        example(of: "TakeWhile") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of(2, 2, 4, 4, 8, 3, 4, 5, 6)
        //                .enumerated()
        //                .takeWhile({ (index, integer) in
        //                    integer % 2 == 0 && index < 3
        //                })
        //                .map({
        //                    $0.element
        //                })
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "TakeUntil") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            let subject = PublishSubject<String>()
        //            let trigger = PublishSubject<String>()
        //
        //            // 2
        //            subject
        //                .takeUntil(trigger)
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //
        //            subject.onNext("A")
        //            subject.onNext("B")
        //
        //            trigger.onNext("X")
        //
        //            subject.onNext("C")
        //        }
        //
        //        _ = Observable.of(2, 2, 4, 4, 8, 3, 4, 5, 6)
        //            .takeUntil(self.rx.deallocated)
        //            .subscribe(onNext: {
        //                print($0)
        //            })
        //
        //        example(of: "DistinctUntilChanged") {
        //            let disposebag = DisposeBag()
        //
        //            // 1
        //            Observable.of("A", "A", "B", "B", "A")
        //            // 2
        //            .distinctUntilChanged()
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //            .disposed(by: disposebag)
        //        }
        
        //        example(of: "DistinctUntilChanged(_:)") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            let formatter = NumberFormatter()
        //            formatter.numberStyle = .spellOut
        //
        //            // 2
        //            Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        //                // 3
        //                .distinctUntilChanged(({ (a, b)  in
        //                    // 4
        //                    guard let aWords = formatter.string(from: a)?.components(separatedBy: " "),
        //                        let bWords = formatter.string(from: b)?.components(separatedBy: " ") else { return false }
        //
        //                    var containsMatch = false
        //
        //                    // 5
        //                    for aWord in aWords {
        //                        for bWord in bWords {
        //                            if aWord == bWord {
        //                                containsMatch = true
        //                                break
        //                            }
        //                        }
        //                    }
        //
        //                    return containsMatch
        //                }))
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //        }
        
        let disposeBag = DisposeBag()
        
        let input = PublishSubject<Int>()
        
        input
            .skipWhile({ $0 == 0 })
            .filter({ $0 < 10})
            .take(10)
            .toArray()
            .subscribe(onNext: {
                print($0)
                
                let phone = phoneNumber(from: $0)
                
                if let contact = contacts[phone] {
                    print("Dialing \(contact) (\(phone))...")
                } else {
                    print("Contact not found")
                }
                
            })
            .disposed(by: disposeBag)
        
        input.onNext(0)
        input.onNext(603)
        
        input.onNext(2)
        input.onNext(1)
        
        // Confirm that 7 results in "Contact not found," and then change to 2 and confirm that Junior is found
        input.onNext(2)
        
        "5551212".forEach {
            if let number = (Int("\($0)")) {
                input.onNext(number)
            }
        }
        
        input.onNext(9)
        
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

