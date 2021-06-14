import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var boughtStocks = [Int]()
        var profit = 0
        
        if prices.isEmpty {
            return profit
        }
        
        for i in prices.indices {
            if i == 0 {
                if prices[i] != prices.max() {
                    boughtStocks.append(prices[i])
                }
            } else if i < prices.count - 1 && prices[i] <= prices[i+1] {
                boughtStocks.append(prices[i])
            } else if prices[i] >= prices[i-1] {
                for j in 0..<boughtStocks.count {
                    profit += prices[i] - boughtStocks[j]
                }
                boughtStocks.removeAll()
            }
        }
        return profit
    }
}
