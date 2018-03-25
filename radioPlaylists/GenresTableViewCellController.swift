//
//  GenresTableViewCellController.swift
//  radioPlaylists
//
//  Created by labdisca on 24/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit

class GenresTableViewCellController: UITableViewCell {

    @IBOutlet weak var genreImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
