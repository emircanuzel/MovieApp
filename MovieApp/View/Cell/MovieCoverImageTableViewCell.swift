//
//  MovieCoverImageTableViewCell.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import UIKit

class MovieCoverImageTableViewCell: UITableViewCell {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadCell(rating : Double , imageData : Data)  {
        if rating == 0{
            self.starImage.isHidden = true
            self.rating.isHidden = true
        }
        self.movieImage.image = UIImage(data: imageData)
        self.rating.text = "\(rating)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
