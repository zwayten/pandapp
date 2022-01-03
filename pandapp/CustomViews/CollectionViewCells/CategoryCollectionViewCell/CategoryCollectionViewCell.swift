//
//  CategoryCollectionViewCell.swift
//  pandapp
//
//  Created by yassine zitoun on 2/1/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
   
    func setup(category: Clubs) {
        categoryTitleLbl.text = category.clubName
        let strImageUrl = "\(ConnectionDb.baserequest())upload/download/" + category.clubLogo
        let urlImage = URL(string: strImageUrl)
        let imageData = try? Data(contentsOf: urlImage!)
        ReusableFunctionsViewController.roundPicture(image: categoryImageView)
        categoryImageView.image = UIImage(data: imageData!)
    }
     

}
