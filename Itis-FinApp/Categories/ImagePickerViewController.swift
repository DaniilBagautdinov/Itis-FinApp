//
//  ImagePickerViewController.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 09.07.2021.
//

import UIKit

class ImagePickerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
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
