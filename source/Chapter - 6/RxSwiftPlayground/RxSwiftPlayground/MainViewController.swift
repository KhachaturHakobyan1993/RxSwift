//
//  ViewController.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 2/27/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var addBarButton: UIBarButtonItem!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    private let bag = DisposeBag()
    private var images = Variable<[UIImage]>([])
    private var imageCache = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    
    // MARK: - Private Methods -
    
    private func setup() {
        self.images.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (photos) in
                self?.updateUI(photos: photos)
            })
            .disposed(by: self.bag)
    }
    
    private func updateUI(photos: [UIImage]) {
        self.title = photos.isEmpty ? "Collage" : "\(photos.count) photos"
        self.addBarButton.isEnabled = (photos.count < 6)
        self.clearButton.isEnabled = !photos.isEmpty
        self.clearButton.isEnabled = !photos.isEmpty
        self.saveButton.isEnabled = (!photos.isEmpty && photos.count % 2 == 0)
        self.previewImageView.image = UIImage.collage(images: photos,
                                                      size: self.previewImageView.frame.size)
    }
    
    private func showMessage(_ title: String, description: String? = nil) {
        self.showMessage(title: title, description: description)
            .subscribe(onCompleted: {  [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: self.bag)
    }
    
    private func updateNavigationIcon() {
        let icon = self.previewImageView.image?
            .scaled(CGSize(width: 22, height: 22))
            .withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: icon,
                                                                style: .done, target: nil, action: nil)
    }
    
    
    // MARK: - IBAction Methods -
    
    @IBAction private func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let photosViewController = self.storyboard?.instantiateViewController(identifier: String(describing: PhotosViewController.self)) as? PhotosViewController else { return }
        
        let newPhotos = photosViewController.selectedPhotos.share()
        
        newPhotos
            .takeWhile { [weak self] (image) -> Bool in
                    return (self?.images.value.count ?? 0) < 6
            }
            .filter({ (image) in
                return image.size.width > image.size.height
            })
            .filter({ [weak self] (newImage) in
                let length = newImage.pngData()?.count ?? 0
                
                guard self?.imageCache.contains(length) == false else { return false }
                
                self?.imageCache.append(length)
                
                return true
            })
            .subscribe(onNext: { [weak self] (newImage) in
                guard (self?.images.value.count)! < 6 else {
                    self?.navigationController?.popViewController(animated: true)
                    return
                }
                self?.images.value.append(newImage)
            }) {
                print("Completd Phtoto Selection")
        }
        .disposed(by: photosViewController.bag)
        
        newPhotos
            .ignoreElements()
            .subscribe(onCompleted: { [weak self] in
                self?.updateNavigationIcon()
            })
            .disposed(by: photosViewController.bag)
                    
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    @IBAction private func clearButtonTapped() {
        self.images.value = []
        self.imageCache = []
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction private func saveButtonTapped() {
        guard let imageToSave = self.previewImageView.image else { return }
        
        PhotoWriter.save(imageToSave)
            .subscribe(onError: { [weak self] (error) in
                self?.showMessage("Error", description: error.localizedDescription)
                }, onCompleted: { [weak self] in
                    self?.showMessage("Saved")
                    self?.clearButtonTapped()
            })
            .disposed(by: self.bag)
    }
}
