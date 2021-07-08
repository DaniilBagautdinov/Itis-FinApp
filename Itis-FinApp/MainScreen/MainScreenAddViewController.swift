//
//  MainScreenAddViewController.swift
//  Itis-FinApp
//
//  Created by Artem Kalugin on 03.07.2021.
//

import UIKit

protocol MainScreenAddViewControllerDelegate: AnyObject {
    func updateSpendingHistoryTableView()
    func updateAllMoneyLabel()
}

class MainScreenAddViewController: UIViewController {
    @IBOutlet weak var finSegmentedControl: UISegmentedControl!
    @IBOutlet weak var moneyTextFiled: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    let defaults = UserDefaults.standard
    var selectedCategory: Categories?
    var isIncome: Bool = false
    var money: Float = 0
    var date: String = ""
    weak var delegate: MainScreenAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        selectedCategory = categories[0]
    }

    @IBAction func addButtonAction(_ sender: Any) {
        if finSegmentedControl.selectedSegmentIndex == 0 {
            isIncome = true
        }
        
        money = Float(moneyTextFiled.text ?? "0")!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        date = dateFormatter.string(from: Date())
        
        let operation = Operation(isIncome: isIncome, money: money, category: selectedCategory ?? Categories(name:"None", image:"burger", totalSumm: 0), date: date)
        
        if let data = defaults.value(forKey: "operations") as? Data {
            var allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
            allOperations?.append(operation)
            
            defaults.set(try? PropertyListEncoder().encode(allOperations), forKey: "operations")
            
            if operation.isIncome{
                defaults.set(defaults.float(forKey: "allMoney") + operation.money, forKey: "allMoney")
            } else{
                defaults.set(defaults.float(forKey: "allMoney") - operation.money, forKey: "allMoney")
            }
        }
        
        guard (storyboard?.instantiateViewController(identifier: "MainScreenViewController") as? MainScreenViewController) != nil else { return }
        delegate?.updateSpendingHistoryTableView()
        delegate?.updateAllMoneyLabel()
        dismiss(animated:true)
    }
}

extension MainScreenAddViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
}

extension MainScreenAddViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row].name
    }
}

struct Operation: Codable{
    var isIncome: Bool
    var money: Float
    var category: Categories?
    var date: String
}

