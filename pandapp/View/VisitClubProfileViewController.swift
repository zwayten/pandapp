//
//  VisitClubProfileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/12/2021.
//

import UIKit
import Alamofire
class VisitClubProfileViewController: UIViewController {

    var events = [EventPost]()
    var clubs = [Clubs]()
    
    var visitNameSegue: String?

    @IBOutlet var clubDesc: UITextView!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var clubNamelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUsersAf()
        tableView.reloadData()
        fetchClubProfile()
        
        ReusableFunctionsViewController.roundPicture(image: imageview)

        // Do any additional setup after loading the view.
    }
    
    func fetchUsersAf() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            print(response)
            print(response.value)
            self?.tableView.reloadData()
        }
    }

    func fetchClubProfile() {
        let token = UserDefaults.standard.string(forKey: "token")
       // let clubName = UserDefaults.standard.string(forKey: "clubName")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "clubName": "\(visitNameSegue!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            self?.clubNamelbl.text = self?.clubs[0].clubName
            self?.clubDesc.text = self?.clubs[0].description
            let strImageUrl = "http://192.168.109.1:3000/upload/download/" + (self?.clubs[0].clubLogo)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageview.image = UIImage(data: imageData!)
            print(response)
            print(response.value)
            
        }
    }
 

}

extension VisitClubProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventReusableCell")
        let contentView =  cell?.contentView
        
        let title = contentView?.viewWithTag(1) as! UILabel
        let image = contentView?.viewWithTag(2) as! UIImageView
        let date = contentView?.viewWithTag(3) as! UILabel
        let location = contentView?.viewWithTag(4) as! UILabel
        let description = contentView?.viewWithTag(5) as! UITextView
        let price = contentView?.viewWithTag(6) as! UILabel
                
        //image.image = UIImage(named: users[indexPath.row].profilePicture)
        title.text = events[indexPath.row].title
        date.text = events[indexPath.row].Time
        location.text = events[indexPath.row].place
        description.text = events[indexPath.row].description
        //price.text = String(events[indexPath.row].price)
        
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + events[indexPath.row].banner
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
                
                
                return cell!
    }
    
    
}
