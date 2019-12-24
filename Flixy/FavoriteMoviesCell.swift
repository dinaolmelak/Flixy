//
//  FavoriteMoviesCell.swift
//  Flixy
//
//  Created by Dinaol Melak on 12/22/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit

class FavoriteMoviesCell: UITableViewCell {

    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieProfilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
