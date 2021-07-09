//
//  ExpenseDetailTableViewCell.swift
//  Itis-FinApp
//
//  Created by Danil Gerasimov on 09.07.2021.
//

import UIKit

class ExpenseDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameOfCellLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(name: String, data: String) {
        nameOfCellLabel.text = name
        dataLabel.text = data
    }

}
