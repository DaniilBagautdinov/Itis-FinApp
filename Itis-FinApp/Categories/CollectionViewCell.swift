//
//  CollectionViewCell.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 06.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setData (category: Categories) {
        imageView.image = UIImage (named: category.image)
        label.text = category.name
    }
    
    
}
