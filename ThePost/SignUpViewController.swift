//
//  SignUpViewController.swift
//  ThePost
//
//  Created by Andrew Robinson on 12/23/16.
//  Copyright © 2016 The Post. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: RoundedTextField!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var confirmPasswordTextField: RoundedTextField!
    
    private var usernameImageView:UIImageView!
    private var emailImageView:UIImageView!
    private var passwordImageView:UIImageView!
    private var confirmPasswordImageView:UIImageView!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameImageView = UIImageView(image: UIImage(named: "UsernameAvatar")!.withRenderingMode(.alwaysTemplate))
        formatTextField(field: usernameTextField, withImageView: usernameImageView)
        
        emailImageView = UIImageView(image: UIImage(named: "Mail")!.withRenderingMode(.alwaysTemplate))
        formatTextField(field: emailTextField, withImageView: emailImageView)
        
        passwordImageView = UIImageView(image: UIImage(named: "Password")!.withRenderingMode(.alwaysTemplate))
        formatTextField(field: passwordTextField, withImageView: passwordImageView)
        
        confirmPasswordImageView = UIImageView(image: UIImage(named: "ConfirmPasswordCheck")!.withRenderingMode(.alwaysTemplate))
        formatTextField(field: confirmPasswordTextField, withImageView: confirmPasswordImageView)
        
        signUpButton.roundCorners()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(gesture)
    }
    
    // MARK: - Actions
    
    @objc private func tapped() {
        for otherView in view.subviews {
            if otherView is UITextField {
                otherView.resignFirstResponder()
            }
        }
    }
    
    @IBAction func editingChanged(_ sender: RoundedTextField) {
        if sender.placeholder == "Username" {
            if let text = sender.text {
                if text.characters.count >= 4 {
                    usernameImageView.tintColor = #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1)
                } else {
                    usernameImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
                }
            } else {
                usernameImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
            }
        }
        
        else if sender.placeholder == "Email" {
            if let text = sender.text {
                if text.characters.count >= 5 && text.contains("@") && text.contains(".") {
                    emailImageView.tintColor = #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1)
                } else {
                    emailImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
                }
            } else {
                emailImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
            }
        }
        
        else if sender.placeholder == "Password" {
            if let text = sender.text {
                if text.characters.count > 1 {
                    passwordImageView.tintColor = #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1)
                } else {
                    passwordImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
                }
                
                if text == confirmPasswordTextField.text {
                    confirmPasswordImageView.tintColor = #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1)
                } else {
                    confirmPasswordImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
                }
            } else {
                passwordImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
            }
        }
        
        else if sender.placeholder == "Confirm Password" {
            if let text = sender.text {
                if text == passwordTextField.text {
                    confirmPasswordImageView.tintColor = #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1)
                } else {
                    confirmPasswordImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
                }
            } else {
                confirmPasswordImageView.tintColor = #colorLiteral(red: 0.8552903533, green: 0.03449717909, blue: 0.01357735228, alpha: 1)
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        var viewsToShake:[UIView] = []
        if usernameImageView.tintColor != #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1) {
            viewsToShake.append(usernameTextField)
        }
        
        if emailImageView.tintColor != #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1) {
            viewsToShake.append(emailTextField)
        }
        
        if passwordImageView.tintColor != #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1) {
            viewsToShake.append(passwordTextField)
        }
        
        if confirmPasswordImageView.tintColor != #colorLiteral(red: 0.1464666128, green: 0.6735964417, blue: 0.3412255645, alpha: 1) {
            viewsToShake.append(confirmPasswordTextField)
        }
        
        if viewsToShake.isEmpty {
            // Sign up
        } else {
            for view in viewsToShake {
                shakeView(view: view)
            }
        }
    }
    
    @IBAction func signUpSocial(_ sender: UIButton) {
        if sender.titleLabel!.text == "Google" {
            
        } else if sender.titleLabel!.text == "Facebook" {
            
        } else if sender.titleLabel!.text == "Twitter" {
            
        }
    }
    
    // MARK: - Helpers
    
    private func formatTextField(field: UITextField, withImageView imageView: UIImageView) {
        field.roundCorners()
        field.attributedPlaceholder = NSAttributedString(string: field.placeholder!, attributes: [NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3503303272)])
        
        imageView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // Pad the image so it doesn't appear right in-line with the textfield border.
        if let size = imageView.image?.size {
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 15.0, height: size.height)
        }
        imageView.contentMode = .left
        
        field.rightViewMode = .always
        field.rightView = imageView
    }
    
    private func shakeView(view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }

}