import UIKit

protocol CoastDataDelegate {
    func recidveCoast(new coastFromView: Coast, index: Int?)
}

class AddNewCoastViewController: UIViewController  {
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeButton()
        //появление клавиатуры
        initOpenkeyboard()
        //CloseKeyboard
        initTapRecognisedForCloseKerboar()
    }
    
    // MARK: - Variable
    var delegatedata: CoastDataDelegate?
    var changeCoast : Coast?
    var coastIndex: Int?
    var typeCoast: TypeCoast?
    
    // MARK: - Storyboard element
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            guard let changeCoast = changeCoast else { return }
            nameTextField.text = changeCoast.name
        }
    }
    @IBOutlet weak var odometrTextField: UITextField! {
        didSet {
            odometrTextField.keyboardType = .numberPad
            odometrTextField.delegate = self
            guard let changeCoast = changeCoast else { return }
            odometrTextField.text = String(changeCoast.odometr)
        }
    }
    @IBOutlet weak var priceTextField: UITextField! {
        didSet {
            priceTextField.keyboardType = .numberPad
            priceTextField.delegate = self
            guard let changeCoast = changeCoast else { return }
            priceTextField.text = String(changeCoast.price)
        }
    }
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var typeCoastUIPickerView: UIPickerView! {
        didSet {
            typeCoastUIPickerView.delegate = self
            typeCoastUIPickerView.dataSource = self
            guard let changeCoast = changeCoast else { return }
            typeCoast = changeCoast.typeCoast
        }
    }
    @IBAction func saveCoast(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        //send new coast to our model
        guard let newCoast  = addNewCoast() else { return }
        delegatedata?.recidveCoast(new: newCoast, index: self.coastIndex)
    }
    
    // MARK: - Help function
    private func addNewCoast() -> Coast? {
        guard let name = nameTextField.text else { return nil }
        guard let odometr = Double(odometrTextField.text!) else { return nil }
        guard let price = Double(priceTextField.text!) else { return nil }
        guard let typeCoast = typeCoast else { return nil }
         
        return Coast(name: name, odometr: odometr, price: price, typeCoast: typeCoast)
    }
    
    private func activeButton() {
        let activate = nameTextField.text != "" && odometrTextField.text != "" && priceTextField.text != ""
        SaveButton.backgroundColor = activate ?  .green : .gray
        SaveButton.isEnabled = activate ? true : false
    }
    
    //MARK: - Open/Close  keyboard
    private func initOpenkeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func initTapRecognisedForCloseKerboar() {
        let tabScreen = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tabScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tabScreen)
    }
    
    @objc private func showKeyboard(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
        scrolView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc private func closeKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        scrolView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
    // MARK: - UITextFieldDelegate
extension AddNewCoastViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeButton()
    }
}
    // MARK: - UIPickerViewDataSource
extension AddNewCoastViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TypeCoast.allCases.count
    }
}
    // MARK: - UIPickerViewDelegate
extension AddNewCoastViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TypeCoast.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeCoast = TypeCoast.allCases[row]
    }
}
