//
//  GoArticlesTVCell.swift
//  ConCoreDataAsyncExample
//
//  Created by Stefan Glaser on 01.03.17.
//  Copyright © 2017 Stefan Glaser. All rights reserved.
//

import UIKit

class GoArticlesTVCell: UITableViewCell {

    
    @IBOutlet weak var kNameOutlet: UILabel!
    
    @IBOutlet weak var kImageOutlet: UIImageView!
    
    @IBOutlet weak var articelTypGruppe: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
