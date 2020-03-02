//
//  UIViewController+Alert.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 3/2/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import RxSwift
 
extension UIViewController {
    func showMessage(title: String,
                     description: String? = nil) -> Completable {
        return Completable.create { (complete) in
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                complete(.completed)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            return Disposables.create()
        }
    }
}
