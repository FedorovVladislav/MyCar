//
//  AddNewCoastViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 06.11.2021.
//

import UIKit

class AddNewCoastViewController: UIViewController, UITextFieldDelegate {
    
    var delegatedata: coastDataDelegate?
    var changeCoast : Coast?
    var coastIndex: Int?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var odometrTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBAction func saveCoast(_ sender: UIButton) {
        
        guard let name = nameTextField.text else {return}
        guard let odometr = Double (odometrTextField.text!) else {return}
        guard let price = Double (priceTextField.text!) else {return}
        let newCoast = Coast(name: name, odometr: odometr, price: price)
        //send new coast to our model
        delegatedata?.recidveCoast(new:newCoast, index: self.coastIndex)
        //alert and  Return Back to tableview
        alertSaveNewCoast(newCoast: newCoast)
      
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //если мы редактируем, а не создаем то нам нужно заполнить поля редактруемыми данными
        if let changeCoastTemp = changeCoast {
            nameTextField.text = changeCoastTemp.name
            odometrTextField.text = String(changeCoastTemp.odometr)
            priceTextField.text = String(changeCoastTemp.price)
        }
        
        //Настраиваем кнопку
        activeButton(activate: false)
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
    }
    
    func activeButton(activate : Bool){
        if activate {
            SaveButton.backgroundColor = .green
            SaveButton.isEnabled = true
        } else {
            SaveButton.backgroundColor = .gray
            SaveButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextField.text != "" && odometrTextField.text != "" && priceTextField.text != ""  {
           activeButton(activate: true)
            
        } else{ activeButton(activate: false)}
    }
    
    func initOpenkeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
}
    
    func initTapRecognisedForCloseKerboar(){
        let tabScreen = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tabScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tabScreen)
    }
    
    @objc func showKeyboard(_ notification: Notification){
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
        scrolView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc func closeKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
        scrolView.contentOffset = CGPoint(x: 0, y: 0)
    }

    func alertSaveNewCoast(newCoast: Coast){
        let alertView = UIAlertController(title:"Add New Coast", message:"Name: \(newCoast.name)\n Odometr: \(newCoast.odometr)\n Price: \(newCoast.price)", preferredStyle: UIAlertController.Style.alert)
            alertView.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: { ACTION -> Void in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertView, animated: true, completion: nil)
    }
}

    


