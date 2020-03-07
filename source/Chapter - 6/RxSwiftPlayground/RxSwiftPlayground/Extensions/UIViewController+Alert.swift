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
                     description: String? = nil) -> Observable<Void> {
        return Observable<Void>.create { [weak self] (observer) in
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
                observer.onCompleted()
            }))
            
            self?.present(alert, animated: true, completion: nil)
            
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
                _ = self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
