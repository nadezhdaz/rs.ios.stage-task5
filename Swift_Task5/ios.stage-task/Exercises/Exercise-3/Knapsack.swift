import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        guard maxWeight > 0, maxWeight <= 2500, foods.count > 0, drinks.count <= 100 else {
            return 0
        }
        
        if foods.count == 1 && drinks.count == 1 && foods[0].weight + drinks[0].weight <= maxWeight {
            return min(foods[0].value, drinks[0].value)
        }
        
        var drinksTable = [[(weight: Int, value: Int)]](repeating: [(weight: Int, value: Int)](repeating: (0, 0), count: maxWeight + 1), count: drinks.count + 1)
        var foodsTable = [[(weight: Int, value: Int)]](repeating: [(weight: Int, value: Int)](repeating: (0, 0), count: maxWeight + 1), count: foods.count + 1)
        
        for i in 0..<drinks.count + 1 {
            for j in 0..<maxWeight + 1 {
                if i == 0 {
                    drinksTable[i][j] = (0, 0)
                } else if drinks[i-1].weight <= j {
                    drinksTable[i][j].weight = max(drinksTable[i-1][j].weight, drinks[i-1].weight + drinksTable[i-1][j-drinks[i-1].weight].weight)
                    drinksTable[i][j].value = max(drinksTable[i-1][j].value, drinks[i-1].value + drinksTable[i-1][j-drinks[i-1].weight].value)
                } else {
                    drinksTable[i][j] = drinksTable[i-1][j]
                }
            }
        }
        
        for i in 0..<foods.count + 1 {
            for j in 0..<maxWeight + 1 {
                if i == 0 {
                    foodsTable[i][j] = (0, 0)
                } else if foods[i-1].weight <= j {
                    foodsTable[i][j].weight = max(foodsTable[i-1][j].weight, foods[i-1].weight + foodsTable[i-1][j-foods[i-1].weight].weight)
                    foodsTable[i][j].value = max(foodsTable[i-1][j].value, foods[i-1].value + foodsTable[i-1][j-foods[i-1].weight].value)
                } else {
                    foodsTable[i][j] = foodsTable[i-1][j]
                }
            }
        }
        
        guard let maxDrinksRow = drinksTable.last, let maxFoodsRow = foodsTable.last else { return 0 }
        
        var result = 0
        
        for i in maxDrinksRow.indices.reversed(){
            let j = maxWeight - maxDrinksRow[i].weight
            if maxDrinksRow[i].weight + maxFoodsRow[j].weight <= maxWeight {
                result = result < min(maxDrinksRow[i].value, maxFoodsRow[j].value) ? min(maxDrinksRow[i].value, maxFoodsRow[j].value) : result
            }
        }
        
        return result
    }
}
