//
//  TodoItem.swift
//  TodoItems
//
//  Created by Derrick Park on 2018-10-11.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
	var text = ""
	var checked = false
	
	func toggleCheckmark() {
		self.checked = !self.checked
	}
}
