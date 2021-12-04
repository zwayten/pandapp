//
//  SceneDelegate.swift
//  pandapp
//
//  Created by Yassine Zitoun on 1/11/2021.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    
    func loginUser1(email: String, password: String, completionHandler: @escaping (Bool) -> ()){
        //var logg: LoginUser
        let parameters = ["email": email,
                          "password": password] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())auth", method: .post, parameters: parameters).responseJSON {  response in
            let statusCode = response.response?.statusCode
            var test = false
            if statusCode == 200 {
                test = true
                completionHandler(test)
                
            } else {
                //ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
                test = false
                completionHandler(test)
            }
        }
    }
    
    func loginClub(email: String, password: String, completionHandler: @escaping (Bool) -> ()){
        //var logg: LoginUser
        let parameters = ["login": email,
                          "password": password] as [String : Any]
        AF.request("\(ConnectionDb.baserequest())authClub", method: .post, parameters: parameters).responseJSON {  response in
            let statusCode = response.response?.statusCode
            var test = false
            if statusCode == 200 {
                test = true
                completionHandler(test)
                
            } else {
                //ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
                test = false
                completionHandler(test)
            }
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        
        let emailClub = UserDefaults.standard.string(forKey: "login")
        let passwordClub = UserDefaults.standard.string(forKey: "passwordClub")
        
        if lastLogged == "user" && (email! != "" || password! != "" ) {
           print("mloggi ka user")
            //let token = UserDefaults.standard.string(forKey: "token")
            loginUser1(email: email!, password: password!, completionHandler: { (test) in
                if test == true {
                    let vc = storyboard.instantiateViewController(withIdentifier: "customTabBarId")
                    self.window?.rootViewController = vc
                } else {
                    ReusableFunctionsViewController.displayAlert(title: "Invalid Credentials", subTitle: "Your credentials are invalid")
                }
                
            })
        } else if lastLogged == "club" && (emailClub != "" || passwordClub != "" ) {
            print("mloggi ka club")
            //let token = UserDefaults.standard.string(forKey: "token")
            loginClub(email: emailClub!, password: passwordClub!, completionHandler: { (test) in
                if test == true {
                    let vc = storyboard.instantiateViewController(withIdentifier: "customTabBarId")
                    self.window?.rootViewController = vc
                } else {
                    ReusableFunctionsViewController.displayAlert(title: "Invalid club Credentials", subTitle: "Your club credentials are invalid")
                }
                
            })
            
           
            
        }  else if  (email == nil && password == nil ) || (emailClub == nil && passwordClub == nil) {
            print("makech mloggi jemla")
            let vc = storyboard.instantiateViewController(withIdentifier: "initialNavigation")
            window?.rootViewController = vc
        }
        
        /*
         UserDefaults.standard.set(login.login, forKey: "login")
         UserDefaults.standard.set(login.password, forKey: "passwordClub")
         UserDefaults.standard.set(login.tokenClub, forKey: "tokenClub")
         UserDefaults.standard.set(login.clubName, forKey: "clubName")
         UserDefaults.standard.set("club", forKey: "lastLoggedIn")
         */
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

