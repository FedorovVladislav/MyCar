//
//  AddNewCoastViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 06.11.2021.
//

import UIKit

class AddNewCoastViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //если мы редактируем, а не создаем то нам нужно заполнить поля редактруемыми данными
        if let changeCoastTemp = changeCoast {
            nameTextField.text = changeCoastTemp.name
            odometrTextField.text = String(changeCoastTemp.odometr)
            priceTextField.text = String(changeCoastTemp.price)
        }
        
        //Настраиваем кнопку
        activeButton()
        self.odometrTextField.keyboardType = .numberPad
        self.priceTextField.keyboardType = .decimalPad
        //появление клавиатуры
        initOpenkeyboard()
        //CloseKeyboard
        initTapRecognisedForCloseKerboar()
        // делигирование
        nameTextField.delegate = self
        odometrTextField.delegate = self
        priceTextField.delegate = self
        typeCoastUIPickerView.delegate = self
        typeCoastUIPickerView.dataSource = self
    }
    
    var delegatedata: CoastDataDelegate?
    var changeCoast : Coast?
    var coastIndex: Int?
    var typeCoast: TypeCoast?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var odometrTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var typeCoastUIPickerView: UIPickerView!
    
    @IBAction func saveCoast(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        //send new coast to our model
        guard let newCoast  = addNewCoast() else { return }
        delegatedata?.recidveCoast(new: newCoast , index: self.coastIndex)
    }
    
    // MARK: - Help function
    private func addNewCoast() -> Coast? {
        guard let name = nameTextField.text else { return nil }
        guard let odometr = Double(odometrTextField.text!) else { return nil }
        guard let price = Double(priceTextField.text!) else { return nil }
        guard let typeCoast = typeCoast else { return nil }
         
        return Coast(name: name, odometr: odometr, price: price, typeCoast: typeCoast)
    }
    
    private func activeButton(){
        let activate = nameTextField.text != "" && odometrTextField.text != "" && priceTextField.text != ""
        SaveButton.backgroundColor = activate ?  .green : .gray
        SaveButton.isEnabled = activate ? true : false
    }
    
    //MARK: - Open/Close  keyboard
    private func initOpenkeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
}
    
    private func initTapRecognisedForCloseKerboar(){
        let tabScreen = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tabScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tabScreen)
    }
    
    @objc private func showKeyboard(_ notification: Notification){
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
        scrolView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc private func closeKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
        scrolView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
extension AddNewCoastViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeButton()
    }
}
    
extension AddNewCoastViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TypeCoast.allCases.count
    }
}

extension AddNewCoastViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TypeCoast.allCases[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.typeCoast = TypeCoast.allCases[row]
    }
}

