//
//  ClubViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/11/2021.
//

import UIKit
import Alamofire


class ClubViewController: UIViewController {
    
    var events = [EventPost]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersAf()
        
        tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    func fetchUsersAf() {
        AF.request("http://192.168.109.1:3000/event", method: .get).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            print(response)
            print(response.value)
            
           // print(self!.events.count)
            self?.tableView.reloadData()
        }
    }



}
extension ClubViewController: UITableViewDataSource {
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
        
        let strImageUrl = "http://192.168.109.1:3000/upload/download/" + events[indexPath.row].banner
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
                
                
                return cell!
    }
    
    
}
