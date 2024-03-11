//
//  GoalsStore.swift
//  MoneyAccounting
//
//  Created by Tatiana Lazarenko on 3/9/24.
//

import Foundation

final class GoalsStore {
    static let shared = GoalsStore()
    
    var goals = FinancialGoalSettings(incomeGoal: 100000, expenseLimit: 30000)
    
    private init() {}
}


