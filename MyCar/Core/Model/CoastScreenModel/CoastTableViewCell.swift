//
//  CoastTableViewCell.swift
//  MyCar
//
//  Created by Елизавета Федорова on 14.11.2021.
//

import UIKit

class CoastTableViewCell: UITableViewCell {

    @IBOutlet weak var NameUILable: UILabel!
    @IBOutlet weak var odometrUILable: UILabel!
    @IBOutlet weak var priceUILable: UILabel!
    @IBOutlet weak var typeCoastUIImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func  setDataCell(coast: Coast) {
        
        NameUILable.text = coast.name
        odometrUILable.text = "\(coast.odometr) km"
        priceUILable.text = "\(coast.price) ₽"
        
        guard let typeCoast = coast.typeCoast else {
            typeCoastUIImageView.image = UIImage(systemName: "link.circle")
            return
        }
        
        switch typeCoast {
        case .repair:
            typeCoastUIImageView.image = UIImage(systemName: "gear" )
        case .tuning:
            typeCoastUIImageView.image = UIImage(systemName: "speedometer"  )
        case .to:
            typeCoastUIImageView.image = UIImage(systemName: "hammer.circle" )
        case .paidRoad:
            typeCoastUIImageView.image = UIImage(systemName: "dollarsign.circle" )
        case .insurance:
            typeCoastUIImageView.image = UIImage(systemName: "scroll" )
        }
    }
}
