//
//  UserprofileViewController.swift
//  pandapp
//
//  Created by Yassine Zitoun on 4/11/2021.
//

import UIKit

class UserprofileViewController: UIViewController {

    //Circular image user profile:
    @IBOutlet var userImage: UIImageView!
    
    
    
    
    func initProfile(){
        userImage.layer.borderWidth = 3
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfile()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
