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
    
    let defaults = UserDefaults.standard
    var countOfExpenses: Int = 0
    weak var delegateTableView: SendTableViewToRefresh?

    @IBOutlet weak var spendingHistoryTableView: UITableView!
    @IBAction func addFinButtonAction(_ sender: Any) {

        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MainScreenAddViewController") as? MainScreenAddViewController else { return }
        delegateTableView = controller
        delegateTableView?.sendTableViewToRefresh(tableView: spendingHistoryTableView)
        present(controller, animated: true)
        
//        defaults.set(defaults.float(forKey: "allMoney") + 1000, forKey: "allMoney")
        allMoneyLabel.text = String(defaults.float(forKey: "allMoney"))
        countOfExpenses+=1
        spendingHistoryTableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        defaults.set(0, forKey: "allMoney")
        allMoneyLabel.text = String(defaults.float(forKey: "allMoney"))
        spendingHistoryTableView.dataSource = self
    }
}

extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = defaults.array(forKey: "operations") as? [Operation] {
            print(data.count)
            return data.count
        }
        print((defaults.array(forKey: "operations") as? [Operation])?.count)
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
