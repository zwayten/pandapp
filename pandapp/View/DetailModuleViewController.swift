//
//  DetailModuleViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 28/11/2021.
//

import UIKit
import Alamofire

class DetailModuleViewController: UIViewController {
    
    var moduleSegue : String?
    var elearningTab = [Elearning]()
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var modleName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        modleName.text = moduleSegue!
        fetchModules()
        tableView.reloadData()
        
    }
    
    func fetchModules() {
        AF.request("http://192.168.109.1:3000/elearning/byModule/\(moduleSegue!)", method: .get).responseDecodable(of: [Elearning].self) { [weak self] response in
            self?.elearningTab = response.value ?? []
            print(response)
            print(response.value)
            self?.tableView.reloadData()
        }
    }
   

}

extension DetailModuleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elearningTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailModuleCell")
        let contentView =  cell?.contentView
        
        let module = contentView?.viewWithTag(1) as! UILabel
        //let coursename = contentView?.viewWithTag(2) as! UILabel
        
                
        //image.image = UIImage(named: users[indexPath.row].profilePicture)
            module.text = elearningTab[indexPath.row].courseName
        
        
        //coursename.text = elearningTab[indexPath.row].courseName
        
        //price.text = String(events[indexPath.row].price)

                return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passString = elearningTab[indexPath.row].courseFile
        performSegue(withIdentifier:"openPdfSegue" , sender: passString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPdfSegue" {
                    let passString = sender as! String
                    let destination = segue.destination as! PdfViewController
                    destination.fileSegue = passString
                    
                    
                }
    }
    
    
}
