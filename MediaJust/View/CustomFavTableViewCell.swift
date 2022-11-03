//
//  CustomFavTableViewCell.swift
//  MediaJust
//
//  Created by Reda on 27/09/2022.
//

import UIKit

class CustomFavTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var viewCellFav: UIView!
    override func awakeFromNib() {
       super.awakeFromNib()
       addShadow()
    }
    private func addShadow() {
        viewCellFav.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        viewCellFav.layer.shadowRadius = 2.0
        viewCellFav.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        viewCellFav.layer.shadowOpacity = 2.0
    }
}
