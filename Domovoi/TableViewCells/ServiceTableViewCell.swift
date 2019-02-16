//
//  ServiceTableViewCell.swift
//  Domovoi
//
//  Created by Дмитрий Яковлев on 13/04/2018.
//  Copyright © 2018 Дмитрий Яковлев. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var ServiceLogo: UIImageView!
    @IBOutlet weak var Name: UILabel!
    
    func fillCell(with model: ServiceCellModel){
        Name.text = model.Name
    }

}
