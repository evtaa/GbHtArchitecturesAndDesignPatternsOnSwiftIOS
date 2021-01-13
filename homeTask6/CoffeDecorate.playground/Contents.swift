import Cocoa

protocol Coffee {
    var cost: Int { get }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init (base: Coffee)
}

class SimpleCoffee: Coffee {
    var cost: Int = 10
}

class Milk: CoffeeDecorator {
    var base: Coffee
    var cost: Int {
        get {
            return base.cost + 1
        }
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        get {
            return base.cost + 2
        }
    }
}

class Sugar: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        get {
            return base.cost + 3
        }
    }
}

var simpleCoffee = SimpleCoffee ()
var coffeeWithMilk = Milk(base: simpleCoffee)
var coffeeWithWhip = Whip(base: simpleCoffee)
var coffeeWithSugar = Sugar(base: simpleCoffee)
coffeeWithMilk.cost
coffeeWithWhip.cost
coffeeWithSugar.cost
var coffeeWithMilkAndSugar = Sugar(base: coffeeWithMilk)
var coffeeWithMilkAndWhip = Whip(base: coffeeWithMilk)
var coffeeWithWhipAndSugar = Sugar(base: coffeeWithWhip)
coffeeWithMilkAndSugar.cost
coffeeWithMilkAndWhip.cost
coffeeWithWhipAndSugar.cost

