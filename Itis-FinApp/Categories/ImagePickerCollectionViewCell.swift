//
//  ImagePickerCollectionViewCell.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 09.07.2021.
//

import UIKit

class ImagePickerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setData (name: String) {
        imageView.image = UIImage (named: name)
        }

}
