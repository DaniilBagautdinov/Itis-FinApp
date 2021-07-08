//
//  MainScreenViewController.swift
//  Itis-FinApp
//
//  Created by Artem Kalugin on 03.07.2021.
//

import UIKit

protocol SendTableViewToRefresh: AnyObject {
    func sendTableViewToRefresh(tableView: UITableView)
}

class MainScreenViewController: UIViewController {
    @IBOutlet weak var addFinButton: UIButton!
    @IBOutlet weak var allMoneyLabel: UILabel!
    @IBOutlet weak var spendingHistoryTableView: UITableView!
    
    let defaults = UserDefaults.standard
    var countOfExpenses: Int = 0
    weak var delegateTableView: SendTableViewToRefresh?
    
    @IBAction func addFinButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MainScreenAddViewController") as? MainScreenAddViewController else { return }
        delegateTableView = controller
        delegateTableView?.sendTableViewToRefresh(tableView: spendingHistoryTableView)
        present(controller, animated: true)
            
        countOfExpenses += 1
        spendingHistoryTableView.reloadData()
        
        allMoneyLabel.text = String(defaults.float(forKey: "allMoney"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        defaults.set(0, forKey: "allMoney")
        spendingHistoryTableView.dataSource = self
        
        let massive: [Operation] = []
        defaults.set(try? PropertyListEncoder().encode(massive), forKey: "operations")
        
        allMoneyLabel.text = "0.0"
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = defaults.array(forKey: "operations") as? [Operation] {
            return data.count
        }
//        print((defaults.array(forKey: "operations") as? [Operation])?.count)
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingHistoryTableViewCell", for: indexPath) as? SpendingHistoryTableViewCell else { return UITableViewCell() }
        if let data = defaults.array(forKey: "operations") as? [Operation] {
            cell.setData(expense: data[indexPath.row].money)
              }
        
        return cell
    }
}
