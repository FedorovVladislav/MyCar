import UIKit

protocol ButtonDelegateData {
    func buttonPressed(typeButton: DataCarEquipment )
}

class ButtonSection: UIView {

    //MARK: - Variable
    var delegate : ButtonDelegateData?
    var stateView : StateButton?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("View", owner: self, options: nil)
        addSubview(contensVIew)
        contensVIew.frame = self.bounds
        contensVIew.autoresizingMask = [.flexibleHeight, .flexibleWidth]
 
    }
    
    // MARK:  - Method
    func setButtonState(state: Bool){
       guard  let  stateView = stateView else {  return }
        typeLable.text = stateView.tupeObjectName
        if state {
            stateLable.text  = stateView.stateOnName
            ButtonUIButtonOutlet.setImage(UIImage(systemName: stateView.iconOnName), for: .normal)
            ButtonUIButtonOutlet.tintColor = .systemRed
        } else {
            stateLable.text  = stateView.stateOffName
            ButtonUIButtonOutlet.setImage(UIImage(systemName: stateView.iconOffName), for: .normal)
            ButtonUIButtonOutlet.tintColor = .systemBlue
        }
    }
    
    func settingsState(tupeObjectName: String, stateOnName : String, stateOffName : String, iconOnName : String, iconOffName : String, typeButton: DataCarEquipment){
        stateView = StateButton(tupeObjectName: tupeObjectName , stateOnName: stateOnName, stateOffName: stateOffName, iconOnName: iconOnName, iconOffName: iconOffName, typeButton: typeButton)
        setButtonState(state: false)
        ButtonUIButtonOutlet.backgroundColor = .systemGray5
    }
    
    // MARK: - Storyboard element
    @IBOutlet var contensVIew: UIView!
    @IBOutlet weak var stateLable: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var ButtonUIButtonOutlet: UIButton!
    @IBAction func actionButtonUIButton(_ sender: UIButton) {
        guard let stateView = stateView else { return }
        delegate?.buttonPressed(typeButton: stateView.typeButton)
    }
}
