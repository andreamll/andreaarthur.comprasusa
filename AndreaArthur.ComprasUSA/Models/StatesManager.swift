//
//  StatesManager.swift
//  AndreaArthur.ComprasUSA
//
//  Created by Andrea Chuang on 21/03/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import CoreData

class StatesManager {
    
    static let shared = StatesManager()
    var states: [State] = []
    
    func loadStates(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            states = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext) {
        let state = states[index]
        context.delete(state)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
