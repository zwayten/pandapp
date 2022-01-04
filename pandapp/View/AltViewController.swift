//
//  AltViewController.swift
//  pandapp
//
//  Created by yassine zitoun on 3/1/2022.
//

import UIKit

class AltViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func move(_ sender: Any) {
        let vc = ChatRoomClubViewController()
        //vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
