import UIKit

class HomeViewController: UIViewController {
    // MARK: - Storyboard element
    @IBOutlet weak var OutsideTemperature: UILabel!
    @IBOutlet weak var rangeFuel: UILabel!
    @IBOutlet weak var engienButtonUIView: ButtonSection! {
        didSet{
            print("DidSet")
            engienButtonUIView.settingsState(tupeObjectName: "Engien", stateOnName: "Start", stateOffName: "Stop", iconOnName: "bolt.fill", iconOffName: "bolt.slash.fill", typeButton: .setEngien )
            engienButtonUIView.delegate = self
        }
    }
    @IBOutlet weak var lockCarButtonUIView: ButtonSection! {
        didSet{
            lockCarButtonUIView.settingsState(tupeObjectName: "Car door", stateOnName: "Lock", stateOffName: "Unlock", iconOnName: "lock.fill", iconOffName: "lock.open.fill", typeButton: .setLockDoor)
            lockCarButtonUIView.delegate =  self
        }
    }
    @IBOutlet weak var fanCarButtonUIView: ButtonSection! {
        didSet {
            fanCarButtonUIView.settingsState(tupeObjectName: "Fan system", stateOnName: "Work", stateOffName: "Stop", iconOnName: "fanblades", iconOffName: "stop", typeButton: .setFanSystem)
            fanCarButtonUIView.delegate = self
        }
    }
    
    // MARK: - Variable
    private var stateCarModel = StateCarModel()
    private let networkManager = NetworkManager()
    private var outsideTemp = 0.0 {
        didSet {
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(((self.outsideTemp) - 273.15).rounded0_X) C"
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocalNotificationManager.share.deleteBagetCount()
    }
    
    private func getWheatherData() {
        networkManager.fetchweatherData() { weather, error in
            
            guard let temperature = weather?.main?.temp else {
                self.outsideTemp = 0
                return
            }
            self.outsideTemp = temperature
        }
    }
}
   
    // MARK: - Extention
extension HomeViewController : ChangeStateCarDelegate {
    func stateCar(carState: StateCar) {
            engienButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setEngien).boolValue)
            lockCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setLockDoor).boolValue)
            fanCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setFanSystem).boolValue)
            fuelRange = carState.getStateEquipment(at: DataCarEquipment.getFuilLevle)
        
        LocalNotificationManager.share.getNotification(state: "Lol")
    }
}
    // MARK: - Extention
extension HomeViewController: ButtonDelegate {
    func buttonPressed(typeButton : DataCarEquipment) {
        stateCarModel.setStateCar(set: typeButton)
    }
}
