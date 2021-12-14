//
//  EventDetailsViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 6/12/2021.
//

import UIKit
import Alamofire

class EventDetailsViewController: UIViewController {

    var _idSegue: String?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var locationlbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var eventNamelbl: UILabel!
    @IBOutlet var descriptionlbl: UITextView!
    
    var eventInts = [EventInt]()
    var eventPost = [EventPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEventPostById(_id: _idSegue!)
        let email = UserDefaults.standard.string(forKey: "email")
        fetchparticipants(userEmail: email!)
        
        // Do any additional setup after loading the view.
    }
    
    func fetchEventPostById(_id: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event/eventById/\(_id)", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.eventPost = response.value ?? []
            self?.eventNamelbl.text = self?.eventPost[0].title
            self?.descriptionlbl.text = self?.eventPost[0].description
            self?.datelbl.text = self?.eventPost[0].Time
            self?.locationlbl.text = self?.eventPost[0].place
            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + (self?.eventPost[0].banner)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageView.image = UIImage(data: imageData!)
            
        }
    }
    
    func fetchparticipants(userEmail: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())eventInt/eventIntById/\(_idSegue!)", method: .get, headers: headers).responseDecodable(of: [EventInt].self) { [weak self] response in
            self?.eventInts = response.value ?? []
            self?.tableView.reloadData()
        }
}
    
    func saveParticipation(){
        let evm = EventIntViewModel()
        let email = UserDefaults.standard.string(forKey: "email")
        let evvinntt = EventInt(userEmail: email!, postId: _idSegue!, _id: "")
        evm.addEventParticipation(eventInt: evvinntt)
    }
    @IBAction func participate(_ sender: Any) {
        let evm = EventIntViewModel()
        let email = UserDefaults.standard.string(forKey: "email")
        let evvinntt = EventInt(userEmail: email!, postId: _idSegue!, _id: "")
        evm.addEventParticipation(eventInt: evvinntt)
    }
}
    
extension EventDetailsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return eventInts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "participantsCell")
            let contentView =  cell?.contentView
            
            let title = contentView?.viewWithTag(2) as! UILabel
            let image = contentView?.viewWithTag(1) as! UIImageView
                    
            //image.image = UIImage(named: users[indexPath.row].profilePicture)
            title.text = eventInts[indexPath.row].userEmail
            ReusableFunctionsViewController.roundPicture(image: image)
            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/default.png"
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            image.image = UIImage(data: imageData!)
                    
                    
                    return cell!
        }
        
        
    }
