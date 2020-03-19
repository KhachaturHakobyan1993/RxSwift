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

struct Student {
    var score: BehaviorSubject<Int>
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        example(of: "ToArray") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of("A", "B", "C")
        //                // 2
        //                .toArray()
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "Map") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            let formatter = NumberFormatter()
        //            formatter.numberStyle = .currency
        //
        //            // 2
        //            Observable.of(123, 4, 56, 1)
        //                // 3
        //                .map {
        //                    //formatter.string(from: $0) ?? String()
        //                    formatter.toRoman(number: $0)
        //            }
        //            .subscribe(onNext: {
        //                print($0)
        //            })
        //                .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "Enumerated and Map") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            Observable.of(1, 2, 3, 4, 5, 6)
        //            // 2
        //            .enumerated()
        //            // 3
        //            .map({ index, integer in
        //                index > 2 ? integer * 2 : integer
        //            })
        //            .subscribe(onNext: {
        //                print($0)
        //            })
        //            .disposed(by: disposeBag)
        //        }
        //
        //        example(of: "FlatMap") {
        //            let disposeBag = DisposeBag()
        //
        //            // 1
        //            let ryan = Student(score: BehaviorSubject(value: 80))
        //            let charlotte = Student(score: BehaviorSubject(value: 90))
        //
        //            // 2
        //            let student = PublishSubject<Student>()
        //
        //            // 3
        //            student
        //                .flatMap({
        //                  $0.score
        //                })
        //                // 4
        //                .subscribe(onNext: {
        //                    print($0)
        //                })
        //                .disposed(by: disposeBag)
        //
        //
        //            student.onNext(ryan)
        //            ryan.score.onNext(44)
        //            ryan.score.onNext(55)
        //
        //            student.onNext(charlotte)
        //            charlotte.score.onNext(88)
        //            ryan.score.onNext(333)
        //        }
        //
        //
        //        example(of: "flatMapLatest") {
        //          let disposeBag = DisposeBag()
        //
        //          let ryan = Student(score: BehaviorSubject(value: 80))
        //          let charlotte = Student(score: BehaviorSubject(value: 90))
        //
        //            let student = PublishSubject<Student>()
        //
        //            student
        //                .flatMapLatest {
        //                    $0.score
        //            }
        //            .subscribe(onNext: {
        //                print($0)
        //            })
        //                .disposed(by: disposeBag)
        //
        //            student.onNext(ryan)
        //
        //            ryan.score.onNext(85)
        //
        //            student.onNext(charlotte)
        //
        //            ryan.score.onNext(95)
        //
        //            charlotte.score.onNext(100)
        //        }
//
//        example(of: "materialize and dematerialize") {
//            // 1
//            enum MyError: Error {
//                case anError
//            }
//
//            let disposeBag = DisposeBag()
//
//            // 2
//            let ryan = Student(score: BehaviorSubject(value: 80))
//            let charlotte = Student(score: BehaviorSubject(value: 100))
//
//            let student = BehaviorSubject(value: ryan)
//
//            // 1
//            let studentScore = student
//                .flatMapLatest {
//                    $0.score.materialize()
//            }
//
//            // 2
//            studentScore
//                .subscribe(onNext: {
//                    print($0)
//                }, onError: { _ in
//                    print("Errrrrrrrrrrr")
//                }, onCompleted: {
//                    print("Completed__________")
//                })
//                .disposed(by: disposeBag)
//
//            // 3
//            ryan.score.onNext(85)
//            ryan.score.onError(MyError.anError)
//
//            ryan.score.onNext(90)
//
//            // 4
//            student.onNext(charlotte)
//            charlotte.score.onNext(444)
//            charlotte.score.onNext(444)
//
//            charlotte.score.onNext(555)
//
//            studentScore
//                // 1
//                .filter {
//                    guard $0.error == nil else {
//                        //print($0.error!)
//                        return false
//                    }
//
//                    return true
//            }
//                // 2
//                .dematerialize()
//                .subscribe(onNext: {
//                    print($0)
//                })
//                .disposed(by: disposeBag)
//
//            charlotte.score.onNext(666)
//            charlotte.score.onNext(777)
//            ryan.score.onNext(444)
//            charlotte.score.onError(MyError.anError)
//            charlotte.score.onNext(888)
//            ryan.score.onNext(999)
//        }
        
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


extension NumberFormatter {
    func toRoman(number: Int) -> String {
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        
        var romanValue = ""
        var startingValue = number
        
        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue
            
            if (div > 0) {
                for _ in 0..<div {
                    //println("Should add \(romanChar) to string")
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }
        
        return romanValue
    }
}
