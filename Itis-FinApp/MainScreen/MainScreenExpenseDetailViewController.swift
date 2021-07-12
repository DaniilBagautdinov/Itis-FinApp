//
//  MainScreenExpenseDetailViewController.swift
//  Itis-FinApp
//
//  Created by Danil Gerasimov on 09.07.2021.
//

import UIKit

class MainScreenExpenseDetailViewController: UIViewController {
    @IBOutlet weak var expenseDetailTableView: UITableView!
    let defaults = UserDefaults.standard
    var operation: Operation?
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseDetailTableView.dataSource = self
        
    }
}
extension MainScreenExpenseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseDetailTableViewCell", for: indexPath) as? ExpenseDetailTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            cell.setData(name: "Название", data: operation?.name ?? "???")
        case 1:
            cell.setData(name: "Категория", data: operation?.category?.name ?? "???")
        case 2:
            cell.setData(name: "Сумма", data: operation?.money.description ?? "???")
        case 3:
            cell.setData(name:"Дата", data: operation?.date ?? "???")
        default:
            print(2)
        }
        return cell
    }
    
    
}
