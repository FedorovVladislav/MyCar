import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variable
    
    private var stateCarModel = StateCarModel()
    private let networkManager = NetworkManager()
    private var outsideTemp = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(self.outsideTemp.rounded0_X) C"
            }
        }
    }
    private var fuelRange = 0 {
        didSet {
            DispatchQueue.main.async {
                self.rangeFuel.text = "Range: \(self.fuelRange) km"
            }
        }
    }
    
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWheatherData()
        stateCarModel.setStateCar(set:  DataCarEquipment.getState)
        
        stateCarModel.delegate = self
        
        setButton()
        engienButtonUIView.delegate = self
        lockCarButtonUIView.delegate =  self
        fanCarButtonUIView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Method Work")
        LocalNotificationManager.share.deleteBagetCount()
        
    }
    
    private func getWheatherData() {
        networkManager.fetchweatherData() { weather, error in
            
            guard let temperature = weather?.main?.temp else {
                self.outsideTemp = 0
                return
            }
            self.outsideTemp = temperature - 273.15
        }
    }
    
    private  func setButton(){
        engienButtonUIView.settingsState(tupeObjectName: "Engien", stateOnName: "Start", stateOffName: "Stop", iconOnName: "bolt.fill", iconOffName: "bolt.slash.fill", typeButton: .setEngien )
        lockCarButtonUIView.settingsState(tupeObjectName: "Car door", stateOnName: "Lock", stateOffName: "Unlock", iconOnName: "lock.fill", iconOffName: "lock.open.fill", typeButton: .setLockDoor)
        fanCarButtonUIView.settingsState(tupeObjectName: "Fan system", stateOnName: "Work", stateOffName: "Stop", iconOnName: "fanblades", iconOffName: "stop", typeButton: .setFanSystem)
    }
    
    // MARK: - Storyboard element
    
    @IBOutlet weak var OutsideTemperature: UILabel!
    @IBOutlet weak var rangeFuel: UILabel!
    @IBOutlet weak var engienButtonUIView: ButtonSection!
    @IBOutlet weak var lockCarButtonUIView: ButtonSection!
    @IBOutlet weak var fanCarButtonUIView: ButtonSection!
}
   
    // MARK: - Extention

extension HomeViewController : changeStateCar {
    func stateCar(carState: StateCar) {
            engienButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setEngien).boolValue)
            lockCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setLockDoor).boolValue)
            fanCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setFanSystem).boolValue)
            fuelRange = carState.getStateEquipment(at: DataCarEquipment.getFuilLevle)
        
        LocalNotificationManager.share.getNotification(state: "Lol")
    }
}

extension HomeViewController: ButtonDelegateData {
    func buttonPressed(typeButton : DataCarEquipment) {
        stateCarModel.setStateCar(set: typeButton)
    }
}
