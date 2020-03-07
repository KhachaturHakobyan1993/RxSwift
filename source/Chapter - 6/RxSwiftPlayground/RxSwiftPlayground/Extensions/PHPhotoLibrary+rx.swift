//
//  PHPhotoLibrary+rx.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 3/7/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
    static var authorized: Observable<Bool> {
        return Observable.create { observer in
            
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    self.requestAuthorization { (newStatus) in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
