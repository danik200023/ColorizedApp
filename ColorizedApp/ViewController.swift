//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Данила Умнов on 14.07.2024.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var coloredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redLabel.text = getValue(from: redSlider)
        greenLabel.text = getValue(from: greenSlider)
        blueLabel.text = getValue(from: blueSlider)
        
        coloredView.layer.cornerRadius = 15
        setColor()
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
}

