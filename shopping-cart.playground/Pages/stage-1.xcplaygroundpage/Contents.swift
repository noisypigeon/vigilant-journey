import Cocoa

// Stage 1: Implement a shopping cart that can:
// - Add items to the cart (each item has an ID, name, and price)
// - Remove items from the cart
// - Calculate the total price of all items in the cart

struct Item {
    let id: Int
    let name: String
    let price: Float
}

struct Cart {
    var store = [Item]()

    mutating func add(item: Item) {
        store.append(item)
    }

    mutating func remove(item: Item) {
        store.removeAll { cartItem in
            return cartItem.id == item.id
        }
    }

    func calculateTotal() -> Float {
        return store.reduce(0.0) { result, cartItem in
            return result + cartItem.price
        }
    }
}

let phone = Item(id: 1, name: "iPhone", price: 100.01)
let pizza = Item(id: 2, name: "Pizza", price: 9.99)

var cart = Cart()
cart.add(item: phone)
cart.add(item: pizza)
print(cart.calculateTotal())
