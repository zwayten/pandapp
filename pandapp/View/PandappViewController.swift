//
//  PandappViewController.swift
//  pandapp
//
//  Created by yassine zitoun on 2/1/2022.
//

import UIKit
import Alamofire
class PandappViewController: UIViewController {
    
    var clubs = [Clubs]()
    var events = [EventPost]()
    var token: String?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchClubsAf()
        fetchEventsAf()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func map2(_ sender: Any) {performSegue(withIdentifier: "mapsegue", sender: nil)
    }
    func fetchEventsAf() {
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        if lastLogged! == "user" {
         token = UserDefaults.standard.string(forKey: "token")
        }
        else if lastLogged == "club" {
             token = UserDefaults.standard.string(forKey: "tokenClub")
            }
       
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())event", method: .get, headers: headers).responseDecodable(of: [EventPost].self) { [weak self] response in
            self?.events = response.value ?? []
            self?.eventCollectionView.reloadData()
        }
    }
    
    func fetchClubsAf() {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Accept": "application/json"
        ]
        AF.request("\(ConnectionDb.baserequest())club", method: .get, headers: headers).responseDecodable(of: [Clubs].self) { [weak self] response in
            self?.clubs = response.value ?? []
            //print(response)
            //print(response.value)
            self?.categoryCollectionView.reloadData()
        }
    }
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        eventCollectionView.register(UINib(nibName: EventCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        /*specialsCollectionView.register(UINib(nibName: DIshLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DIshLandscapeCollectionViewCell.identifier) */
    }

    @IBAction func map(_ sender: Any) {
        performSegue(withIdentifier: "map", sender: nil)
    }
    
}

extension PandappViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return clubs.count
        case eventCollectionView:
            return events.count
        case specialsCollectionView:
            return 0
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: clubs[indexPath.row])
            return cell
        
        case eventCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            cell.setup(dish: events[indexPath.row])
            return cell
            /*
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DIshLandscapeCollectionViewCell.identifier, for: indexPath) as! DIshLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
         */
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let clubNameSegue = clubs[indexPath.row].clubName
            performSegue(withIdentifier: "visitClubSeg1", sender: clubNameSegue)
           /* let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            */
        } else if collectionView == eventCollectionView {
            print("el indexxxxxxxx \(indexPath.row)")
            let _idSegue = events[indexPath.row]._id
            performSegue(withIdentifier: "Eventdetail", sender: _idSegue)
          /*  let controller = DishDetailViewController.instantiate()
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
           */
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visitClubSeg1" {
            let clubNameSegue = sender as! String
                        let destination = segue.destination as! VisitClubProfileViewController
                        
                        destination.visitNameSegue = clubNameSegue
                        
        }
        else if segue.identifier == "Eventdetail" {
            let _idSegue = sender as! String
            let destination = segue.destination as! EventDetailsViewController
            destination._idSegue = _idSegue
        }
        
    }
}
