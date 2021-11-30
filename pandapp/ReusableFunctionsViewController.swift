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
   static func customTextField(textfield: UITextField){
        //creation of the bottom line of the textfield
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        //color of the bottom line hexCode: #B22222 , RGB(178,34,34)
        bottomLine.backgroundColor = UIColor.init(red: 178/255, green: 34/255, blue: 34/255, alpha: 1).cgColor
        
        //remove border of the textfield
        textfield.borderStyle = .none
        
        // Add the bottom line to the textfield
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    // textfield with bottomLine green
    static func customTextFieldGreen(textfield: UITextField){
         //creation of the bottom line of the textfield
         let bottomLine = CALayer()
         bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
         
         //color of the bottom line hexCode: #009A17 , RGB(0,154,23)
         bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 154/255, blue: 23/255, alpha: 1).cgColor
         
         //remove border of the textfield
         textfield.borderStyle = .none
         
         // Add the bottom line to the textfield
         textfield.layer.addSublayer(bottomLine)
         
     }
    
    static func validatePassword(textfield: UITextField, textfieldConfirm: UITextField)-> Bool{
        if textfield.text == textfieldConfirm.text {
            return true
        }
        else {
            return false
        }
    }
    
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
        guard let pandaLogo = UIImage(named: "smallPanda") else { return  }
        SCLAlertView().showCustom(title, subTitle: subTitle, color: color2, icon: pandaLogo)
    }
}
