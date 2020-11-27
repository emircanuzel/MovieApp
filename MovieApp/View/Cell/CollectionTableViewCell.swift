//
//  CollectionTableViewCell.swift
//  MovieApp
//
//  Created by Emircan UZEL on 27.11.2020.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionCells : [Production_companies]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Initialization code
    }
    
    func loadCell(cell : [Production_companies])  {
        self.collectionCells?.removeAll()
        self.collectionCells = cell
        self.collectionView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCells?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.loadCollectionCell(text: self.collectionCells?[indexPath.item].name ?? "")
        return cell
    }
}
final class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func loadCollectionCell(text:String)  {
        self.containerView.shadow(spread: 10, color: UIColor.black.withAlphaComponent(0.1))
        self.containerView.corner(10)
        self.containerView.border(.black, 1)
        self.title.text = text
    }
}
