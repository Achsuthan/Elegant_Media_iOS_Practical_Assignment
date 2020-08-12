//
//  LoginViewController.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: result?.token?.tokenString, version: nil, httpMethod: .get)
        request.start { (completion, result, error) in
            guard let resultNew = result as? [String:Any] else {
                self.btLoginWithFaceBook.alpha = 1
                return
            }
            let email = resultNew["email"]  as? String
            let name  = resultNew["name"]  as? String
            let hotelListVc = HotelListViewController(nibName: nil, bundle: nil)
            hotelListVc.name = name ?? ""
            hotelListVc.email = email ?? ""
            self.navigationController?.viewControllers = [hotelListVc]
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    //MARK: - Button for Facebook
    let btLoginWithFaceBook: FBLoginButton = {
        let button = FBLoginButton(frame: .zero, permissions: [.publicProfile])
        button.setTitle("Login with Facebook", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = APP_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.alpha = 0
        return button
    }()
    
    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    // MARK: - Set up the UI
    private func setUp(){
        
        
        if let token = AccessToken.current, !token.isExpired {
            let token  = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (completion, result, error) in
                guard let resultNew = result as? [String:Any] else {
                    self.btLoginWithFaceBook.alpha = 1
                    return
                }
                let email = resultNew["email"]  as? String
                let name  = resultNew["name"]  as? String
                let hotelListVc = HotelListViewController(nibName: nil, bundle: nil)
                hotelListVc.name = name ?? ""
                hotelListVc.email = email ?? ""
                self.navigationController?.viewControllers = [hotelListVc]
                
            }
        }
        else {
            self.btLoginWithFaceBook.alpha = 1
        }
        
        
        
        //Set the white color to backgrond
        self.view.backgroundColor = .white
        
        //Facebook button setup
        self.view.addSubview(self.btLoginWithFaceBook)
        //center align the button horizoanl and vertical
        self.btLoginWithFaceBook.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.btLoginWithFaceBook.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //set the leadingconstrian to button
        self.btLoginWithFaceBook.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        //set tralingconstrian to button
        self.btLoginWithFaceBook.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        //set the height for button
        self.btLoginWithFaceBook.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //Add the clieck event to button
        self.btLoginWithFaceBook.delegate = self
        
    }
}
