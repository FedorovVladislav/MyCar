//
//  ProfileViewController.swift
//  MyCar
//
//  Created by Елизавета Федорова on 28.10.2021.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    var uiImaget = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let myImage = UIImage(named: "arrow-right-310628__480") else {return}
        uiImaget.contentMode = .scaleAspectFit
        uiImaget.image = myImage
        view.addSubview(uiImaget)
        uiImaget.translatesAutoresizingMaskIntoConstraints = false
        uiImaget.widthAnchor.constraint(equalToConstant: 100).isActive = true
        uiImaget.heightAnchor.constraint(equalTo: uiImaget.widthAnchor).isActive = true
        uiImaget.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        uiImaget.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        uiImaget.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        //
    }
    
    
}


