//
//  SummaryTableViewCell.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var summary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.shadow(spread: 10, color: UIColor.black.withAlphaComponent(0.1))
        self.containerView.corner(10)
        self.containerView.border(.black, 1)
        // Initialization code
    }

    func loadCell(summary : String)  {
        self.summary.text = summary
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
