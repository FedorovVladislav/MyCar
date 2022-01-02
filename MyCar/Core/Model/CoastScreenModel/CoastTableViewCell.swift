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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
