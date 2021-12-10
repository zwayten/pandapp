//
//  ClubMembersViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 3/12/2021.
//

import UIKit
import Alamofire
class ClubMembersViewController: UIViewController {

    var members = [ClubMembers]()
    var membersRequestingToJoin = [ClubMembers]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableViewJoin: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMembers()
        fetchMembersJoin()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchMembersJoin() {
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/join/false", method: .get, headers: headers).responseDecodable(of: [ClubMembers].self) { [weak self] response in
            self?.membersRequestingToJoin = response.value ?? []

            self?.tableViewJoin.reloadData()
        }
    }
    
    func fetchMembers() {
        let token = UserDefaults.standard.string(forKey: "tokenClub")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/join/true", method: .get, headers: headers).responseDecodable(of: [ClubMembers].self) { [weak self] response in
            self?.members = response.value ?? []

            self?.tableView.reloadData()
        }
    }
    
    func deleteMember(id: String) {
        //let token = UserDefaults.standard.string(forKey: "tokenClub")
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/\(id)", method: .delete, headers: headers).responseJSON { response in
            print("deleted")
        }
    }
    
    func acceptRequest(id: String){
        //let token = UserDefaults.standard.string(forKey: "tokenClub")
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())clubMembers/\(id)", method: .patch, headers: headers).responseJSON { response in
            print("user accepted")
        }
    }
}

extension ClubMembersViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return members.count
        } else {
            return membersRequestingToJoin.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell")
        let contentView =  cell?.contentView
        
        let image = contentView?.viewWithTag(1) as! UIImageView
        let memberName = contentView?.viewWithTag(2) as! UILabel
        
       
        ReusableFunctionsViewController.roundPicture(image: image)
        memberName.text = members[indexPath.row].userEmail
       
       
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + members[indexPath.row].memberPicture
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        image.image = UIImage(data: imageData!)
        return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "joinCell")
            let contentView =  cell?.contentView
            
            let image = contentView?.viewWithTag(1) as! UIImageView
            let memberName = contentView?.viewWithTag(2) as! UILabel

            
           
            ReusableFunctionsViewController.roundPicture(image: image)
            memberName.text = membersRequestingToJoin[indexPath.row].userEmail
           
           
            let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + membersRequestingToJoin[indexPath.row].memberPicture
            let urlImage = URL(string: strImageUrl)
            let imageData = try? Data(contentsOf: urlImage!)
            image.image = UIImage(data: imageData!)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == self.tableView {
        let declineAction = UIContextualAction(style: .destructive, title: nil) {  action, view, completionHandler in
            ReusableFunctionsViewController.displayAlert(title: "Delete Request", subTitle: "Are you sure to kick this member from the club  ?")
            self.deleteMember(id: self.members[indexPath.row]._id)
            self.members.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
       
            declineAction.image = UIImage(systemName: "person.fill.xmark")
            //acceptAction.image = UIImage(systemName: "person.fill.checkmark")
        return UISwipeActionsConfiguration(actions: [declineAction])
            
        } else {
            let declineAction = UIContextualAction(style: .destructive, title: nil) {  action, view, completionHandler in
               // ReusableFunctionsViewController.displayAlert(title: "Delete Request", subTitle: "Are you sure to decline this request ?")
                self.deleteMember(id: self.membersRequestingToJoin[indexPath.row]._id)
                self.membersRequestingToJoin.remove(at: indexPath.row)
                
                tableView.reloadData()
                completionHandler(true)
            }
            
            let acceptAction = UIContextualAction(style: .normal, title: nil) {  action, view, completionHandler in
                self.members.append(self.membersRequestingToJoin[indexPath.row])
                self.acceptRequest(id: self.membersRequestingToJoin[indexPath.row]._id)
                self.membersRequestingToJoin.remove(at: indexPath.row)
                self.tableView.reloadData()
                tableView.reloadData()
                completionHandler(true)
            }
            declineAction.image = UIImage(systemName: "person.fill.xmark")
            acceptAction.image = UIImage(systemName: "person.fill.checkmark")
            acceptAction.backgroundColor = .green
            
            return UISwipeActionsConfiguration(actions: [declineAction,acceptAction])
        }
        }
   
    }
    

