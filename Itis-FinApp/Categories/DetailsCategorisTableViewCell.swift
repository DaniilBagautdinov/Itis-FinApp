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
    
    func setData (operation: Operation) {
        if operation.isIncome {
            money.textColor = .systemGreen
            money.text = "+\(operation.money)"
        } else {
            money.textColor = .systemRed
            money.text = "-\(operation.money)"
        }
        name.text = operation.name
        time.text = operation.date
    }
}
