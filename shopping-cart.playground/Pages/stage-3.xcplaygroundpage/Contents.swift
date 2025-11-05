import Cocoa

// Stage 3: Add support for discount codes:
// - Apply a percentage discount code to the entire cart
// - Apply a fixed amount discount code to the entire cart
// - Only one discount code can be active at a time
// - Calculate the final price after discount

struct Item {
    let id: Int
    let name: String
    let price: Float
    var quantity: Int = 1
}

enum DiscountType {
    case percent
    case fixed
}

struct Discount {
    let type: DiscountType
    let value: Float
}


struct Cart {
    var discount: Discount? = nil
    var store = [Item]()
    
    mutating func applyDiscount(newDiscount: Discount) -> Bool {
        if discount != nil {
            print("Can't apply two discounts")
            return false
        }
        
        if newDiscount.type == .percent && newDiscount.value >= 1 {
            print("Discount can not be more than 100% off.")
            return false
        }
        
        discount = newDiscount
        
        return true
    }
    
    mutating func removeDiscount() {
        discount = nil
    }
    
    mutating func add(item: Item) {
        if let row = store.firstIndex(where: { $0.id == item.id}) {
            store[row].quantity = store[row].quantity + 1
        } else {
            store.append(item)
        }
    }
    
    mutating func updateQuantity(item: Item, newQuantity: Int) {
        if let row = store.firstIndex(where: { $0.id == item.id}) {
            store[row].quantity = newQuantity
        }
    }
    
    mutating func remove(item: Item) {
        store.removeAll { cartItem in
            return cartItem.id == item.id
        }
    }
    
    mutating func removeUnit(item: Item) {
        guard let row = store.firstIndex(where: { $0.id == item.id}) else {
            return
        }
        
        let cartItem = store[row]
        
        if store[row].quantity <= 1 {
            remove(item: cartItem)
        } else {
            updateQuantity(item: cartItem, newQuantity: cartItem.quantity - 1)
        }
    }
    
    func calculateTotal() -> Float {
        let result = store.reduce(0.0) { result, cartItem in
            return result + (cartItem.price * Float(cartItem.quantity))
        }
        
        if let unwrappedDiscount = discount {
            switch unwrappedDiscount.type {
            case .fixed:
                return max(0, result - unwrappedDiscount.value)
            case .percent:
                return result - (result * unwrappedDiscount.value)
            }
        }
        
        return result
    }
}

let phone = Item(id: 1, name: "iPhone", price: 100.01)
let pizza = Item(id: 2, name: "Pizza", price: 9.99)

let fiftyoff = Discount(type: .fixed, value: 50.00)
let twentypercentoff = Discount(type: .percent, value: 2)

var cart = Cart()
cart.add(item: phone)
cart.updateQuantity(item: phone, newQuantity: 3)
cart.add(item: pizza)

cart.applyDiscount(newDiscount: twentypercentoff)
cart.removeDiscount()
cart.applyDiscount(newDiscount: fiftyoff)

cart.removeUnit(item: phone)
print(cart.calculateTotal())
