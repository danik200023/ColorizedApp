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
        
        setText(to: redSlider, blueSlider, greenSlider)
        setText(to: redLabel, blueLabel, greenLabel)
        setText(to: redTextField, blueTextField, greenTextField)
        
        coloredView.layer.cornerRadius = 15
        
        setColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
    
    @IBAction func doneButtonPressed() {
        delegate?.setBackground(with: coloredView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setText(to: redTextField)
            setText(to: redLabel)
        case redSlider:
            setText(to: blueTextField)
            setText(to: blueLabel)
        default:
            setText(to: blueTextField)
            setText(to: blueLabel)
        }
        
        setColor()
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
    
    private func setText(to textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = getValue(from: redSlider)
            case greenTextField:
                textField.text = getValue(from: greenSlider)
            default:
                textField.text = getValue(from: blueSlider)
            }
        }
    }
    
    private func setText(to labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = getValue(from: redSlider)
            case greenLabel:
                greenLabel.text = getValue(from: greenSlider)
            default:
                blueLabel.text = getValue(from: blueSlider)
            }
        }
    }
    
    private func setText(to sliders: UISlider...) {
        let color = CIColor(color: mainVCBgColor)
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(color.red)
            case greenSlider:
                greenSlider.value = Float(color.green)
            default:
                blueSlider.value = Float(color.blue)
            }
        }
    }

    
    private func showAlert(withTitle title: String, andMessage message: String, sender: UITextField? = nil) {
        let alert = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            sender?.text = "0.50"
            sender?.becomeFirstResponder()
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
