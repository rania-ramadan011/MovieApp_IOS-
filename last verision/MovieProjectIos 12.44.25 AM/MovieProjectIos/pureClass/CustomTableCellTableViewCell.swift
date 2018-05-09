//
//  CustomTableCellTableViewCell.swift
//  MovieProjectIos
//
//  Created by Sayed Abdo on 4/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class CustomTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var AuthorOult: UILabel!
    @IBOutlet weak var Content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
