//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Данила Умнов on 14.07.2024.
//

import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var coloredView: UIView!
    
    var mainVCBgColor: UIColor!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        let colorComponents = getRGB(from: mainVCBgColor)
        redSlider.value = Float(colorComponents.red)
        greenSlider.value = Float(colorComponents.green)
        blueSlider.value = Float(colorComponents.blue)
        
        setTextFrom(slider: redSlider)
        setTextFrom(slider: greenSlider)
        setTextFrom(slider: blueSlider)
        
        coloredView.layer.cornerRadius = 15
        
        setColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
    
    @IBAction func doneButtonPressed() {
        delegate?.setBackground(
            with: coloredView.backgroundColor ?? UIColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0
            )
        )
        dismiss(animated: true)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        setColor()
        setTextFrom(slider: sender)
    }
    
    private func setColor() {
        coloredView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue:  CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func getValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func getRGB(from color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    private func setTextFrom(slider: UISlider) {
        switch slider {
        case redSlider:
            redLabel.text = getValue(from: slider)
            redTextField.text = getValue(from: slider)
        case greenSlider:
            greenLabel.text = getValue(from: slider)
            greenTextField.text = getValue(from: slider)
        default:
            blueLabel.text = getValue(from: slider)
            blueTextField.text = getValue(from: slider)
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, sender: UITextField) {
        let alert = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    sender.text = "0.50"
                }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let floatValue = Float(text) else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter correct value",
                sender: textField
            )
            return false
        }
        if (0.0...1.0).contains(floatValue) {
            return true
        } else {
            showAlert(
                withTitle: "Wrong format!",
                andMessage: "Please enter coorect value",
                sender: textField
            )
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTextField:
            guard let text = textField.text else { return }
            redSlider.setValue(Float(text) ?? 0, animated: true)
            sliderValueChanged(redSlider)
        case greenTextField:
            guard let text = textField.text else { return }
            greenSlider.setValue(Float(text) ?? 0, animated: true)
            sliderValueChanged(greenSlider)
        default:
            guard let text = textField.text else { return }
            blueSlider.setValue(Float(text) ?? 0, animated: true)
            sliderValueChanged(blueSlider)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
