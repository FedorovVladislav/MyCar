
import UIKit

class  CoastsViewController:  UIViewController {
    
    // MARK: - Storyboard element
    @IBOutlet weak var pricePerKilometr: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 50
        }
    }
    @IBAction func addNewCoastUIButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "addNewCoastVC") as? AddNewCoastViewController {
            vc.delegatedata = self
            show(vc, sender: nil)
        }
    }
    
    // MARK: - Variable
    let coastData = CoastsData.shared
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataLables()
    }
    
    // MARK: - обработка действий с моделью
    func addNewItemIntoModel(exist coastFromView: Coast) {
        do {
            try coastData.addNewCoast(newCoast: coastFromView)
            alertSaveNewCoast(newCoast: coastFromView)
            tableView.reloadData()
        } catch {
            alertSaveNewCoast(newCoast: nil)
        }
    }
    
    func changeItemInModel(new coastFromView: Coast, index : Int) {
        do {
            try  coastData.changeExistCoast (at: index, newCoast: coastFromView)
            alertSaveNewCoast(newCoast: coastFromView)
            tableView.reloadData()
        } catch {
            alertSaveNewCoast(newCoast: nil)
        }
    }
    
    func deleteItemInModel(at index: Int) {
        do {
            try coastData.deleteFromModel(at: index)
            tableView.reloadData()
        } catch {
            alertSaveNewCoast(newCoast: nil)
        }
    }
    
    // MARK: - Работа с экраном
    //задаем надписи с расходом и пробегом
    func setDataLables() {
        let totalDistance = coastData.getTotalDistance()
        self.totalDistance.text = String(totalDistance)
        
        let valuepricePerKilometr = coastData.getPricePerKilometrs()
        pricePerKilometr.text = String(valuepricePerKilometr)
    }
    
    // редактируем существующую запись на новом экране
    func edingCoastScreen(index : Int) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addNewCoastViewController = mainStoryboard.instantiateViewController(withIdentifier: "addNewCoastVC") as? AddNewCoastViewController {
            addNewCoastViewController.changeCoast = coastData.getCoast(at: index)
            addNewCoastViewController.coastIndex = index
            addNewCoastViewController.delegatedata = self
            show(addNewCoastViewController, sender: nil)
        }
    }
    
    // MARK: - Alert
    func alertSaveNewCoast(newCoast: Coast?) {
        
        var alertView = UIAlertController()
        
        if let newCoast = newCoast {
            alertView = UIAlertController(title:"Add New Coast", message:"Name: \(newCoast.name)\n Odometr: \(newCoast.odometr)\n Price: \(newCoast.price)", preferredStyle: UIAlertController.Style.alert)
        } else {
            alertView = UIAlertController(title:"Error", message: "Repeat your action" , preferredStyle: UIAlertController.Style.alert)
        }
            alertView.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: { ACTION -> Void in
            }))
            self.present(alertView, animated: true, completion: nil)
    }
}

    // MARK: - UITableViewDataSource
extension CoastsViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coastData.getCountCoasts()
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "CellsIdenteficator", for: indexPath) as? CoastTableViewCell {
        
             cell.accessoryType = .detailButton
        
             guard let coast = coastData.getCoast(at: indexPath.row) else  { return cell }
             cell.setDataCell(coast: coast)
             return cell
         }
         return UITableViewCell()
    }
}
    
    // MARK: - UITableViewDelegate
extension CoastsViewController: UITableViewDelegate {
    // окно для редактрования текущего расхода
     func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let currentCoast = coastData.getCoast(at: indexPath.row) else { return }
        edingCoastScreen(index: indexPath.row)
    }
    // удаление записи
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           deleteItemInModel(at: indexPath.row)
        }
    }
}

    // MARK: - Delegate Coast from View
extension CoastsViewController : CoastDataDelegate {
    
    func recidveCoast(new coastFromView: Coast, index : Int?) {
        if let index = index {
            changeItemInModel(new: coastFromView, index: index)
        } else {
            addNewItemIntoModel(exist: coastFromView)
        }
        // update total data
        setDataLables()
    }
}
