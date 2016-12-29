//
//  AddNewProductViewController.swift
//  ThePost
//
//  Created by Andrew Robinson on 12/28/16.
//  Copyright © 2016 The Post. All rights reserved.
//

import UIKit

class AddNewProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private enum CellType {
        case textField
        case dropDown
        case price
        case details
        case controlSwitch
    }

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    private var tableFormat: [[String:CellType]] = []
    
    private var currentlyOpenPickerIndex = -1
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = #colorLiteral(red: 0.3568627451, green: 0.3568627451, blue: 0.3568627451, alpha: 0.102270344)
        tableView.dataSource = self
        tableView.delegate = self
        
        container.roundCorners(radius: 8.0)
        
        cancelButton.layer.borderColor = cancelButton.titleLabel!.textColor.cgColor
        cancelButton.layer.borderWidth = 1.0
        cancelButton.roundCorners(radius: 8.0)
        
        submitButton.roundCorners(radius: 8.0)
        
        tableFormat = [["Item Name": .textField],
                       ["Make & Model": .dropDown]]
//                       ["Price": .price],
//                       ["Condition": .dropDown],
//                       ["Details (optional)": .details],
//                       ["Willing to Ship Item": .controlSwitch],
//                       ["Do you accept PayPal?": .controlSwitch],
//                       ["Cash?": .controlSwitch]]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7020763423)
        })
    }
    
    // MARK: - TableView datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableFormat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        let dictionary = tableFormat[indexPath.row]
        let descriptionName = Array(dictionary.keys)[0]
        let type = Array(dictionary.values)[0]
        let imageName = evaluateImageName(withDescription: descriptionName)
        
        if type == .textField {
            let textCell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! NewProductTextTableViewCell
            
            textCell.sideImageView.image = UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
            textCell.sideImageView.tintColor = #colorLiteral(red: 0.9098039216, green: 0.9058823529, blue: 0.8235294118, alpha: 1)
            textCell.detailNameLabel.text = descriptionName
            textCell.contentTextField.attributedPlaceholder = NSAttributedString(string: "Type here...", attributes: [NSForegroundColorAttributeName: #colorLiteral(red: 0.9098039216, green: 0.9058823529, blue: 0.8235294118, alpha: 0.5)])
            textCell.contentTextField.delegate = self
            
            cell = textCell
        } else if type == .dropDown {
            let dropDownCell = tableView.dequeueReusableCell(withIdentifier: "dropDownCell", for: indexPath) as! NewProductDropDownTableViewCell
            
            dropDownCell.sideImageView.image = UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
            dropDownCell.sideImageView.tintColor = #colorLiteral(red: 0.9098039216, green: 0.9058823529, blue: 0.8235294118, alpha: 1)
            dropDownCell.detailNameLabel.text = descriptionName
            dropDownCell.contentLabel.text = "Tap here..."
            
            if descriptionName == "Condition" {
                dropDownCell.pickerType = .condition
            }
                        
            cell = dropDownCell
        } else {
            cell = UITableViewCell()
        }
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dictionary = tableFormat[indexPath.row]
        let type = Array(dictionary.values)[0]
        
        var height: CGFloat = 30.0
        
        if currentlyOpenPickerIndex != -1 {
            if type == .dropDown {
                height = 216.0
            }
        }
        
        return height
    }
    
    // MARK: - TableView delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let previouslyOpenIndex = currentlyOpenPickerIndex
        
        dismissOpenPicker()
        
        if let textCell = cell as? NewProductTextTableViewCell {
            textCell.contentTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        
        if indexPath.row != previouslyOpenIndex {
            if let dropDownCell = cell as? NewProductDropDownTableViewCell {
                currentlyOpenPickerIndex = indexPath.row
                tableView.beginUpdates()
                tableView.endUpdates()
                dropDownCell.setContentLabelForCurrentlySelectedRow()
                dropDownCell.pickerView.alpha = 0.0
                UIView.animate(withDuration: 0.25, animations: {
                    dropDownCell.pickerView.alpha = 1.0
                })
            }
        }

    }
    
    // MARK: - TextField delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25, animations: {
            self.container.frame = CGRect(x: self.container.frame.origin.x, y: self.container.frame.origin.y - 40, width: self.container.frame.width, height: self.container.frame.height)
        })
        dismissOpenPicker()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25, animations: {
            self.container.frame = CGRect(x: self.container.frame.origin.x, y: self.container.frame.origin.y + 40, width: self.container.frame.width, height: self.container.frame.height)
        })
    }
 
    // MARK: - Actions
 
    @IBAction func wantsToCancel(_ sender: UIButton) {
        prepareForDismissal() {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func wantsToSubmit(_ sender: UIButton) {
        prepareForDismissal() {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func prepareForDismissal(dismissCompletion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }, completion: { done in
            dismissCompletion()
        })
    }
    
    private func evaluateImageName(withDescription description: String) -> String {
        var imageName = ""
        
        switch description {
        case "Make & Model":
            imageName = "PIPMakeModel"
        default:
            imageName = "PIPItemName"
        }
        
        return imageName
    }
    
    private func dismissOpenPicker() {
        if currentlyOpenPickerIndex != -1 {
            let newPath = IndexPath(item: currentlyOpenPickerIndex, section: 0)
            currentlyOpenPickerIndex = -1
            if let openCell = tableView.cellForRow(at: newPath) as? NewProductDropDownTableViewCell {
                tableView.beginUpdates()
                tableView.endUpdates()
                UIView.animate(withDuration: 0.25, animations: {
                    openCell.pickerView.alpha = 0.0
                })
            }
        }
    }

}
