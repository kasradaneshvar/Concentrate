//
//  ConcentrateThemeChooserViewController.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/14/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import UIKit

class ConcentrateThemeChooserViewController: UIViewController {

    let themes = [
        "Sports":"⚽️🥎🏀🏓🏹🚴🏿‍♂️🏊🏿‍♂️🏸🏈🏉⛳️",
        "Animals":"🦓🦔🐇🐁🦢🐖🦈🐌🦋🐍🦙",
        "Faces":"😔🤗😬😓😎🤓😇🥰🤪😜😍🤣"
    ]
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
                }
            }
        }
    }
}
