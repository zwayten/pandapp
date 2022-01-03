//
//  EventDetailsViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 6/12/2021.
//

import UIKit
import Alamofire
import Cosmos

class EventDetailsViewController: UIViewController {

    var _idSegue: String?
    var noteEvent = 0
    var ratetable = [RatePost]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var locationlbl: UILabel!
    @IBOutlet var datelbl: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var eventNamelbl: UILabel!
    @IBOutlet var descriptionlbl: UITextView!
    @IBOutlet weak var participateBtn: UIButton!
    @IBOutlet weak var notelbl: UILabel!
    
    var eventInts = [EventInt]()
    var eventPost = [EventPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ell id \(_idSegue)")
        fetchEventPostById(_id: _idSegue!)
        let email = UserDefaults.standard.string(forKey: "email")
        fetchparticipants(userEmail: email!)
        fetchRate()
        

        // Do any additional setup after loading the view.
    }
    
    
    
    func fetchEventPostById(_id: String) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event/id/\(_id)", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
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
    
    func fetchRate() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())ratePost/rate/\(_idSegue!)", method: .get, headers: headers).responseDecodable(of: [RatePost].self) { [weak self] response in
            self?.ratetable = response.value ?? []
            var moyenne = 1.0
            var somme = 0
            for item in self!.ratetable {
                somme += item.note
            }
            if self!.ratetable.count != 0 {
                moyenne = Double(somme / self!.ratetable.count)
            }
            
            self?.notelbl.text = "\(String(moyenne)) / 5"
            
        }
    }
    
    func checkRate() -> Bool {
        let email = UserDefaults.standard.string(forKey: "email")
        for item in ratetable {
            if item.userEmail == email! {
                return true
            }
        }
        return false
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
    
    func checkParticipation(checkEmail: String, postId: String) -> Bool {
        for interaction in eventInts {
            if interaction.postId == postId && interaction.userEmail == checkEmail {
                return true
            }
        }
        return false
    }
    
    @IBAction func participate(_ sender: Any) {
        
        let evm = EventIntViewModel()
        let email = UserDefaults.standard.string(forKey: "email")
        let evvinntt = EventInt(userEmail: email!, postId: _idSegue!, _id: "")
        let test = checkParticipation(checkEmail: email!, postId: _idSegue!)
        if test == true {
            ReusableFunctionsViewController.displayAlert(title: "Duplicate ", subTitle: "You can not participate more than once in an event")
            
        }
        else{
        evm.addEventParticipation(eventInt: evvinntt)
        }
    }
    
    
    @IBAction func rate(_ sender: Any) {
        let alert = UIAlertController(title: "Rate this Event", message: nil, preferredStyle: .actionSheet)
        let ratingView = CosmosView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        ratingView.rating = 0
        ratingView.settings.starSize = 30
        ratingView.settings.emptyBorderColor = UIColor.black
        ratingView.settings.updateOnTouch = true
        ratingView.frame.origin.x = alert.view.frame.width/2 - 100
        ratingView.frame.origin.y = 40
        ratingView.didFinishTouchingCosmos = { rating in
            self.noteEvent = Int(rating)
        }
        alert.addAction(UIAlertAction(title: "Rate", style: .default, handler: {
            (alert) in
            print("la note est :\(self.noteEvent)")
            let rpvm = RatePostViewModel()
            let email = UserDefaults.standard.string(forKey: "email")
            let rateInstance = RatePost(userEmail: email!, postId: self._idSegue!, note: self.noteEvent, _id: "")
            rpvm.ratePost(ratePost: rateInstance)
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        alert.view.addSubview(ratingView)
        let checkRate = checkRate()
        if checkRate == false {
            self.present(alert, animated: true, completion: nil)
        }
        else if checkRate == true{
                    ReusableFunctionsViewController.displayAlert(title: "Already rated", subTitle: "You can not rate more than once an event")
        }
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
