//
//  ClientUserTableViewCell.swift
//  GymApp
//
//  Created by Eric Martin Gálan on 18/11/2018.
//  Copyright © 2018 Eric Martin Gálan. All rights reserved.
//

import UIKit

class ClientUserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageClientUser: UIImageView!
    @IBOutlet weak var nameClientUser: UILabel!
    @IBOutlet weak var telephoneClientUser: UILabel!
    @IBOutlet weak var emailClientUser: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
