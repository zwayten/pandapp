//
//  CustomTabBarVC.swift
//  pandapp
//
//  Created by Yassine Zitoun on 27/11/2021.
//

import Foundation
import UIKit

class CustomTabBarvc: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        
        let color2 = UIColor(red: 103/255, green: 24/255, blue: 24/255, alpha: 1)
        self.tabBar.tintColor = color2
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hvc = storyboard.instantiateViewController(withIdentifier: "PandappViewController") as! PandappViewController
        /*
        HomeViewController
        clubProfileId
            chatId
            person
            message
            userProfileId
            elearningId
         */
        
        if lastLogged! == "club" {
        let cpvc = storyboard.instantiateViewController(withIdentifier: "clubProfileId") as! ClubViewController
            //let chatvc = storyboard.instantiateViewController(withIdentifier: "chatId") as! ChatViewController
            let chatvc = storyboard.instantiateViewController(withIdentifier: "alt") as! AltViewController
            //let chatvc = AltViewController()
            
            self.viewControllers = [chatvc, hvc, cpvc]
            
            let title = ""
            let profileButton = UITabBarItem(title: title, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
            let chatButton = UITabBarItem(title: title, image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
           
            
           
            chatvc.tabBarItem = chatButton
            cpvc.tabBarItem = profileButton
            
        }
        else if lastLogged! == "user" {
            let upvc = storyboard.instantiateViewController(withIdentifier: "userProfileId") as! UserprofileViewController
            let ccvc = storyboard.instantiateViewController(withIdentifier: "elearningId") as! ELearningViewController
            self.viewControllers = [ccvc, hvc, upvc ]
            
            let title = ""
            let profileButton = UITabBarItem(title: title, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
            
            let ccvcButton = UITabBarItem(title: title, image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))
            
            ccvc.tabBarItem = ccvcButton
            upvc.tabBarItem = profileButton
        }
        
        setupMiddleButton()
        //setupLeftButton()
    }
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25, y: -20, width: 60, height: 60))
        
        middleButton.setBackgroundImage(UIImage(named: "smallPanda"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
    
    
    

    
}
