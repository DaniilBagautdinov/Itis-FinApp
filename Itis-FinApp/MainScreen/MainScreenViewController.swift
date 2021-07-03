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
    
    let defaults = UserDefaults.standard

    @IBAction func addFinButtonAction(_ sender: Any) {
        allMoneyLabel.text = String(defaults.float(forKey: "allMoney"))

        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MainScreenAddViewController") as? MainScreenAddViewController else { return }

        present(controller, animated: true)
        
        defaults.set(defaults.float(forKey: "allMoney") + 1000, forKey: "allMoney")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set(0, forKey: "allMoney")
    }
}
