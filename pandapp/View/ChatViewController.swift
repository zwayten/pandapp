//
//  ChatViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 1/12/2021.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController {

    var clubs = [ClubMembers]()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchClubs()
        // Do any additional setup after loading the view.
    }
    
    func fetchClubs() {
        let token = UserDefaults.standard.string(forKey: "token")
        let usermail = UserDefaults.standard.string(forKey: "email")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/findclubbyuser/\(usermail!)", method: .get, headers: headers).responseDecodable(of: [ClubMembers].self) { [weak self] response in
            self?.clubs = response.value ?? []
            self?.tableView.reloadData()
        }
    }


}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubRoomCell")
        let contentView =  cell?.contentView
        
        let image = contentView?.viewWithTag(1) as! UIImageView
        let clubName = contentView?.viewWithTag(2) as! UILabel
        
       
        ReusableFunctionsViewController.roundPicture(image: image)
        clubName.text = clubs[indexPath.row].clubName
       
       
       // let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + clubs[indexPath.row].
        let strImageUrl = "https://img-19.ccm2.net/WNCe54PoGxObY8PCXUxMGQ0Gwss=/480x270/smart/d8c10e7fd21a485c909a5b4c5d99e611/ccmcms-commentcamarche/20456790.jpg"
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
        return cell!
    }
    
    
}
