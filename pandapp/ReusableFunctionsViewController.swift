//
//  ReusableFunctionsViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit

class ReusableFunctionsViewController: UIViewController {

    
    
   static func customTextField(textfield: UITextField){
        //creation of the bottom line of the textfield
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        //color of the bottom line hexCode: B22222 , RGB(178,34,34)
        bottomLine.backgroundColor = UIColor.init(red: 178/255, green: 34/255, blue: 34/255, alpha: 1).cgColor
        
        //remove border of the textfield
        textfield.borderStyle = .none
        
        // Add the bottom line to the textfield
        textfield.layer.addSublayer(bottomLine)
        
    }

}
