//
//  GoalsStore.swift
//  MoneyAccounting
//
//  Created by Tatiana Lazarenko on 3/9/24.
//

import Foundation

final class GoalsStore {
    static let shared = GoalsStore()
    
    let goals = FinancialGoalSettings(incomeGoal: 30000, expenseLimit: 10000)
    
    private init() {}
}
