//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Emircan UZEL on 24.11.2020.
//

import UIKit

class HomeViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    var popularMovie : PopularMovieModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "PopularFilmTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PopularFilmTableViewCell")
        self.getPopularMovieList()
        self.title = "Popular Movies"
        self.searchButton.border(.black, 1)
        self.searchButton.corner(15)
        self.stopLoading()
        // Do any additional setup after loading the view.
    }
    
    func getPopularMovieList()  {
        self.showLoading()
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=a8f2b271830886713bf596803001885a&language=en-US&page=1"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {  (data, response, error) in
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let movieModel = try decoder.decode(PopularMovieModel.self, from: data!)
                    self.popularMovie = movieModel
                    //                    print(self.popularMovie?.results?[0].title)
                    DispatchQueue.main.async{self.tableView.reloadData()}
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
        self.stopLoading()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller =  storyBoard.instantiateViewController(withIdentifier:"SearchDetailViewController") as! SearchDetailViewController
        
        controller.delegate = self
        let navigationController : UINavigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: false, completion: nil)
        
        
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
extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularMovie?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularFilmTableViewCell") as! PopularFilmTableViewCell
        cell.loadCell(filmName: self.popularMovie?.results?[indexPath.item].title ?? "-", popularity: self.popularMovie?.results?[indexPath.item].popularity ?? 0, index: indexPath.item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.popularMovie?.results?[indexPath.item].title ?? "-")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller =  storyBoard.instantiateViewController(withIdentifier:"DetailMovieViewController") as! DetailMovieViewController
        controller.pageTitle = self.popularMovie?.results?[indexPath.item].title ?? ""
        controller.movieId = self.popularMovie?.results?[indexPath.item].id ?? 0
        self.setNavigationBackButton()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
extension HomeViewController : searchDelegate{
    func selected(id: Int, title: String, type: String) {
        if type == "movie"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller =  storyBoard.instantiateViewController(withIdentifier:"DetailMovieViewController") as! DetailMovieViewController
            controller.pageTitle = title
            controller.movieId = id
            self.setNavigationBackButton()
            self.navigationController?.pushViewController(controller, animated: true)
        }else if type == "person"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller =  storyBoard.instantiateViewController(withIdentifier:"PersonDetailViewController") as! PersonDetailViewController
            controller.pageTitle = title
            controller.personId = id
            self.setNavigationBackButton()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}

