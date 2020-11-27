//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Emircan UZEL on 25.11.2020.
//

import UIKit

enum detailPageTableSection {
    case coverImage
    case summary
    case budget
    case popularity
    case originalTitle
    case collection
}

class DetailMovieViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var pageTitle : String = ""
    var movieId : Int?
    var cells = [detailPageTableSection]()
    var movieModel : MovieDetailModel?
    var imageData : Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "MovieCoverImageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieCoverImageTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SummaryTableViewCell")
        self.cells = [.coverImage,.originalTitle,.summary,.budget,.collection]
        self.getMovieDetail()
        // Do any additional setup after loading the view.
    }
    
    func getMovieDetail()  {
        guard let id = self.movieId , self.movieId != 0 else { return }
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=a8f2b271830886713bf596803001885a"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {  (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let movieModel = try decoder.decode(MovieDetailModel.self, from: data!)
                    self.movieModel = movieModel
                    print(self.movieModel?.original_title)
                    self.getMovieImage()
                }catch{
                    print("error json")
                }
            }else{
                let alert = UIAlertController(title: "Error", message: "Service Call Problem", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        dataTask.resume()
    }
    
    func getMovieImage()  {
        guard let path = self.movieModel?.poster_path  else { return }
        let urlString = "https://image.tmdb.org/t/p/w500\(path)"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {  (data, response, error) in
            if let error = error {
                print("Something went wrong: \(error)")
            }
            if let imageData = data {
                self.imageData = imageData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        dataTask.resume()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension DetailMovieViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = self.cells[indexPath.item]
        switch type {
        case .coverImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCoverImageTableViewCell") as! MovieCoverImageTableViewCell
            if let image = self.imageData {
                cell.loadCell(rating: self.movieModel?.vote_average ?? 0, imageData: image)
            }
            return cell
        case .summary:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let summary = self.movieModel?.overview {
                cell.loadCell(summary: "Summary : " + summary )
            }
            return cell
        case .popularity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let text = self.movieModel?.popularity {
                cell.loadCell(summary: "Popularity : \(text)" )
            }
            return cell
        case .budget:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let text = self.movieModel?.budget , let text2 = self.movieModel?.popularity {
                let text2 = String(format: "%.2f", text2)
                cell.loadCell(summary: "Budget : \(text)      Popularity : \(text2)" )
            }
            return cell
        case .originalTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let text = self.movieModel?.original_title {
                cell.loadCell(summary: "Original Title : " + text )
            }
            return cell
        case .collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as! CollectionTableViewCell
            if let genres = self.movieModel?.production_companies{
                cell.loadCell(cell: genres)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = self.cells[indexPath.item]
        switch type {
        case .coverImage:
            return 430
        case .summary:
            return 200
        case .popularity:
            return 75
        case .budget:
            return 75
        case .originalTitle:
            return 75
        case .collection:
            return 115
        }
    }
}
