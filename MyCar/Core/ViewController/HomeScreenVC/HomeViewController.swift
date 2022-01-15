import UIKit

class HomeViewController: UIViewController {
    
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
    
    private func getWheatherData(){
        
        NetworkManager.getWeatherData { wheatherOut, temperature in
            
            guard let temperature = temperature else {return }
            self.outsideTemp = temperature
        }
    }
    
    private  func setButton(){
        
        engienButtonUIView.settingsState(tupeObjectName: "Engien", stateOnName: "Start", stateOffName: "Stop", iconOnName: "bolt.fill", iconOffName: "bolt.slash.fill", typeButton: .setEngien )
        lockCarButtonUIView.settingsState(tupeObjectName: "Car door", stateOnName: "Lock", stateOffName: "Unlock", iconOnName: "lock.fill", iconOffName: "lock.open.fill", typeButton: .setLockDoor)
        fanCarButtonUIView.settingsState(tupeObjectName: "Fan system", stateOnName: "Work", stateOffName: "Stop", iconOnName: "fanblades", iconOffName: "stop", typeButton: .setFanSystem)
    }
    
    // MARK: - Variable
    
    private var stateCarModel = StateCarModel()
    
    private var outsideTemp = 0.0 {
        
        didSet {
            DispatchQueue.main.async {
                self.OutsideTemperature.text = "Outside: \(self.outsideTemp.rounded0_X) C "
            }
        }
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
        DispatchQueue.main.sync {
            
            engienButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setEngien).boolValue)
            lockCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setLockDoor).boolValue)
            fanCarButtonUIView.setButtonState(state: carState.getStateEquipment(at: DataCarEquipment.setFanSystem).boolValue)
            self.rangeFuel.text = "Range: \(carState.getStateEquipment(at: DataCarEquipment.getFuilLevle)) km"
        }
    }
}

extension HomeViewController: ButtonDelegateData {
    func buttonPressed(typeButton : DataCarEquipment) {
        stateCarModel.setStateCar(set: typeButton)
    }
}

