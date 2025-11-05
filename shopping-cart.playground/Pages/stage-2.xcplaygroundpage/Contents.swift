import Cocoa

// Stage 2: Extend your cart to handle:
// - Multiple quantities of the same item
// - Updating the quantity of an item already in the cart
// - Removing all instances of an item vs. removing just one

struct Item {
    let id: Int
    let name: String
    let price: Float
    var quantity: Int = 1
}

struct Cart {
    var store = [Item]()
    
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
        return store.reduce(0.0) { result, cartItem in
            return result + (cartItem.price * Float(cartItem.quantity))
        }
    }
}

let phone = Item(id: 1, name: "iPhone", price: 100.01)
let pizza = Item(id: 2, name: "Pizza", price: 9.99)

var cart = Cart()
cart.add(item: phone)
cart.updateQuantity(item: phone, newQuantity: 3)
cart.add(item: pizza)
cart.add(item: pizza)

print(cart.store)
cart.removeUnit(item: phone)
print(cart.calculateTotal())
