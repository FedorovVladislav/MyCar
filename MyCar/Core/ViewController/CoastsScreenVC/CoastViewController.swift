import UIKit


class CoastViewController: UITableViewController {
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 50
        setDataLables()
    }
    
    // MARK: - Storyboard element
    
    @IBOutlet weak var pricePerKilometr: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    @IBAction func addNewCoast(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addNewCoastViewController = mainStoryboard.instantiateViewController(withIdentifier: "yourVcName") as? AddNewCoastViewController {
            addNewCoastViewController.delegatedata = self
            show(addNewCoastViewController, sender: nil)
        }
    }
    
    // MARK: - Variable
    
    let coastData = CoastsData.shared
    

    // MARK: - обработка действий с моделью
    
    func addNewItemIntoModel(exist coastFromView: Coast){
        do {
            try coastData.addNewCoast(newCoast: coastFromView)
            alertSaveNewCoast(newCoast: coastFromView)
            tableView.reloadData()
        } catch { alertSaveNewCoast(newCoast: nil) }
    }
    
    func changeItemInModel(new coastFromView: Coast, index : Int){
        print ("changeItemStart")
        do {
            try  coastData.changeExistCoast (at: index, newCoast: coastFromView)
            alertSaveNewCoast(newCoast: coastFromView)
            tableView.reloadData()
        } catch { alertSaveNewCoast(newCoast: nil) }
    }
    
    func deleteItemInModel(at index: Int){
        do {
            try coastData.deleteDromModel(at: index)
            tableView.reloadData()
        } catch { alertSaveNewCoast(newCoast: nil) }
    }
    
    
    // MARK: - Работа с экраном
    //задаем надписи с расходом и пробегом
    func setDataLables(){
        let totalDistance = coastData.getTotalDistance()
        self.totalDistance.text = "Distance: \(totalDistance)km"
        let valuepricePerKilometr = coastData.getPricePerKilometrs()
        pricePerKilometr.text = "\(valuepricePerKilometr) ₽/km"
    }
    

    
    func edingCoastScreen(index : Int) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addNewCoastViewController = mainStoryboard.instantiateViewController(withIdentifier: "yourVcName") as? AddNewCoastViewController {
            addNewCoastViewController.changeCoast = coastData.getCoast(at: index)
            addNewCoastViewController.coastIndex = index
            addNewCoastViewController.delegatedata = self
            show(addNewCoastViewController, sender: nil)
        }
    }
    
    // MARK: - вывод данных
    
    // количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coastData.getCountCoasts()
    }
    //подготовка ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellsIdenteficator", for: indexPath) as! CoastTableViewCell
        cell.accessoryType = .detailButton
        
        guard let coast = coastData.getCoast(at: indexPath.row) else  { return cell }
       
        cell.setDataCell(coast: coast)
        
        return cell
    }
   
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
           deleteItemInModel(at: indexPath.row)
        }
    }
    
    
    // MARK: - Alert
    func alertSaveNewCoast(newCoast: Coast?){
        var alertView = UIAlertController()
        if let newCoast = newCoast {
            alertView = UIAlertController(title:"Add New Coast", message:"Name: \(newCoast.name)\n Odometr: \(newCoast.odometr)\n Price: \(newCoast.price)", preferredStyle: UIAlertController.Style.alert)
        } else{
            alertView = UIAlertController(title:"Error", message:"Repeat your action", preferredStyle: UIAlertController.Style.alert)
        }
            alertView.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: { ACTION -> Void in
            }))
            self.present(alertView, animated: true, completion: nil)
    }
    
}
    // MARK: - Extention

extension CoastViewController : CoastDataDelegate {
    func recidveCoast(new coastFromView: Coast, index : Int?) {

        if let index = index {
            changeItemInModel(new: coastFromView, index: index)
        } else { addNewItemIntoModel(exist: coastFromView) }
        // update rashod
        setDataLables()
    }
}
