//
//  BrowseClubsViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/12/2021.
//

import UIKit
import Alamofire

class BrowseClubsViewController: UIViewController {

    var clubs = [Clubs]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchClubsAf()
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    func fetchClubsAf() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            //print(response)
            //print(response.value)
            self?.tableView.reloadData()
        }
    }

}

extension BrowseClubsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubBrowseCell")
        let contentView =  cell?.contentView
        let image = contentView?.viewWithTag(1) as! UIImageView
        let clubName = contentView?.viewWithTag(2) as! UILabel
        

                
        //image.image = UIImage(named: users[indexPath.row].profilePicture)
        clubName.text = clubs[indexPath.row].clubName
       
        //price.text = String(events[indexPath.row].price)
        ReusableFunctionsViewController.roundPicture(image: image)
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + clubs[indexPath.row].clubLogo
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
                
                return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clubNameSegue = clubs[indexPath.row].clubName
        performSegue(withIdentifier: "visitClubSeg", sender: clubNameSegue)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visitClubSeg" {
            let clubNameSegue = sender as! String
                        let destination = segue.destination as! VisitClubProfileViewController
                        
                        destination.visitNameSegue = clubNameSegue
                        
        }
    }
}
