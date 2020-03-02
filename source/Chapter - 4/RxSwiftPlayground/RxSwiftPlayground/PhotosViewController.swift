//
//  PhotosViewController.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 3/2/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class PhotosViewController: UICollectionViewController {
    private lazy var photos = PhotosViewController.loadPhotos()
    private lazy var imageManager = PHCachingImageManager()
    fileprivate let selectedPhotosSubject = PublishSubject<UIImage>()
    var selectedPhotos: Observable<UIImage> {
        return self.selectedPhotosSubject.asObservable()
    }
    let bag = DisposeBag()
    
    private lazy var thumbnailSize: CGSize = {
        let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let phFetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        print(phFetchResult)
        return phFetchResult
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.selectedPhotosSubject.onCompleted()
    }
    
    
    // MARK: - UICollectionViewDataSource -
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = self.photos.object(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.representedAssetIdentifier = asset.localIdentifier
        
        self.imageManager.requestImage(for: asset,
                                       targetSize: self.thumbnailSize,
                                       contentMode: .aspectFill,
                                       options: nil,
                                       resultHandler: { image, info in
                                        if cell.representedAssetIdentifier == asset.localIdentifier {
                                            cell.imageView.image = image
                                        }
        })
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate -
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.photos.object(at: indexPath.item)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.flash()
        }
        
        self.imageManager.requestImage(for: asset,
                                       targetSize: self.view.frame.size,
                                       contentMode: .aspectFill,
                                       options: nil,
                                       resultHandler: { [weak self] image, info in
                                        guard let image = image, let info = info else { return }
                                        
                                        if let isThumbnail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbnail {
                                            self?.selectedPhotosSubject.onNext(image)
                                        }
        })
    }
}
