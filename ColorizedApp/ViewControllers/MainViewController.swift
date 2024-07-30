//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Данила Умнов on 30.07.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setBackground(with color: UIColor)
}

final class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsViewController {
            settingsVC.delegate = self
            settingsVC.mainVCBgColor = view.backgroundColor
        }
    }

}


// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setBackground(with color: UIColor) {
        view.backgroundColor = color
    }
}
