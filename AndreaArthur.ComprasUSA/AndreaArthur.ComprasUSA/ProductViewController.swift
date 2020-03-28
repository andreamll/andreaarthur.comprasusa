//
//  ProductViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 20/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbUSPrice: UILabel!
    @IBOutlet weak var lbTaxes: UILabel!
    @IBOutlet weak var lbBRLPrice: UILabel!
    @IBOutlet weak var ivProduct: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
