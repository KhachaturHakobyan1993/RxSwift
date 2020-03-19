import RxSwift
import Foundation


example(of: "PublishSubject") {
    
    let subject = PublishSubject<String>()
    
    
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in
        print(string)
    })
}


