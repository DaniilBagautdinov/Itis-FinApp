//
//  CategoriesViewController.swift
//  Itis-FinApp
//
//  Created by Семен Соколов on 05.07.2021.
//

import UIKit
import Charts


class CategoriesViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Categories] = [
        Categories(name: "Фастфуд", image: "burger", totalSumm: 0),
        Categories(name: "Здоровье", image: "hospital", totalSumm: 0),
        Categories(name: "Продукты", image: "shopping-cart", totalSumm: 0),
        Categories(name: "Алкоголь", image: "beer-bottle", totalSumm: 0),
        Categories(name: "Транспорт", image: "van", totalSumm: 0),
        Categories(name: "Образование", image: "mortarboard", totalSumm: 0),
        Categories(name: "Спорт", image: "football-ball", totalSumm: 0),
        Categories(name: "Одежда", image: "kurta", totalSumm: 0),
        Categories(name: "Развлечения", image: "kite", totalSumm: 0),
        Categories(name: "Кафе", image: "coffee-cup", totalSumm: 0)
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
      let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      // 4. Assign it to the chart’s data
      pieChartView.data = pieChartData
    }
}

private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
  var colors: [UIColor] = []
  for _ in 0..<numbersOfColor {
    let red = Double(arc4random_uniform(256))
    let green = Double(arc4random_uniform(256))
    let blue = Double(arc4random_uniform(256))
    let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    colors.append(color)
  }
  return colors
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count // count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell (withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        cell.setData(category: categories[indexPath.row])
                return cell
    }
    // Проверять, если не посоедний, то заполнять обычно, а если ласт то отобразить кнопку
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let categoriesViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsCategoriesViewController") as? DetailsCategoriesViewController else {return}
        categoriesViewController.categories = categories[indexPath.row]
        
        navigationController?.pushViewController(categoriesViewController, animated: true)
    }
}

struct Categories {
    let name: String
    let image: String
    var totalSumm: Int
}

let players = ["Развлечения", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
let goals = [6, 8, 26, 30, 8, 10]
