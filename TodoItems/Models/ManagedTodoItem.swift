//
//  ManagedTodoItem.swift
//  TodoItems
//
//  Created by Administlator on 2020/08/28.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class ManagedTodoItem: NSManagedObject {
    
    class func findOrCreate(matching todo: TodoItem, with searchText: String, in context: NSManagedObjectContext) throws -> ManagedTodoItem {
        
        let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
        request.predicate = NSPredicate(format: "text = %@", todo.text)
        // NSSortDescriptor possible (compound as well)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                // assert 'sanity': if condition false ... then print message and interrupt program
                assert(matches.count == 1, "ManagedTodo.findOrCreateSource -- database inconsistency")
                let matchedTodo = matches[0]
                matchedTodo.text = searchText
                return matchedTodo
            }
        } catch {
            throw error
        }
        // no match
        let newTodo = ManagedTodoItem(context: context)
        newTodo.text = todo.text
        newTodo.checked = false
        
        return newTodo
    }
    
    class func findAll(in context: NSManagedObjectContext) -> [ManagedTodoItem] {
        let request: NSFetchRequest<ManagedTodoItem> = ManagedTodoItem.fetchRequest()
        do {
            let matches = try context.fetch(request)
            return matches
        } catch {
            print(error)
        }
        return []
    }
}
