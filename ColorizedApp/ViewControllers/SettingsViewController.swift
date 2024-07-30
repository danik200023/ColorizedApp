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
    
    @IBOutlet var coloredView: UIView!
    
    var mainVCBgColor: UIColor!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorComponents = getRGB(from: mainVCBgColor)
        redSlider.value = Float(colorComponents.red)
        greenSlider.value = Float(colorComponents.green)
        blueSlider.value = Float(colorComponents.blue)
        
        redLabel.text = getValue(from: redSlider)
        greenLabel.text = getValue(from: greenSlider)
        blueLabel.text = getValue(from: blueSlider)
        
        coloredView.layer.cornerRadius = 15
        
        setColor()
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
        
        switch sender {
        case redSlider:
            redLabel.text = getValue(from: redSlider)
        case greenSlider:
            greenLabel.text = getValue(from: greenSlider)
        default:
            blueLabel.text = getValue(from: blueSlider)
        }
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
}

