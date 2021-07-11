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
    
    var pickedImage: String?
    let defaults = UserDefaults.standard
    
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
        categoryDefaults.append(Categories(name: name, image: pickedImage ?? "burger", totalSumm: 0))
        
        allTotalCounts.append(0)
    
        delegate?.updateCategoriesView()
        dismiss(animated: true)
    }
    
    
    
    @objc func imageViewTap() {
        guard let imagePickerViewController = storyboard?.instantiateViewController(withIdentifier: "ImagePickerViewController") as? ImagePickerViewController else {return}
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true)
    }
}

extension AddCategoryViewController: TapImageDelegate {
    func saveImageView(image: String) {
        pickerImageView.image = UIImage(named: image)
        pickedImage = image
    }
}


