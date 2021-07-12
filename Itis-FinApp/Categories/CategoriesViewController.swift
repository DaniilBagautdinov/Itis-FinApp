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
    
    var defaults = UserDefaults.standard
    var operations: [Operation] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeChart(dataPoints: categoryDefaults, values: allTotalCounts.map{ Float($0) })
    }
    
    func customizeChart(dataPoints: [Categories], values: [Float]) {
        pieChartView.legend.enabled = false
        pieChartView.highlightPerTapEnabled = false
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: Double(values[i]), label: dataPoints[i].name, data: dataPoints[i] as AnyObject)
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
        categoryDefaults.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell (withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        if indexPath.row != categoryDefaults.count {
            cell.setData(category: categoryDefaults[indexPath.row])
            return cell
        } else {
            cell.imageView.image = UIImage(systemName: "plus")
            cell.label.text = "Добавление"
            
            return cell
        }
    }
    // Проверять, если не посоедний, то заполнять обычно, а если ласт то отобразить кнопку
}

extension CategoriesViewController: AddCategoryViewControllerDelegate {
    func updateCategoriesView() {
        collectionView.reloadData()
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row != categoryDefaults.count {
            guard let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsCategoriesViewController") as? DetailsCategoriesViewController else {return}
            detailsViewController.categories = categoryDefaults[indexPath.row]
            
            navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            guard let addCategoryViewController = storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as? AddCategoryViewController else {return}
            addCategoryViewController.delegate = self
            present(addCategoryViewController, animated: true)
        }
    }
}

struct Categories: Codable {
    var name: String
    let image: String
    var totalSumm: Float
}

var categoryDefaults: [Categories] {
    get {
        guard let data = UserDefaults.standard.value(forKey: "categories") as? Data else { return [] }
        
        return try! PropertyListDecoder().decode(Array<Categories>.self, from: data)
    }
    set {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "categories")
    }
}

var allTotalCounts: [Float] {
    get {
        guard let data = UserDefaults.standard.value(forKey: "counts") as? Data else { return [0,0,0,0,0,0,0,0,0,0] }
        
        return try! PropertyListDecoder().decode(Array<Float>.self, from: data)
    }
    set {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "counts")
    }
}


