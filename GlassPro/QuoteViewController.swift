//
//  QuoteViewController.swift
//  GlassPro
//
//  Created by wade chen on 8/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var QuoteSummary: UILabel!
    
    var quoteTotalPrice = 0.0
    var glassType = ""
    var thickness = ""
    var area = ""
    var process = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        QuoteSummary.text = """
        Glass type: \(glassType)
        Thickness: \(thickness) mm
        Area: \(area) m^2
        Process: \(process)
        Quote Total Price: $\(String(format: "%.2f", quoteTotalPrice))
        """
    }
    

    
}
