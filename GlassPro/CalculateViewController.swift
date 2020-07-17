//
//  ViewController.swift
//  GlassPro
//
//  Created by wade chen on 6/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var heightTextInput: UITextField!
    @IBOutlet weak var widthTextInput: UITextField!
    @IBOutlet weak var radiusTextInput: UITextField!
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var glassTypePickerView: UIPickerView!
    @IBOutlet weak var glassThicknessPickerView: UIPickerView!
    
    @IBOutlet weak var cutToSizeSwitch: UISwitch!
    @IBOutlet weak var toughenSwitch: UISwitch!
    @IBOutlet weak var slumpSwitch: UISwitch!
    
    var glassBrain = GlassBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load pickerview glass type
        glassTypePickerView.dataSource = self
        glassTypePickerView.delegate = self
        
        //load pickerview glass thickness
        glassThicknessPickerView.dataSource = self
        glassThicknessPickerView.delegate = self
        
        //Assign delegates to each textfield
        heightTextInput.delegate = self
        widthTextInput.delegate = self
        radiusTextInput.delegate = self
    }
    
    
    @IBAction func quoteButtonPressed(_ sender: UIButton) {

        //Assign processes
        glassBrain.cutToSizeFlag = cutToSizeSwitch.isOn
        glassBrain.toughenFlag = toughenSwitch.isOn
        glassBrain.slumpFlag = slumpSwitch.isOn
        
        //Calculate the 
        glassBrain.calculatePrice(glassBrain.glassTypes[glassBrain.glassTypeIndex], glassBrain.glassThickness[glassBrain.glassThicknessIndex])
        
        //print("performSegue")
        self.performSegue(withIdentifier: "goToQuote", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQuote" {
            let secondVC = segue.destination as! QuoteViewController
            secondVC.glassType = glassBrain.glassTypes[glassBrain.glassTypeIndex]
            secondVC.thickness = glassBrain.glassThickness[glassBrain.glassThicknessIndex]
            secondVC.area = String(format: "%.2f", glassBrain.area)
            secondVC.process = "\(glassBrain.getCutToSize()) \(glassBrain.getToughen()) \(glassBrain.getSlump())"
            secondVC.quoteTotalPrice = glassBrain.quoteTotalPrice
        }
    }
    
    //Detects and controls which text input is enabled or disabled
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print("didBeginEditing")
        
        print(textField.tag)
        if(textField.tag == 0) { //Height is being edited
            
            //Check if radius has any text
            if radiusTextInput.hasText {
                radiusTextInput.text = ""
            }
            
        } else if(textField.tag == 1) { //Width is being edited
            
            //Check if radius has any text
            if radiusTextInput.hasText {
                radiusTextInput.text = ""
            }
            
        } else { //Radius is being edited
            
            if heightTextInput.hasText {
                heightTextInput.text = ""
            }
            if widthTextInput.hasText {
                widthTextInput.text = ""
            }

        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //print("Height: \(heightTextInput.hasText) Width: \(widthTextInput.hasText) Radius: \(radiusTextInput.hasText)")
        //Calculate the area and set the areaLabel
        if(heightTextInput.hasText && widthTextInput.hasText) {
            
            if let height = heightTextInput.text {

                glassBrain.height = Double(height)!
            }
            
            if let width = widthTextInput.text {

                glassBrain.width = Double(width)!
            }
            
            areaLabel.text = "Area (m2): \(String(format: "%.2f", glassBrain.calculateArea()))"
        } else if (radiusTextInput.hasText) {
            
            if let radius = radiusTextInput.text {
                glassBrain.radius = Double(radius)!
            }
            
            areaLabel.text = "Area (m2): \(String(format: "%.2f", glassBrain.calculateArea()))"
        } else {
            //print("Height: \(glassBrain.height) Width: \(glassBrain.width) Radius: \(glassBrain.radius)")
        }
        
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //Check whether
        //print("ShouldEndEditing")
        return true
    }
    
    //Gets the selected row from the pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == glassTypePickerView {
            //print("\(row): \(glassBrain.glassTypes[row]) ")
            glassBrain.glassTypeIndex = row
        } else {
            //print("\(row): \(glassBrain.glassThickness[row]) ")
            glassBrain.glassThicknessIndex = row
        }
        
    }
    
    //Called by the picker view when it needs the number of components.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Called by the picker view when it needs the number of rows for a specified component.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == glassTypePickerView {
            return glassBrain.glassTypes.count
        } else {
            return glassBrain.glassThickness.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == glassTypePickerView {
            return glassBrain.glassTypes[row]
        } else {
            return glassBrain.glassThickness[row]
        }
    }
    
}

