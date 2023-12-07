//
//  SearchTableViewCell.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 07/12/2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPosts: UIImageView!
    @IBOutlet weak var lblPostsTittle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
