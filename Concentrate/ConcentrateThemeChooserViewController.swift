//
//  ConcentrateThemeChooserViewController.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/14/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import UIKit

class ConcentrateThemeChooserViewController: VCLLoggingViewController, UISplitViewControllerDelegate {

    override var vclLoggingName: String {
        return "ThemeChooser"
    }
    
    let themes = [
        "Sports":"⚽️🥎🏀🏓🏹🚴🏿‍♂️🏊🏿‍♂️🏸🏈🏉⛳️",
        "Animals":"🦓🦔🐇🐁🦢🐖🦈🐌🦋🐍🦙",
        "Faces":"😔🤗😬😓😎🤓😇🥰🤪😜😍🤣"
    ]
    
    // MARK: Don't collapse secondary in splitView
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool { // `False` means "collapse it"
        if let cvc = secondaryViewController as? ConcentrateViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    // MARK: Manual segue
    private var lastSeguedToConcentrateViewController: ConcentrateViewController?

    private var splitViewDetailConcentrateViewController: ConcentrateViewController? {
        return splitViewController?.viewControllers.last as? ConcentrateViewController
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrateViewController { // Finding things in `splitView`: probably better for iPad only.
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrateViewController { // Hold something in the heap that gets thrown off the navigation stack.
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true) // Pushing something onto navigation stack without segue.
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender) // Segue from code.
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Choose Theme" {
            /*
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    if let theme = themes[themeName]
                }
            }
            */
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                // Try `segue.destination.theme = theme`
                if let cvc = segue.destination as? ConcentrateViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrateViewController = cvc
                }
            }
        }
    }
}
