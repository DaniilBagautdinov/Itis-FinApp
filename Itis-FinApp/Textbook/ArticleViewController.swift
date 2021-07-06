//
//  ArticleViewController.swift
//  Itis-FinApp
//
//  Created by Даниил Багаутдинов on 04.07.2021.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var articleTextView: UITextView!
    var textbook: TextbookCellData?
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTextView.isEditable = false
        articleTextView.text = textbook?.article
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        articleTextView.isScrollEnabled = false
    }
        
    override func viewDidAppear(_ animated: Bool) {
        articleTextView.isScrollEnabled = true
    }

}
