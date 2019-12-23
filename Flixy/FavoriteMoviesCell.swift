//
//  FavoriteMoviesCell.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/22/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit

class FavoriteMoviesCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
