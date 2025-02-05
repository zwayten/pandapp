//
//  UploadImageService.swift
//  pandapp
//
//  Created by Yassine Zitoun on 26/11/2021.
//

import Foundation
import UIKit
import Alamofire

class UploadImageService{
    
    var imageJsonReturnAf = ""
    
    public func uploadImageToServer(imageOrVideo : UIImage?, user: User, bio: UITextView?){
        //let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            //"Authorisation": "bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        
        let umodel = UserViewModel()
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
            },
                to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                user.setProfilepicture(profilePicture: imm.img)
                print(imm.img)
                user.setDescription(description: bio!.text)
                umodel.registerUser(user: user)
                
            }
        
    }
    
    public func uploadImageToServerClub(imageOrVideo : UIImage?, club: Clubs, bio: UITextView?){
        //let token = UserDefaults.standard.string(forKey: "token")
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        
        let cmodel = ClubsViewModel()
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
            },
                to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                club.set(clubLogo: imm.img)
                club.set(description: bio!.text)
                //print(imm.img)
                cmodel.registerClub(club: club)
                
            }
    }
    
    
    
    public func uploadImageToServer(imageOrVideo : UIImage?, eventPost: EventPost) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorisation": "bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        
        let postmodel = EventPostViewModel()
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
            },
                to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                eventPost.set(banner: imm.img)
                print(imm.img)
                postmodel.addEventPost(eventPost: eventPost)
                
            }
        
    }
    
    public func uploadImageToServerLostPost(imageOrVideo : UIImage?, lostPost: LostPost){
        let token = UserDefaults.standard.string(forKey: "token")
        
        let headers: HTTPHeaders = [
            "Authorisation": "bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        
        let lostPostmodel = LostPostViewModel()
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageOrVideo!.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.png", mimeType: "image/png")
            },
                to: "\(ConnectionDb.baserequest())upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                lostPost.set(image: imm.img)
                print(imm.img)
                lostPostmodel.addLostPost(lostPost: lostPost)
                
            }
        
    }
    
   
}
