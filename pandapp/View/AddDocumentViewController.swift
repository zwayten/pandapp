//
//  AddDocumentViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 30/11/2021.
//

import UIKit
import Alamofire

class AddDocumentViewController: UIViewController {

    @IBOutlet var typelbl: UITextField!
    @IBOutlet var langlbl: UITextField!
    @IBOutlet var steppernumber: UIStepper!
    @IBOutlet var steppervaluedisplay: UILabel!
    
    var stepperValue = 0
    
    var docTable = [Document]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        steppernumber.value = 1
        ReusableFunctionsViewController.customTextField(textfield: typelbl)
        ReusableFunctionsViewController.customTextField(textfield: langlbl)
        
        fetchDocumentsByUserId()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    @IBAction func stepper(_ sender: UIStepper) {
        steppervaluedisplay.text = String(Int(sender.value))
        steppernumber.value = sender.value
        stepperValue = Int(sender.value)
    }
    
    func getData() -> Document {
        let type = typelbl.text!
        let lang = langlbl.text!
        let cn = stepperValue
        let date = "zz"
        let claimedId = UserDefaults.standard.string(forKey: "identifant")
        let doc = Document(documentType: type, claimedId: claimedId!, createdAT: date, numcopies: cn, docLanguage: lang, _id:"a")
        return doc
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if typelbl.text != "" || langlbl.text != "" {
        let docService = DocumentViewModel()
        docService.addDocument(Document: getData())
            fetchDocumentsByUserId()
            //tableView.reloadData()
            
        }
        else {
            ReusableFunctionsViewController.displayAlert(title: "Warning", subTitle: " Some data are missing")
        }
    }
    
    func fetchDocumentsByUserId() {
        let token = UserDefaults.standard.string(forKey: "token")
        let identifant = UserDefaults.standard.string(forKey: "identifant")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())document/\(identifant!)", method: .get, headers: headers).responseDecodable(of: [Document].self) { [weak self] response in
            self?.docTable = response.value ?? []
            self?.tableView.reloadData()
            print(response)
            print(response.value)
            
        }
    }
    
    
    func deleteDocumentRequest(id: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())document/\(id)", method: .delete, headers: headers).responseDecodable(of: [Document].self) { [weak self] response in
            
            self?.fetchDocumentsByUserId()
            print(response)
            print(response.value)
            
        }
    }
    
    
}
extension AddDocumentViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell")
        let contentView =  cell?.contentView
        
        let docType = contentView?.viewWithTag(1) as! UILabel
        let docLang = contentView?.viewWithTag(2) as! UILabel
        let docCopies = contentView?.viewWithTag(3) as! UILabel
        let date = contentView?.viewWithTag(4) as! UILabel
                
        docType.text = docTable[indexPath.row].documentType
        docLang.text = docTable[indexPath.row].docLanguage
        docCopies.text = String(docTable[indexPath.row].numcopies)
        date.text = docTable[indexPath.row].createdAT
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                ReusableFunctionsViewController.displayAlert(title: "Delete Request", subTitle: "Are you sure to Delete this Document Request ?")
                deleteDocumentRequest(id: docTable[indexPath.row]._id)
                //tableView.reloadData()
            }
        }
    
    
}
