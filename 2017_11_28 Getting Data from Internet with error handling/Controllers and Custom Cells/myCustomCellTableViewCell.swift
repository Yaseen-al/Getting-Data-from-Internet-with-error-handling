//
//  myCustomCellTableViewCell.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class myCustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactAge: UILabel!
    @IBOutlet weak var cellPhone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
