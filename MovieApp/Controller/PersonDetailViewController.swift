//
//  PersonDetailViewController.swift
//  MovieApp
//
//  Created by Emircan UZEL on 26.11.2020.
//

import UIKit



class PersonDetailViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var pageTitle : String = ""
    var cells = [detailPageTableSection]()
    var movieImage: String?
    var imageData : Data?
    var personDetailModel : PersonDetailModel?
    var personId : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        self.tableView.register(UINib(nibName: "MovieCoverImageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieCoverImageTableViewCell")
        self.tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SummaryTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.cells = [.coverImage,.originalTitle,.summary,.popularity,.budget]
        self.getPersonDetail()
        // Do any additional setup after loading the view.
    }
    
    func getPersonDetail()  {
        guard let id = self.personId , self.personId != 0 else { return }
        let urlString = "https://api.themoviedb.org/3/person/\(id)?api_key=a8f2b271830886713bf596803001885a&language=en-US"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {  (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let movieModel = try decoder.decode(PersonDetailModel.self, from: data!)
                    self.personDetailModel = movieModel
                    self.getPersonImage()
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
    
    func getPersonImage()  {
        guard let path = self.personDetailModel?.profile_path  else { return }
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
extension PersonDetailViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.cells[indexPath.item]
        switch type {
        case .coverImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCoverImageTableViewCell") as! MovieCoverImageTableViewCell
            if let image = self.imageData {
                cell.loadCell(rating:0, imageData: image)
            }
            return cell
        case .summary:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let summary = self.personDetailModel?.biography {
                cell.loadCell(summary: "Biography : " + summary )
            }
            
            
            return cell
        case .popularity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let text = self.personDetailModel?.place_of_birth{
                cell.loadCell(summary: "Place Of Birth : \(text)" )
            }
            return cell
        case .budget:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            var text2: String = ""
            if let text = self.personDetailModel?.birthday  {
                if self.personDetailModel?.deathday == nil{
                    text2 = "alive"
                }else{
                    text2 = self.personDetailModel?.deathday ?? ""
                }
                cell.loadCell(summary: "Birthday : \(text)  Deathday : \(text2)" )
            }
            return cell
        case .originalTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell") as! SummaryTableViewCell
            if let text = self.personDetailModel?.popularity {
                let text2 = String(format: "%.2f", text)
                cell.loadCell(summary: "Popularity : " + text2 )
            }
            
            return cell
        case .collection:
          return UITableViewCell()
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
