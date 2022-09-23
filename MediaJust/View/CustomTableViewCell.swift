//
//  CustomTableViewCell.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

   
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}
