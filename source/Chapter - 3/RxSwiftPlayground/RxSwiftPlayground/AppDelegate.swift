//
//  AppDelegate.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 2/27/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import RxSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public func example(of description: String, action: () -> Void) {
        print("\n--- Example of:", description, "---")
        action()
    }
    
    typealias Card = (suit: String, rank: Int)
    
    enum HandError: Error {
        case busted
    }
    
    func cardString(for card: Card) -> String {
        return card.suit
    }
    
    func point(for card:Card) -> Int {
        return card.rank
    }
    
    
    var cards: [Card] = [
        Card("♥️A", 1),
        Card("♥️2", 2),
        Card("♥️3", 3),
        Card("♥️4", 4),
        Card("♥️5", 5),
        Card("♥️6", 6),
        Card("♥️7", 7),
        Card("♥️8", 8),
        Card("♥️9", 9),
        Card("♥️10", 10),
        Card("♥️J", 11),
        Card("♥️Q", 12),
        Card("♥️K", 13),
        
        Card("♠️A", 1),
        Card("♠️2", 2),
        Card("♠️3", 3),
        Card("♠️4", 4),
        Card("♠️5", 5),
        Card("♠️6", 6),
        Card("♠️7", 7),
        Card("♠️8", 8),
        Card("♠️9", 9),
        Card("♠️10", 10),
        Card("♠️J", 11),
        Card("♠️Q", 12),
        Card("♠️K", 13),
        
        Card("♣️A", 1),
        Card("♣️2", 2),
        Card("♣️3", 3),
        Card("♣️4", 4),
        Card("♣️5", 5),
        Card("♣️6", 6),
        Card("♣️7", 7),
        Card("♣️8", 8),
        Card("♣️9", 9),
        Card("♣️10", 10),
        Card("♣️J", 11),
        Card("♣️Q", 12),
        Card("♣️K", 13),
        
        Card("♦️A", 1),
        Card("♦️2", 2),
        Card("♦️3", 3),
        Card("♦️4", 4),
        Card("♦️5", 5),
        Card("♦️6", 6),
        Card("♦️7", 7),
        Card("♦️8", 8),
        Card("♦️9", 9),
        Card("♦️10", 10),
        Card("♦️J", 11),
        Card("♦️Q", 12),
        Card("♦️K", 13),
        ].shuffled()
    
    
    func deal() -> [Card] {
        self.cards.shuffle()
        
        return [self.cards[0], self.cards[1], self.cards[2]]
    }
    
    lazy var dealtHand = Single<[Card]>.create { single in
        let disposables = Disposables.create()
        
        let cards = self.deal()
        
        let isSuccess = cards.reduce(0, { (result, element)  in
            return result + self.point(for: element)
        }) <= 21
        
        isSuccess
            ? single(.success(cards))
            : single(.error(HandError.busted))
        
        return disposables
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        Observable.range(start: 1, count: 10).subscribe(onNext: { (index) in
            print(index, ")", terminator: " ")
            
            self.dealtHand.subscribe(onSuccess: { (cards) in
                cards.enumerated().forEach({
                    let info = self.cardString(for: $0.element)
                    print(info, terminator: $0.offset == 2 ? "\n" : "-")
                })
            }) { (error) in
                print(error.localizedDescription)
            }.dispose()
            
        }).dispose()
        
        

        
        
        //        example(of: "PublishSubject") {
        //
        //            let subject = PublishSubject<String>()
        //
        //            subject.onNext("Is anyone listening?")
        //
        //            let subscriptionOne = subject.subscribe(onNext: { string in
        //                print(string)
        //            })
        //
        //            subject.on(.next("1"))
        //            subject.onNext("2")
        //
        //            let subscriptionTwo = subject.subscribe{event in
        //                print("2) ", event.element ?? event)
        //            }
        //
        //
        //            subject.onNext("3")
        //
        //            subscriptionOne.dispose()
        //            subject.onNext("4")
        //
        //            subject.onCompleted()
        //            subject.onNext("5")
        //
        //            subscriptionTwo.dispose()
        //
        //
        //            let disposeBag = DisposeBag()
        //
        //            subject.subscribe { (event) in
        //                print("3)", event.element ?? event)
        //            }.disposed(by: disposeBag)
        //
        //            subject.onNext("???")
        //
        //        }
        
        
        enum MyError: Error {
            case anError
        }
        
        func printX<T: CustomStringConvertible>(aaaa: String, event: Event<T>) {
            print(aaaa, (event.element ?? event.error?.localizedDescription ?? event))
        }
        //
        //        // 3
        //        example(of: "BehaviorSubject") {
        //
        //            let subject = BehaviorSubject(value: "Initial value")
        //
        //            let disposeBag = DisposeBag()
        //
        //            subject.subscribe {
        //                    printX(aaaa: "1)", event: $0)
        //            }
        //            .disposed(by: disposeBag)
        //
        //            subject.onNext("X")
        //
        //            subject.onError(MyError.anError)
        //
        //            subject.subscribe {
        //                    printX(aaaa: "2)", event: $0)
        //            }.disposed(by: disposeBag)
        //
        //        }
        
        //        example(of: "ReplaySubject") {
        //            let subject = ReplaySubject<String>.create(bufferSize: 2)
        //
        //            let disposeBag = DisposeBag()
        //
        //            subject.onNext("1")
        //            subject.onNext("2")
        //            subject.onNext("3")
        //
        //            subject.subscribe { (event) in
        //                printX(aaaa: "1)", event: event)
        //            }.disposed(by: disposeBag)
        //
        //            subject.subscribe { (event) in
        //                printX(aaaa: "2)", event: event)
        //            }.disposed(by: disposeBag)
        //
        //            subject.onNext("4")
        //
        //            subject.onError(MyError.anError)
        //
        //            subject.dispose()
        //
        //            subject.subscribe { (event) in
        //                printX(aaaa: "3)", event: event)
        //            }.disposed(by: disposeBag)
        //
        //        }
        
//
//        example(of: "Variable") {
//            let variable = Variable("Initial value")
//            let disposeBag = DisposeBag()
//
//
//            variable.asObservable()
//                .subscribe {
//                    printX(aaaa: "1)", event: $0)
//            }
//            .disposed(by: disposeBag)
//
//            variable.value = "New initial value"
//
//            variable.asObservable()
//                .subscribe {
//                    printX(aaaa: "2)", event: $0)
//            }
//            .disposed(by: disposeBag)
//
//            variable.value = "eee"
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

