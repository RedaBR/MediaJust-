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
       //addShadow()
    }
    private func addShadow() {
        viewCell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewCell.layer.shadowRadius = 2.0
        viewCell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewCell.layer.shadowOpacity = 2.0
    }
}
