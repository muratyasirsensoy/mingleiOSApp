//
//  GirişViewController.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 7.01.2024.
//

import UIKit
import Firebase


class Giris_ViewController: UIViewController {
    var iconClick = false
    let imageicon = UIImageView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageicon.image = UIImage(named: "password")
        
        let contentView = UIView()
        contentView.addSubview(imageicon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        imageicon.frame = CGRect(x: -5, y: 0, width: 30, height: 30)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        imageicon.isUserInteractionEnabled = true
        imageicon.addGestureRecognizer(tapGestureRecognizer)
        
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255, alpha: 0.6 )])
        
        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255, alpha: 0.6)])
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(named: "showPassword")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(named: "password")
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func signInClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else {
                self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
            }
        }
    }
        
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func forgotPass(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error != nil {
                
                print("Şifre yenilemeniz için e-postanıza aktivasyon maili gönderildi")
                
            }else {
                
                print("Başarısız ")
                
            }
            
            
        }
        
    }
    
    }



