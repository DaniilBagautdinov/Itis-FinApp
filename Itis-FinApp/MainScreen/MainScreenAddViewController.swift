//
//  MainScreenAddViewController.swift
//  Itis-FinApp
//
//  Created by Artem Kalugin on 03.07.2021.
//

import UIKit

class MainScreenAddViewController: UIViewController {
    var categories: [String] = ["Фастфуд", "Здоровье", "Продукты", "Алкоголь", "Транспорт", "Образование", "Спорт", "Одежда", "Развлечения", "Кафе"]
    
    @IBOutlet weak var finSegmentedControl: UISegmentedControl!
    @IBOutlet weak var moneyTextFiled: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    let defaults = UserDefaults.standard
    var selectedCategory: String = ""
    var isIncome: Bool = false
    var money: Float = 0
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        selectedCategory = categories[0]
        
        var massive: [Operation] = []
        defaults.set(try? PropertyListEncoder().encode(massive), forKey: "operations")
    }

    @IBAction func addButtonAction(_ sender: Any) {
        if finSegmentedControl.selectedSegmentIndex == 0 {
            isIncome = true
        }
        
        money = Float(moneyTextFiled.text ?? "0")!
        let operation = Operation(isIncome: isIncome, money: money, category: selectedCategory)
        
        if let data = defaults.value(forKey: "operations") as? Data {
            var allOperations = try? PropertyListDecoder().decode(Array<Operation>.self, from: data)
            allOperations?.append(operation)
            defaults.set(try? PropertyListEncoder().encode(allOperations), forKey: "operations")
        }
        
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
        categories[row]
    }
}

struct Operation: Codable{
    var isIncome: Bool
    var money: Float
    var category: String
//    var date: NSDate
}
