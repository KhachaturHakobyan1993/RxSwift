//
//  PhotoCell.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 3/2/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    var representedAssetIdentifier: String!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func flash() {
        self.imageView.alpha = 0
        self.setNeedsDisplay()
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.imageView.alpha = 1
        })
    }
}
