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
        self.selectedIndex = 0
        setupMiddleButton()
        setupLeftButton()
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
        self.selectedIndex = 0
    }
    
    func setupLeftButton() {
        let middleButton = UIButton(frame: CGRect(x: 25, y: 0, width: 60, height: 60))
        
        
        middleButton.setBackgroundImage(UIImage(named: "book"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonActionLeft), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func menuButtonActionLeft(sender: UIButton) {
        self.selectedIndex = 1
    }
    
}
