//
//  EventCollectionViewCell.swift
//  pandapp
//
//  Created by yassine zitoun on 2/1/2022.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    static let identifier = String(describing: EventCollectionViewCell.self)
    func setup(dish: EventPost) {
        titleLbl.text = dish.title
        
        caloriesLbl.text = "rate : \(String(dish.rate)) / 5 "
        descriptionLbl.text = dish.Time
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + dish.banner
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        dishImageView.image = UIImage(data: imageData!)
        
    }
   

}
