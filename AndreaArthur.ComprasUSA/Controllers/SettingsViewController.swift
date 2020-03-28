//
//  SettingsViewController.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 22/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController{
    
    @IBOutlet weak var tfUSDValue: UITextField!
    @IBOutlet weak var tfIOFValue: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let config = Configuration.shared
    let statesManager = StatesManager()
    
    var fetchedResultController: NSFetchedResultsController<State>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Se alterou config a partir do Settings Bundle, atualizar a tela
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView(){
        tfUSDValue.text = String(format:"%.2f", config.usdValue)
        tfIOFValue.text = String(format:"%.2f", config.iofValue)
        
        statesManager.loadStates(with: self.context)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeUSDValue(_ sender: UITextField) {
        config.usdValue = Double(sender.text!) ?? 0
    }
    
    @IBAction func changeIOFValue(_ sender: UITextField) {
        config.usdValue = Double(sender.text!) ?? 0
    }
    
    @IBAction func btAddState(_ sender: UIButton) {
        showAlert(with: nil)
    }
    
    func showAlert(with state: State?){
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
            if let name = state?.name {
                textField.text = name
            }
        }
            
        alert.addTextField { (textField) in
                textField.placeholder = "Imposto"
                if let tax = state?.tax {
                    textField.text = String(format:"%.2f", tax)
                }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? State(context: self.context)
            
            state.name = alert.textFields?.first?.text
            
            if let tax = alert.textFields![1].text {
                state.tax = Float(tax) ?? 0
            } else {
                state.tax = 0
            }
            
            do{
                try self.context.save()
                self.formatView()
            } catch{
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.view.tintColor = UIColor(named: "settings")
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesManager.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let state = statesManager.states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = String(format:"%.2f", state.tax)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let state = statesManager.states[indexPath.row]
            context.delete(state)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            formatView()
        }
    }

}

extension SettingsViewController: UITableViewDelegate{
    
}

