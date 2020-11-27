//
//  PopularFilmTableViewCell.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import UIKit

class PopularFilmTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var popularityValue: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.shadow(spread: 10, color: UIColor.black.withAlphaComponent(0.1))
        self.containerView.corner(15)
        self.containerView.border(.black, 1)
        // Initialization code
    }
    
    func loadCell(filmName:String , popularity:Double , index: Int)  {
        self.filmName.text = filmName
        let text = String(format: "%.2f", popularity)
        self.popularityValue.text = text
        if index == 0{
            self.cellImage.image = UIImage(named: "first")
        }else if index == 1{
            self.cellImage.image = UIImage(named: "second")
        }else if index == 2{
            self.cellImage.image = UIImage(named: "third")
        }else{
            self.cellImage.isHidden = true
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.cellImage.isHidden = false
    }

}
