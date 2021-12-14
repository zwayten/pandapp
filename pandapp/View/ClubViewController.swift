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
    var clubs = [Clubs]()

    @IBOutlet var clubDesc: UITextView!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var clubNamelbl: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchUsersAf()
        tableView.reloadData()
        fetchClubProfile()
        //setProfileInfos()
        
        ReusableFunctionsViewController.roundPicture(image: imageview)
        // Do any additional setup after loading the view.
    }
    
    
    func fetchUsersAf() {
        let token = UserDefaults.standard.string(forKey: "token")
        let cName = UserDefaults.standard.string(forKey: "clubName")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event/clubName/\(cName!)", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            self?.tableView.reloadData()
        }
    }

    func fetchClubProfile() {
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let clubName = UserDefaults.standard.string(forKey: "clubName")
        let clubLogin = UserDefaults.standard.string(forKey: "login")
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club/clubByLogin/\(clubLogin!)", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            self?.clubNamelbl.text = self?.clubs[0].clubName
            self?.clubDesc.text = self?.clubs[0].description
            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + (self?.clubs[0].clubLogo)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageview.image = UIImage(data: imageData!)
            
        }
    }
    
    func setProfileInfos() {
        //clubDesc.text = clubs[0]
        clubNamelbl.text = clubs[0].clubName
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + clubs[0].clubLogo
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        imageview.image = UIImage(data: imageData!)
    }
    
    //logout
    @IBAction func logoutClub(_ sender: UIButton) {
        //let destructiveAction =  UIAction(title: "desss", attributes: .destructive) { (_) in print("eeeeee destructive")}
        
       
        // pencil.and.ellipsis.rectangle
        //rectangle.portrait.and.arrow.right
        //popup menu
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Edit your profile", image: UIImage(systemName: "pencil.and.ellipsis.rectangle"), handler: { (_) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let updateprofile = storyboard.instantiateViewController(withIdentifier: "clubUpdateId")
                //vc.modalPresentationStyle = .fullScreen
                self.present(updateprofile, animated: true)
            }),
            UIAction(title: "Logout", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), handler: { (_) in
                UserDefaults.standard.set("", forKey: "login")
                UserDefaults.standard.set("", forKey: "passwordClub")
                UserDefaults.standard.set("", forKey: "tokenClub")
                UserDefaults.standard.set("", forKey: "clubName")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "initialNavigation")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            })
        ])

        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }
    
    

}
extension ClubViewController: UITableViewDataSource, UITableViewDelegate {
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
