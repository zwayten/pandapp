//
//  ModuleElearningViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 28/11/2021.
//

import UIKit
import Alamofire

class ModuleElearningViewController: UIViewController {
    var elearningTab = [Elearning]()
    
    var gradeSegue: String?
    var branchSegue: String?

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        print(gradeSegue!)
        print(branchSegue!)
        super.viewDidLoad()
        fetchModules()
        tableView.reloadData()
    }
    func fetchModules() {
        AF.request("\(ConnectionDb.baserequest())elearning", method: .get).responseDecodable(of: [Elearning].self) { [weak self] response in
            self?.elearningTab = response.value ?? []
  
            self?.tableView.reloadData()
        }
    }
    
}
extension ModuleElearningViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elearningTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coursesCell")
        let contentView =  cell?.contentView
        
        let module = contentView?.viewWithTag(1) as! UILabel
        //let coursename = contentView?.viewWithTag(2) as! UILabel
        
                
        //image.image = UIImage(named: users[indexPath.row].profilePicture)
        module.text = elearningTab[indexPath.row].module
        //coursename.text = elearningTab[indexPath.row].courseName
        
        //price.text = String(events[indexPath.row].price)

                return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passString = elearningTab[indexPath.row].module
        performSegue(withIdentifier:"toDetailModule" , sender: passString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailModule" {
                    let passString = sender as! String
                    let destination = segue.destination as! DetailModuleViewController
                    destination.moduleSegue = passString
                    
                    
                }
    }
}
