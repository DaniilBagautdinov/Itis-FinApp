//
//  TextbookTableViewCell.swift
//  Itis-FinApp
//
//  Created by Даниил Багаутдинов on 04.07.2021.
//

import UIKit

class TextbookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    var image: UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(textBook: TextbookCellData){
        titleLabel.text = textBook.title
        myImageView.image = UIImage(named: textBook.image)
    }
    
}
