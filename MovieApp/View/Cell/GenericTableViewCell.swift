//
//  GenericTableViewCell.swift
//  MovieApp
//
//  Created by Emircan UZEL on 26.11.2020.
//

import UIKit

class GenericTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.corner(5)
        self.containerView.border(.black, 1)
        // Initialization code
    }
    
    func loadCell(title:String , type:String)  {
        self.title.text = title
        self.type.text = type
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
