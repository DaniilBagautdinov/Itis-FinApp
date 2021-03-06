//
//  TextbookViewController.swift
//  Itis-FinApp
//
//  Created by Даниил Багаутдинов on 04.07.2021.
//

import UIKit

class TextbookViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var textArray: [String] = []
    var data: [TextbookCellData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFromFile()
        data = [TextbookCellData(title: "Куда вложить деньги? Что такое инвестиции?", image: "money", article: textArray[0]),
                TextbookCellData(title: "Что такое биткоин?", image: "bitcoin", article: textArray[1]),
                TextbookCellData(title: "Сколько стоит биткоин?", image: "purse", article: textArray[2]),
                TextbookCellData(title: "Как заработать с помощью биткоина?", image: "bitcoin-2", article: textArray[3]),
                TextbookCellData(title: "Банк хочет дать вам денег!", image: "pay", article: textArray[4]),
                TextbookCellData(title: "Как стать успешным предпринимателем?", image: "ownership", article: textArray[5]),
                TextbookCellData(title: "5 мифов о налоговых вычетах", image: "tax", article: textArray[6]),
                TextbookCellData(title: "Когда ждать возврата НДФЛ?", image: "calculator", article: textArray[7]),
                TextbookCellData(title: "Как получить налоговый вычет после COVID-19?", image: "virus", article: textArray[8]),
                TextbookCellData(title: "Как стать богатым и успешным?", image: "success", article: textArray[9]),
                TextbookCellData(title: "Как правильно взять кредит?", image: "credit-card", article: textArray[10]),
                TextbookCellData(title: "Стоит ли вам ввязываться в ипотеку?", image: "mortgage-2", article: textArray[11])]
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"Назад", style:.plain, target:nil, action:nil)
        
    }
    func readFromFile() {
        if let path = Bundle.main.path(forResource: "text", ofType: "txt") {
            if let text = try? String(contentsOfFile: path) {
                textArray = text.components(separatedBy: "\n\n")
            }
        }
    }
    
}

extension TextbookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let articleViewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {return}
        
        articleViewController.textbook = data[indexPath.row]
        
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
}

extension TextbookViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextbookTableViewCell", for: indexPath) as? TextbookTableViewCell else {return UITableViewCell()}
        cell.setData(textBook: data[indexPath.row])
        return cell
    }
}

struct TextbookCellData {
    let title: String
    let image: String
    let article: String
}
