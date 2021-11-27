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

        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
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
}
