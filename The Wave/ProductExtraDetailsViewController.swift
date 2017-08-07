//
//  ProductExtraDetailsViewController.swift
//  The Wave
//
//  Created by Andrew Robinson on 8/5/17.
//  Copyright © 2017 XYello, Inc. All rights reserved.
//

import UIKit

class ProductExtraDetailsViewController: SeletectedImageViewController, UITextViewDelegate {

    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!

    @IBOutlet weak var leftMostButton: UIButton!
    @IBOutlet weak var leftMidButton: UIButton!
    @IBOutlet weak var rightMidButton: UIButton!
    @IBOutlet weak var rightMostButton: UIButton!
    
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var jeepTypeView: UIView!
    @IBOutlet weak var jeepTypeLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationGlyphImageView: UIImageView!

    @IBOutlet weak var descriptionTextView: UITextView!

    @IBOutlet weak var shippingSwitch: UISwitch!
    @IBOutlet weak var paypalSwitch: UISwitch!
    @IBOutlet weak var cashSwitch: UISwitch!

    private var product: Product!

    // MARK: - Init

    init(withProduct product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Top background view
        format(button: leftMostButton)
        format(button: leftMidButton)
        format(button: rightMidButton)
        format(button: rightMostButton)

        leftMostButton.setImage(product.images[0], for: .normal)
        leftMidButton.setImage(#imageLiteral(resourceName: "NewImageProduct"), for: .normal)

        // Bottom background view
        productNameTextField.addBorder(withWidth: 1.0, color: #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.8509803922, alpha: 1))
        productNameTextField.roundCorners(radius: 3.0)

        jeepTypeView.addBorder(withWidth: 1.0, color: #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.8509803922, alpha: 1))
        jeepTypeView.roundCorners(radius: 3.0)
        jeepTypeLabel.text = product.jeepModel.name
        if let price = product.price {
            priceTextField.text = "$\(Int(price))"
        }
        priceTextField.textColor = #colorLiteral(red: 0.2353003025, green: 0.5520883203, blue: 0.3824126124, alpha: 1)
        priceTextField.addBorder(withWidth: 1.0, color: #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.8509803922, alpha: 1))
        priceTextField.roundCorners(radius: 3.0)

        locationView.addBorder(withWidth: 1.0, color: #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.8509803922, alpha: 1))
        locationView.roundCorners(radius: 3.0)

        descriptionTextView.addBorder(withWidth: 1.0, color: #colorLiteral(red: 0.8235294118, green: 0.8392156863, blue: 0.8509803922, alpha: 1))
        descriptionTextView.roundCorners(radius: 3.0)
        descriptionTextView.delegate = self

        shippingSwitch.isOn = false
        paypalSwitch.isOn = false

        view.hideKeyboardWhenTappedAround()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomBackgroundView.roundCorners(radius: 8.0)
        view.bringSubview(toFront: bottomBackgroundView)
    }

    // MARK: - UITextView delegate

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.resignFirstResponder()

        if textView.text == "Write a description..." {
            textView.text = ""
        }
        
        let vc = KeyboardHelperViewController.getVc(with: textView.text) { text in
            if text != "" {
                self.descriptionTextView.text = text
                self.descriptionTextView.textColor = .black
            } else {
                self.descriptionTextView.text = "Write a description..."
                self.descriptionTextView.textColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
            }
        }
        navigationController?.present(vc, animated: false, completion: nil)
    }

    // MARK: - Actions

    @IBAction func jeepTypeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
    }

    @IBAction func postProductButtonPressed(_ sender: BigRedShadowButton) {
    }
    
    @IBAction func xButonPressed(_ sender: UIButton) {
        handler.dismiss()
    }

    // MARK: - Helpers

    private func format(button: UIButton) {
        button.clipsToBounds = true
        button.roundCorners(radius: CornerRadius.constant)
        button.setImage(nil, for: .normal)
    }

}
