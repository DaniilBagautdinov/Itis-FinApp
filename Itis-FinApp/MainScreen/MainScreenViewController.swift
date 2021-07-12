//
//  MainScreenViewController.swift
//  Itis-FinApp
//
//  Created by Artem Kalugin on 03.07.2021.
//

import UIKit


class MainScreenViewController: UIViewController {
    @IBOutlet weak var addFinButton: UIButton!
    @IBOutlet weak var allMoneyLabel: UILabel!
    @IBOutlet weak var spendingHistoryTableView: UITableView!
    
    let defaults = UserDefaults.standard
    var countOfExpenses: Int = 0
    
    @IBAction func addFinButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MainScreenAddViewController") as? MainScreenAddViewController else { return }
        controller.delegate = self
        present(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spendingHistoryTableView.tableFooterView = UIView()
        spendingHistoryTableView.dataSource = self
        spendingHistoryTableView.delegate = self
        
        allMoneyLabel.text = defaults.float(forKey: "allMoney").description
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = defaults.value(forKey: "operations") as? Data {
            let allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
            return allOperations?.count ?? 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingHistoryTableViewCell", for: indexPath) as? SpendingHistoryTableViewCell else { return UITableViewCell() }
        if let data = defaults.value(forKey: "operations") as? Data {
            let allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
            if let isIncome = allOperations?[indexPath.row].isIncome {
                var name = allOperations?[indexPath.row].name
                if name == ""{
                    name = allOperations?[indexPath.row].category?.name
                }
                
                if isIncome {
                    cell.setData(expense: "+\(allOperations?[indexPath.row].money ?? 0)", operationName: name ?? "???")
                    cell.expenseLabel.textColor = UIColor.systemGreen
                } else {
                    cell.setData(expense: "-\(allOperations?[indexPath.row].money ?? 0)", operationName: name ?? "???")
                    cell.expenseLabel.textColor = UIColor.systemRed
                }
            }
        }
        
        return cell
    }
}
extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spendingHistoryTableView.deselectRow(at: indexPath, animated: true)
        guard let mainScreenExpenseDetailViewController = storyboard?.instantiateViewController(identifier: "MainScreenExpenseDetailViewController") as? MainScreenExpenseDetailViewController else { return }
        if let data = defaults.value(forKey: "operations") as? Data {
            let allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
            mainScreenExpenseDetailViewController.operation = allOperations?[indexPath.row]
            navigationController?.pushViewController(mainScreenExpenseDetailViewController, animated: true)
        }
    }
}

extension MainScreenViewController: MainScreenAddViewControllerDelegate {
    func updateSpendingHistoryTableView() {
        spendingHistoryTableView.reloadData()
    }
    func updateAllMoneyLabel() {
        allMoneyLabel.text = defaults.float(forKey: "allMoney").description
    }
    
    
}
