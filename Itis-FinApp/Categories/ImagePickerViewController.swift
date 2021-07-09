//
//  ImagePickerViewController.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 09.07.2021.
//

import UIKit

protocol TapImageDelegate: AnyObject {
    func saveImageView(image: String)
}

class ImagePickerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TapImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ImagePickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell (withReuseIdentifier: "ImagePickerCollectionViewCell", for: indexPath) as? ImagePickerCollectionViewCell else {return UICollectionViewCell()}
            cell.setData(name: imageNames[indexPath.row])
            return cell
    }
    
}

extension ImagePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.saveImageView(image: imageNames[indexPath.row])
        dismiss(animated: true)
    }
}
