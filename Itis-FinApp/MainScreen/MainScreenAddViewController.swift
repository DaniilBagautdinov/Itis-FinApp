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
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var warningLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var selectedCategory: Categories?
    var isIncome: Bool = false
    var money: Float = 0
    var name: String = ""
    var date: String = ""
    weak var delegate: MainScreenAddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        selectedCategory = categoryDefaults[0]
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        print(isMoneyValid(money: moneyTextFiled.text))
        if isMoneyValid(money: moneyTextFiled.text){
            
            money = Float(moneyTextFiled.text ?? "0")!
            name = makeValidName(name: nameTextFiled.text)
            
            if finSegmentedControl.selectedSegmentIndex == 0 {
                isIncome = true
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            date = dateFormatter.string(from: Date())
            
            let operation = Operation(isIncome: isIncome, money: money, category: selectedCategory ?? Categories(name:"None", image:"burger", totalSumm: 0), date: date, name: name)
            
            if let data = defaults.value(forKey: "operations") as? Data {
                var allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
                allOperations?.append(operation)
                
                defaults.set(try? PropertyListEncoder().encode(allOperations), forKey: "operations")
                
                if operation.isIncome{
                    defaults.set(defaults.float(forKey: "allMoney") + operation.money, forKey: "allMoney")
                } else{
                    defaults.set(defaults.float(forKey: "allMoney") - operation.money, forKey: "allMoney")
                }
            } else {
                let massive: [Operation] = [operation]
                defaults.set(try? PropertyListEncoder().encode(massive), forKey: "operations")
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
            
            totalCount(category: selectedCategory!, operation: operation)
        } else{
            warningLabel.text = "Некорректная сумма"
        }
    }
    
    func makeValidName(name: String?) -> String{
        return name ?? ""
    }
    
    func isMoneyValid(money: String?) -> Bool{
        if money == nil{
            return false
        }
        
        guard let floatFromString = Float(money!) else { return false }
        
        return true
    }
    
    func totalCount(category: Categories, operation: Operation) -> Void{
        if !operation.isIncome{
            for i in 0..<categoryDefaults.count{
                if category.name == categoryDefaults[i].name{
                    categoryDefaults[i].totalSumm += operation.money
                    
                    updateTotalCountsMassive()
                }
            }
        }
    }
    
    func updateTotalCountsMassive(){
        allTotalCounts = []
        
        for category in categoryDefaults{
            allTotalCounts.append(category.totalSumm)
        }
    }
}

extension MainScreenAddViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categoryDefaults.count
    }
}

extension MainScreenAddViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryDefaults[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categoryDefaults[row].name
    }
}

struct Operation: Codable{
    var isIncome: Bool
    var money: Float
    var category: Categories?
    var date: String
    var name: String
}

