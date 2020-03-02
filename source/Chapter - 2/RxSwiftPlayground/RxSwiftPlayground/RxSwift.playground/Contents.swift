import RxSwift
import Foundation

//example(of: "just, of, from") {
//    // 1
//    let one = 1
//    let two = 2
//    let three = 3
//
//    // 2
//    let observable: Observable<Int> = Observable<Int>.just(one)
//    let observable2 = Observable.of(one, two, three)
//    let observable3 = Observable.of([one, two, three])
//    let observable4 = Observable.from([one, two, three])
//
//    let observer = NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification,
//                                                          object: nil,
//                                                          queue: nil) { (notification) in
//
//    }
//}
//
//
//example(of: "subscribe") {
//    let sequence = 0..<3
//
//    var iterator = sequence.makeIterator()
//
//    while let n = iterator.next() {
//        print(n)
//    }
//
//    let one = 1
//    let two = 2
//    let three = 3
//
//    let observable = Observable.of(one, two, three)
//
//    observable.subscribe(onNext: { (element) in
//       print(element)
//    })
//
//
//    example(of: "empty") {
//        let observable = Observable<Void>.empty()
//
//        observable.subscribe(onNext: { (element) in
//           print("AAAAA", element)
//        })
//
//
//        observable.subscribe(onNext: { (element) in
//            print(element)
//        }, onError: { (erro) in
//            print(erro)
//        }, onCompleted: {
//            print("completede")
//        }) {
//            print("disposed")
//        }
//    }
//}
//
//
//
//example(of: "never") {
//    let observable = Observable<Any>.never()
//
//    observable.subscribe(onNext: { (element) in
//        print(element)
//    }, onCompleted: {
//        print("completed", #function)
//    })
//}
//
//
//example(of: "range") {
//    // 1
//    let observable = Observable<Int>.range(start: 1, count: 10)
//
//
//  observable.subscribe(onNext: { (element) in
//        // 2
//
//
//        let n = Double(element)
//        let fibonacci = Int( ((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded() )
//
//        if fibonacci == 5 {
//
//        }
//        print(fibonacci)
//    }, onCompleted: {
//        print("completed")
//        }).dispose()
//
//}
//
//
//example(of: "dispose") {
//    // 1
//    let observable = Observable.of("A", "B", "C")
//
//    // 2
//    let subscription = observable.subscribe { (event) in
//
//        // 3
//        print(event)
//    }
//
//    subscription.dispose()
//}
//

example(of: "DisposeBage") {
    // 1
    let disposeBag = DisposeBag()

    // 2
    Observable.of("A", "B", "C").subscribe(onNext: { (element) in
        print(element)
    }).disposed(by: disposeBag)
    
    Observable.of(1, 2, 3).do(onNext: { (a) in
        print(a)
    }, onError: { (a) in
        print(a)
    }, onCompleted: {
        print("onCompleted")
    }, onSubscribe: {
        print("onSubscribe")
    }, onSubscribed: {
        print("onSubscribed")
    }) {
        print("onCompleted")
    }
}


//example(of: "create") {
//    let disposeBag = DisposeBag()
//
//    enum MyError: Error {
//        case anError
//    }
//
//    Observable<String>.create { observer in
//        // 1
//        observer.onNext("1")
//
//        //observer.onError(MyError.anError)
//
//        // 2
//       // observer.onCompleted()
//
//        // 3
//        observer.onNext("?")
//
//        // 4
//        return Disposables.create()
//    }.subscribe(onNext: { print($0) },
//                onError: { print($0) },
//                onCompleted: { print("completed")},
//                onDisposed: { print("disposed")})
//    .dispose()
//}
//
//
//example(of: "deferred") {
//    let disposeBag = DisposeBag()
//
//    // 1
//    var flip = false
//
//    // 2
//    let factory: Observable<Int> = Observable.deferred {
//
//        // 3
//        flip = !flip
//
//        // 4
//        if flip {
//            return Observable.of(1, 2, 3)
//        } else {
//            return Observable.of(4, 5, 6)
//        }
//    }
//
//    for _ in 0...3 {
//        factory.subscribe(onNext: { (element) in
//            print(element, terminator: "")
//            }).disposed(by: disposeBag)
//
//        print("______")
//    }
//}

//example(of: "Single") {
//    let disposeBag = DisposeBag()
//
//    // 1
//    var flip = false
//
//    // 2
//    enum FileReadError: Error {
//        case fileNotFound, unreadable, encodingFaild
//    }
//
//    // 3
//    func loadText(from name: String) -> Single<String> {
//
//        // 4
//        return Single.create { single in
//
//            // 1
//            let disposable = Disposables.create()
//
//            // 2
//            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
//                single(.error(FileReadError.fileNotFound))
//                return disposable
//            }
//
//            // 3
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposable
//            }
//
//            // 4
//            guard let contents = String(data: data, encoding: .utf8) else {
//                single(.error(FileReadError.encodingFaild))
//                return disposable
//            }
//
//            // 5
//            single(.success(contents))
//
//            return disposable
//        }
//
//    }
////    loadText(from: "Copyright").subscribe {
////        // 3
////        switch $0 {
////        case .success(let string):
////            print(string)
////        case .error(let error):
////            print(error)
////        }
////    }.disposed(by: disposeBag)
//
//
//    loadText(from: "Copyright").do(onSuccess: { (text) in
//        print(text)
//
//    }, onError: { (error) in
//        print("aaaa", error.localizedDescription)
//
//    }, onSubscribe: {
//        print("onSubscribe")
//    }, onSubscribed: {
//        print("onSubscribed")
//
//    }) {
//        print("Disposed")
//    }
//}
//
//
//
//
