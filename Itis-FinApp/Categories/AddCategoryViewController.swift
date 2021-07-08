//
//  AddCategoryViewController.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 07.07.2021.
//

import UIKit

protocol AddCategoryViewControllerDelegate: AnyObject {
    func updateCategoriesView()
}

class AddCategoryViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerImageView: UIImageView!
    
    
    var category: Categories?
    weak var delegate: AddCategoryViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTap))
        pickerImageView.addGestureRecognizer(tap)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let name = textField.text else {return}
        categories.append(Categories(name: name, image: "burger", totalSumm: 0))
        delegate?.updateCategoriesView()
        dismiss(animated: true)
        
    }
    
    
    
    @objc func imageViewTap() {
        
    }
}


