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
    
    public func uploadImageToServer(imageOrVideo : UIImage?, user: User) ->String {
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
                to: "http://192.168.109.1:3000/upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                user.setProfilepicture(profilePicture: imm.img)
                print(imm.img)
                umodel.registerUser(user: user)
                
            }
        print(imageJsonReturnAf)
        return imageJsonReturnAf
        
    }
    
    public func uploadImageToServerClub(imageOrVideo : UIImage?, club: Clubs) ->String {
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
                to: "http://192.168.109.1:3000/upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                club.set(clubLogo: imm.img)
                print(imm.img)
                cmodel.registerClub(club: club)
                
            }
        print(imageJsonReturnAf)
        return imageJsonReturnAf
        
    }
    
    public func uploadImageToServer(imageOrVideo : UIImage?, eventPost: EventPost) ->String {
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
                to: "http://192.168.109.1:3000/upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                eventPost.set(banner: imm.img)
                print(imm.img)
                postmodel.addEventPost(eventPost: eventPost)
                
            }
        print(imageJsonReturnAf)
        return imageJsonReturnAf
        
    }
    
    public func uploadImageToServerLostPost(imageOrVideo : UIImage?, lostPost: LostPost) ->String {
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
                to: "http://192.168.109.1:3000/upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                lostPost.set(image: imm.img)
                print(imm.img)
                lostPostmodel.addLostPost(lostPost: lostPost)
                
            }
        print(imageJsonReturnAf)
        return imageJsonReturnAf
        
    }
    
    public func uploadFileToServer(pdf : Data?, elearning: Elearning) ->String {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = [
            "Authorisation": "bearer \(token!)",
            "Content-type": "multipart/form-data"
        ]
        let postmodel = ElearningViewModel()
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(pdf!, withName: "file" , fileName: "file.pdf", mimeType: "application/pdf")
            },
                to: "http://192.168.109.1:3000/upload/file", method: .post , headers: headers)
            .responseJSON {  response in
                let imm: ImageReturn = try! JSONDecoder().decode(ImageReturn.self, from: response.data!)
                //print(imm.img)
                self.imageJsonReturnAf = imm.img
                elearning.set(courseFile: imm.img)
                print(imm.img)
                postmodel.addCoursePost(eLearning: elearning)
                
            }
        print(imageJsonReturnAf)
        return imageJsonReturnAf
        
    }
}
