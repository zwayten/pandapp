//
//  ReusableFunctionsViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit
import SCLAlertView

class ReusableFunctionsViewController: UIViewController {

    
    // textfield with bottomLine red
   
    
    // textfield with bottomLine green
    
    
    
    
    static func radioButtonToggleOn(radionButton: UIButton, radioText: UILabel){
        //settting image into UIImage
        let checked = UIImage(named: "radio-button-checked")
        
        
        radionButton.setImage(checked, for: .normal)
        radioText.textColor = UIColor(red: 178/255, green: 34/255, blue: 34/255, alpha: 1)
        
    }
    
    static func radioButtonToggleOff(radionButton: UIButton, radioText: UILabel){
        //settting image into UIImage
        let unchecked = UIImage(named: "radio-button-unchecked")
        
        radionButton.setImage(unchecked, for: .normal)
        radioText.textColor = UIColor(red: 42/255, green: 47/255, blue: 52/255, alpha: 1)
        
    }
    
    static func displayAlert(title: String, subTitle: String) {
        let color2 = UIColor(red: 103/255, green: 24/255, blue: 24/255, alpha: 1)
        guard let pandaLogo = UIImage(named: "alertPanda") else { return  }
        SCLAlertView().showCustom(title, subTitle: subTitle, color: color2, icon: pandaLogo)
    }
    
    static func roundPicture(image: UIImageView){
        image.layer.borderWidth = 0
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
    }
}
