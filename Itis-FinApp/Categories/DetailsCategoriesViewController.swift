//
//  DetailsCategoriesViewController.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 06.07.2021.
//

import UIKit

class DetailsCategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories: Categories?
    
    let defaults = UserDefaults.standard
    
    var operations: [Operation] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
            setData()

        }

        private func setData() {
            guard let data = defaults.value(forKey: "operations") as? Data else { return }
            guard let allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data) else { return }
            let operationsDictionary = Dictionary(grouping: allOperations, by: { $0.category?.name })
            guard let categories = categories else { return }
            operations = operationsDictionary[categories.name] ?? []
        }
}

extension DetailsCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell (withIdentifier: "DetailsCategorisTableViewCell", for: indexPath) as? DetailsCategorisTableViewCell else {return UITableViewCell()}
        cell.setData(operation: operations[indexPath.row])
        return cell
    }
}

extension DetailsCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
