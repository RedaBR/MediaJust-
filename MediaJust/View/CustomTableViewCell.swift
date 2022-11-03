//
//  CustomTableViewCell.swift
//  MediaJust
//
//  Created by Reda on 22/09/2022.
//

import UIKit
// MARK: - Custom cell result
class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCell: UIView!
override func setSelected(_ selected: Bool, animated: Bool) {
super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func awakeFromNib() {
       super.awakeFromNib()
    }
}
