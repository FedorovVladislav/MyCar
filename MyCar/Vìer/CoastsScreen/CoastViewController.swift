//
//  CoastViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 09.11.2021.
//

import UIKit

protocol coastDataDelegate{
    func recidveCoast(new coastFromView: Coast, index: Int?)
}

class CoastViewController: UITableViewController, coastDataDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        setDataLables()
    }
    
    // MARK: - переменные
    @IBOutlet weak var pricePerKilometr: UILabel!
    @IBOutlet weak var totalDistance: UILabel!    
    var coastData = CoastsData.shared
    

    // MARK: - обработка действий с моделью
    func recidveCoast(new coastFromView: Coast, index : Int?) {

        if let index = index{
            changeItemInModel(new: coastFromView, index: index)
        } else {
            addNewItemIntoModel(exist: coastFromView)
        }
        //update Table
        tableView.reloadData()
        // update rashod 
        setDataLables()
    }
    
    func addNewItemIntoModel(exist coastFromView: Coast){
        
        coastData.addNewCoast(newCoast: coastFromView)
        tableView.reloadData()
    }
    
    func changeItemInModel(new coastFromView: Coast, index : Int){

        coastData.changeExistCoast (at: index, newCoast: coastFromView)
        tableView.reloadData()
    }
    
    
    // MARK: - Работа с экраном
    //задаем надписи с расходом и пробегом
    func setDataLables(){
        let totalDistance = coastData.getTotalDistance()
        self.totalDistance.text = "Distance: \(totalDistance)km"
        let valuepricePerKilometr = coastData.getPricePerKilometrs()
        pricePerKilometr.text = "\(valuepricePerKilometr) ₽/km"
    }
    
    @IBAction func addNewCoast(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addNewCoastViewController = mainStoryboard.instantiateViewController(withIdentifier: "yourVcName") as? AddNewCoastViewController {
            addNewCoastViewController.delegatedata=self
            show(addNewCoastViewController, sender: nil)
        }
    }
    
    func edingCoastScreen(index : Int) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addNewCoastViewController = mainStoryboard.instantiateViewController(withIdentifier: "yourVcName") as? AddNewCoastViewController {
            addNewCoastViewController.changeCoast = coastData.getCoast(at: index)
            addNewCoastViewController.coastIndex = index
            addNewCoastViewController.delegatedata=self
            show(addNewCoastViewController, sender: nil)
        }
    }
    
    // MARK: - вывод данных
    
    // количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coastData.getCountCoasts()
    }
    //подготовка ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellsIdenteficator", for: indexPath) as! CoastTableViewCell
        cell.accessoryType = .detailButton
        
        guard let coast = coastData.getCoast(at: indexPath.row) else  {return cell}
        cell.NameUILable.text = coast.name
        cell.odometrUILable.text = "\(coast.odometr) km"
        cell.priceUILable.text = "\(coast.price) ₽"
        return cell
    }
    //подготовка к делииигрованию
    //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // if let vc2 = segue.destination as? AddNewCoastViewController {
    //    vc2.delegatedata = self
    //}
    //}
   
    // MARK: - редактирование ячеек
    
    // окно для редактрования текущего расхода
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let currentCoast = coastData.getCoast(at: indexPath.row) else { return  print ("Invalid index")}
        edingCoastScreen(index: indexPath.row)
    }
    // удаление записи
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            coastData.deleteDromModel(at: indexPath.row)
            //coastData.removeCoast(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
