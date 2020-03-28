//
//  ShoppingViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 22/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    
    @IBOutlet weak var lbUSTotal: UILabel!
    @IBOutlet weak var lbBRLTotal: UILabel!
    
    let config = Configuration.shared
    let productsManager = ProductsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsManager.loadProducts(with: context)
        calculate()
    }
    
    func calculate() {
        
        var usQuotation: Double = 0.0
        var percIOF: Double = 0.0
        var usPrice: Double = 0.0
        var usTotal: Double = 0.0
        var usStateTax: Double = 0.0
        var brlPrice: Double = 0.0
        var brlTotal: Double = 0.0
        let products = productsManager.products
        
        //buscar a cotacao do dolar e o IOF das configuracoes
        usQuotation = config.usdValue
        percIOF = config.iofValue
        
        //varrer a lista de produtos e calcular os totais
        for product in products{
            
            //pegar o preco em dolar e o valor do imposto do estado da compra
            usPrice = product.usPrice
            usTotal = usTotal + usPrice
            usStateTax = Double((product.state?.tax)!)
            usPrice = usPrice * (1+(usStateTax/100))
            
            //converter para real e somar ao valor ja computado em real
            brlPrice = usPrice * usQuotation
            brlPrice = brlPrice * (1+(percIOF/100))
            brlTotal = brlTotal + brlPrice
        }
        
        lbUSTotal.text = String(format:"%.2f", usTotal)
        lbBRLTotal.text = String(format:"%.2f", brlTotal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
