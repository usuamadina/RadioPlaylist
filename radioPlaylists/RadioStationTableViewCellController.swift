//
//  RadioStationTableViewCellController.swift
//  radioPlaylists
//
//  Created by labdisca on 25/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit

class RadioStationTableViewCellController: UITableViewCell {
   
    @IBOutlet weak var name: UILabel!    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
