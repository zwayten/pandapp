//
//  UserprofileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import Alamofire

class UserprofileViewController: UIViewController {

    //Circular image user profile:
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var userBio: UITextView!
    @IBOutlet weak var imageEmploi: UIImageView!
    
    var users = [User]()
    var emploi = [Emploi]()
    var events = [EventPost]()
    var postIds = [EventInt]()
    var tabid = [String]()
    
    
    func fetchpostParticipation() {
        let token = UserDefaults.standard.string(forKey: "token")
        let email = UserDefaults.standard.string(forKey: "email")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())eventInt/eventByUser/\(email!)", method: .get, headers: headers).responseDecodable(of: [EventInt].self) { [weak self] response in
            self?.postIds = response.value ?? []
            
            for items in self!.postIds {
                self?.tabid.append(items.postId)
                
            }
            
            //self?.tableView.reloadData()
        }
}
    
    func fetchEventPostById() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        let param = ["list": ["61b804035bc3f7b194ae576c"]] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())event/bylist", method: .get,parameters: param, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            
            
            
        }
    }
    
    func initProfile(){
        userImage.layer.borderWidth = 0
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
    }
    
    func fetchEmploi(classe: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())emploi/\(classe)", method: .get, headers: headers).responseDecodable(of: [Emploi].self) { [weak self] response in
            self?.emploi = response.value ?? []
            
           let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + (self?.emploi[0].picture)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageEmploi.image = UIImage(data: imageData!)
            
            
        }
    }
    
    
    func fetchEventsAf() {
        let token = UserDefaults.standard.string(forKey: "token")
       
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            self?.tableView.reloadData()
        }
    }
    
    
    func fetchClubProfile() {
        //let token = UserDefaults.standard.string(forKey: "token")
        let userName = UserDefaults.standard.string(forKey: "userName")
        let email = UserDefaults.standard.string(forKey: "email")
        print(userName!)
        print(email!)
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())user/userByEmail/\(email!)", method: .get, headers: headers).responseDecodable(of: [User].self) { [weak self] response in
            self?.users = response.value ?? []
            //print(self?.users.count)
            self?.userName.text = "\((self?.users[0].LastName)!) \((self?.users[0].FirstName)!)"
            self?.userBio.text = (self?.users[0].description)!
            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + (self?.users[0].profilePicture)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.userImage.image = UIImage(data: imageData!)
           
            
        }
    }
    @IBAction func logoutUser(_ sender: UIButton) {
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Edit your profile", image: UIImage(systemName: "pencil.and.ellipsis.rectangle"), handler: { (_) in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let updateprofile = storyboard.instantiateViewController(withIdentifier: "userUpdateProfileId")
                //vc.modalPresentationStyle = .fullScreen
                self.present(updateprofile, animated: true)
            }),
            UIAction(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), handler: { (_) in
                UserDefaults.standard.set("", forKey: "userName")
                UserDefaults.standard.set("", forKey: "email")
                UserDefaults.standard.set("", forKey: "identifant")
                UserDefaults.standard.set("", forKey: "password")
                UserDefaults.standard.set("", forKey: "token")
                UserDefaults.standard.set("", forKey: "classe")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "initialNavigation")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            })
        ])

        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let classe = UserDefaults.standard.string(forKey: "classe")
        fetchEmploi(classe: classe!)
        initProfile()
        fetchClubProfile()
        //fetchpostParticipation()
        //fetchEventPostById()
        fetchEventsAf()
    }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfile()
        fetchClubProfile()
        // Do any additional setup after loading the view.
    }
     */
    
}
extension UserprofileViewController: UITableViewDataSource, UITableViewDelegate {
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
        //let price = contentView?.viewWithTag(6) as! UILabel
                
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _idSegue = events[indexPath.row]._id
        //performSegue(withIdentifier: <#T##String#>, sender: _idSegue)
        print(_idSegue)
    }
    
}

