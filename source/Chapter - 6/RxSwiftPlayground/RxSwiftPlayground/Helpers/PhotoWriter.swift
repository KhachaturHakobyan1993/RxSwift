//
//  PhotoWriter.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 3/2/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Photos

class PhotoWriter: NSObject {
    typealias Callback = (NSError?) -> Void
    private var callback: Callback
    
    
    private init(callback: @escaping Callback) {
        self.callback = callback
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        self.callback(error)
    }
    
    static func save(_ image: UIImage) -> Observable<Void> {
        
        
        
        return Observable.create({ observer in
            // Version 1
            //            PHPhotoLibrary.shared().performChanges({
            //                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
            //                //let savedAssetId = request.placeholderForCreatedAsset?.localIdentifier
            //            }, completionHandler: { (success, error) in
            //                DispatchQueue.main.async {
            //                    success
            //                        ? observer.onCompleted()
            //                        : observer.onError(error!)
            //                }
            //            })
            
            // Version 2
            let writer = PhotoWriter(callback: { error in
                error == nil
                    ? observer.onCompleted()
                    : observer.onError(error!)
            })
            
            UIImageWriteToSavedPhotosAlbum(image, writer, #selector(PhotoWriter.image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            return Disposables.create()
        })
    }
}
