//
//  HomeViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 7/11/2021.
//

import UIKit
import CloudKit

class HomeViewController: UIViewController {

   // var collection1Data = [String]()
    var collection1Data = ["Browse Clubs","Browse Lost and Found","Browse Maps","Logout"]
    var collection1DataPics = ["person.3.fill","person.fill.questionmark","map.fill","rectangle.portrait.and.arrow.right.fill"]
    var collection1Segue = ["browseClubsSegue","toLostandFound","browseMapSegue","browseClubsSegue"]
    let color2 = UIColor(red: 103/255, green: 24/255, blue: 24/255, alpha: 1)
    @IBOutlet var collection1: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homefirstcell", for: indexPath)
        let contentView =  cell.contentView
        contentView.backgroundColor = color2
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        let image = contentView.viewWithTag(1) as! UIImageView
        let titledata = contentView.viewWithTag(2) as! UILabel
        
        image.image = UIImage(systemName: collection1DataPics[indexPath.row])
        titledata.text = collection1Data[indexPath.row]
        
        return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collection1Data.count
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier:collection1Segue[indexPath.row] , sender: nil)
    }
    
}
