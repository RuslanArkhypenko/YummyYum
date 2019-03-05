//
//  FavouriteRecipeTableViewCell.swift
//  YummyYum
//
//  Created by Ruslan Arhypenko on 3/2/19.
//  Copyright © 2019 Ruslan Arhypenko. All rights reserved.
//

import UIKit

class FavouriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.init(red: 246.0/255.0, green: 160.0/255.0, blue: 13.0/255.0, alpha: 1.0)
        self.selectedBackgroundView = selectedView
    }
}
