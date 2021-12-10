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
    var members = [ClubMembers]()
    var visitNameSegue: String?

    @IBOutlet var clubDesc: UITextView!
    @IBOutlet var imageview: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var clubNamelbl: UILabel!
    @IBOutlet var joinBtn: UIButton!
    @IBOutlet var join2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = UserDefaults.standard.string(forKey: "userName")
        joinBtn.isHidden = true
        fetchUsersAf()
        tableView.reloadData()
        fetchClubProfile()
        checkIfRequestSent(username:userName! , clubname: visitNameSegue!)
        
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
        AF.request("\(ConnectionDb.baserequest())event/\(cName!)", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []

            self?.tableView.reloadData()
        }
    }

    func fetchClubProfile() {
        //let token = UserDefaults.standard.string(forKey: "token")
       // let clubName = UserDefaults.standard.string(forKey: "clubName")
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club/clubByName/\(visitNameSegue!)", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            self?.clubNamelbl.text = self?.clubs[0].clubName
            self?.clubDesc.text = self?.clubs[0].description
            let strImageUrl = "http://192.168.109.1:3000/upload/download/" + (self?.clubs[0].clubLogo)!
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            self?.imageview.image = UIImage(data: imageData!)
            print(response)

            
        }
    }
 
    func checkIfRequestSent(username: String, clubname: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers", method: .get, headers: headers).responseDecodable(of: [ClubMembers].self) { [weak self] response in
            self?.members = response.value ?? []
            for m in self!.members {
                if m.userEmail == username && m.clubName == clubname {
                    let userName = UserDefaults.standard.string(forKey: "userName")
                    
                    if m.userEmail == userName && m.clubName == self?.visitNameSegue! && m.state == false {
                        self?.joinBtn.setTitle("Cancel Request", for: .normal)
                        self?.join2.isEnabled = false
                        self?.joinBtn.isHidden = false
                    } else if m.userEmail == userName && m.clubName == self?.visitNameSegue! && m.state == true {
                        self?.joinBtn.setTitle("Leave Club", for: .normal)
                        self?.join2.isEnabled = false
                        self?.joinBtn.isHidden = false
                    } else {
                        self?.joinBtn.isHidden = true
                    }
                }
                
            }
        }
    }
    
    func deleteMember(id: String) {
       // let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/\(id)", method: .delete, headers: headers).responseJSON { response in
            print("deleted")
        }
    }
    
    @IBAction func joinClub2(_ sender: Any) {
        let userName = UserDefaults.standard.string(forKey: "userName")
        let pic = UserDefaults.standard.string(forKey: "profilePicture")
        let joinInstantece = ClubMembers(clubName: clubs[0].clubName , userEmail: userName!, memberPicture: pic!, state: false, _id: "")
        let cmvm = ClubMembersViewModel()
        cmvm.addMemberToClub(club: joinInstantece)
    }
    @IBAction func joinClub(_ sender: Any) {
        
       
            for m in members {
                let userName = UserDefaults.standard.string(forKey: "userName")
               // let pic = UserDefaults.standard.string(forKey: "profilePicture")
                if m.userEmail == userName && m.clubName == visitNameSegue! && m.state == false {
                 deleteMember(id: m._id)
                } else if m.userEmail == userName && m.clubName == visitNameSegue! && m.state == true {
                 deleteMember(id: m._id)
                }
                
                
            }

    }


}

extension VisitClubProfileViewController: UITableViewDataSource, UITableViewDelegate {
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
        performSegue(withIdentifier: "toEventdetail", sender: _idSegue)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventdetail" {
            let _idSegue = sender as! String
            let destination = segue.destination as! EventDetailsViewController
            destination._idSegue = _idSegue
        }
    }
}
