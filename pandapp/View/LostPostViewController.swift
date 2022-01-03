//
//  LostPostViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/12/2021.
//

import UIKit
import Alamofire

class LostPostViewController: UIViewController {

    var lost = [LostPost]()
    var found = [LostPost]()
    var currentTab = [LostPost]()
    var curr = "lost"
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLostPosts()
        currentTab = lost
        fetchFoundPosts()
        tableView.reloadData()
    }
    @IBAction func addpost(_ sender: Any) {
        let se = curr
        performSegue(withIdentifier: "addlostPost", sender: se)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addlostPost" {
            let ss = sender as! String
            let destination = segue.destination as! AddLostPostViewController
            destination.currSegue = ss
        }
    }
    
    @IBAction func toggleTabs(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
                           
                   currentTab = lost
            curr = "lost"
            tableView.reloadData()
                       }else {
                           curr = "found"
                           currentTab = found
                           tableView.reloadData()
                       }
    }
    func fetchLostPosts() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())lostpost/lostFound/lost", method: .get, headers: headers).responseDecodable(of: [LostPost].self) { [weak self] response in
            self?.lost = response.value ?? []
            self?.currentTab = response.value ?? []
            self?.tableView.reloadData()
        }
    }
    
    func fetchFoundPosts() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())lostpost/lostFound/found", method: .get, headers: headers).responseDecodable(of: [LostPost].self) { [weak self] response in
            self?.found = response.value ?? []
            self?.tableView.reloadData()
        }
    }

}
extension LostPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lostCell")
        let contentView =  cell?.contentView
        
        let userPic = contentView?.viewWithTag(1) as! UIImageView
        let userName = contentView?.viewWithTag(2) as! UILabel
        let image = contentView?.viewWithTag(3) as! UIImageView
        let object = contentView?.viewWithTag(4) as! UILabel
        let place = contentView?.viewWithTag(5) as! UILabel
        
        
        userName.text = currentTab[indexPath.row].publisheId
        object.text = currentTab[indexPath.row].object
        place.text = currentTab[indexPath.row].place
                
        //image.image = UIImage(named: users[indexPath.row].profilePicture)
        ReusableFunctionsViewController.roundPicture(image: userPic)
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + currentTab[indexPath.row].image
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
        
                return cell!
    }
    
    
}
