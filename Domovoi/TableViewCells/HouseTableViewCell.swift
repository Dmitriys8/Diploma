//
//  HouseTableViewCell.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 13/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var AdressField: UILabel!
    
    func fillCell(with model: HouseCellModel){
        AdressField.text = "House" + "\(model.ID ?? 1)"
    }
    
    

}
