//
//  DetailsCategorisTableViewCell.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 06.07.2021.
//

import UIKit

class DetailsCategorisTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var money: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}