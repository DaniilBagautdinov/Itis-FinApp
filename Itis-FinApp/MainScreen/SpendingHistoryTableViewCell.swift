//
//  SpendingHistoryTableViewCell.swift
//  Itis-FinApp
//
//  Created by Danil Gerasimov on 04.07.2021.
//

import UIKit

class SpendingHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryExpenseLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(expense: Float){
        categoryExpenseLabel.text = "Категория"
        expenseLabel.text = expense.description
    }

    

}
