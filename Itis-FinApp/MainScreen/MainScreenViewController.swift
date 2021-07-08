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
        
        allMoneyLabel.text = String(defaults.float(forKey: "allMoney"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(0, forKey: "allMoney")
        spendingHistoryTableView.dataSource = self
        
        let massive: [Operation] = []
        defaults.set(try? PropertyListEncoder().encode(massive), forKey: "operations")
        
        allMoneyLabel.text = "0.0"
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
            cell.setData(expense: "\(allOperations?[indexPath.row].money ?? 0)", category: allOperations?[indexPath.row].category?.name ?? "???")
        }
        
        return cell
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
