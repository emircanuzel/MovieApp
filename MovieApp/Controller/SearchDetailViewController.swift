//
//  SearchDetailViewController.swift
//  MovieApp
//
//  Created by Emircan UZEL on 26.11.2020.
//

import UIKit

protocol searchDelegate: class {
    func selected(id:Int , title:String , type:String)
}

class SearchDetailViewController: ViewController {
    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    var searchModel : SearchModel?
    var searchText: String?
    weak var delegate: searchDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.corner(15)
        self.searchTextField.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "GenericTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GenericTableViewCell")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.close))
        self.bg.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSearchList(key:String)  {
        let urlString = "https://api.themoviedb.org/3/search/multi?api_key=a8f2b271830886713bf596803001885a&language=en-US&query=\(key)&page=1&include_adult=false"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) {  (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let movieModel = try decoder.decode(SearchModel.self, from: data!)
                    self.searchModel = movieModel
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
extension SearchDetailViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell") as! GenericTableViewCell
        if self.searchModel?.results?[indexPath.item].media_type == "movie"{
            cell.loadCell(title: self.searchModel?.results?[indexPath.item].title ?? "", type: self.searchModel?.results?[indexPath.item].media_type ?? "")
        }else{
            cell.loadCell(title: self.searchModel?.results?[indexPath.item].name ?? "", type: self.searchModel?.results?[indexPath.item].media_type ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.selected(id: self.searchModel?.results?[indexPath.item].id ?? 0, title: self.searchModel?.results?[indexPath.item].name ?? "", type: self.searchModel?.results?[indexPath.item].media_type ?? "")
    }
}
extension SearchDetailViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            self.dismiss(animated: true, completion: nil)
        }
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        print(textFieldText.replacingCharacters(in: range, with: string))
        self.searchText = textFieldText.replacingCharacters(in: range, with: string)
        if let text = self.searchText{
            if text == "" {
                self.dismiss(animated: true, completion: nil)
            }else{
                self.getSearchList(key: text)
            }
        }
        return true;
    }
}
