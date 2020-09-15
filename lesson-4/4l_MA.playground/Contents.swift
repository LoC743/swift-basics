import UIKit

/* ////////////////////////////////////////////////////////////
/// 1. Описать класс Car c общими свойствами автомобилей и ////
/// пустым методом действия по аналогии с прошлым заданием. ///
//////////////////////////////////////////////////////////// */

struct Baggage {
    let id: Int
    let name: String
    let description: String
    let space: Int
}

enum Transmission: String {
    case auto = "Автоматическая"
    case manual = "Механическая"
    case none = "Отсутствует"
}

class Car {
    let model: String
    let year: UInt16
    var trunkSpace: Int
    var usedTrunkSpace: Int
    let color: UIColor
    let bluetooth: Bool
    let mileage: Int
    let transmission: Transmission
    let hp: UInt
    let weight: UInt
    
    private var baggageArray: [Baggage]
    
    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt) {
        self.usedTrunkSpace = 0
        for baggage in baggageArray {
            self.usedTrunkSpace += baggage.space
        }
        
        guard usedTrunkSpace <= trunkSpace else {
            return nil
        }
        
        self.model = model
        self.year = year
        self.trunkSpace = trunkSpace
        self.baggageArray = baggageArray
        self.color = color
        self.bluetooth = bluetooth
        self.mileage = mileage
        self.transmission = transmission
        self.hp = hp
        self.weight = weight
    }
    
    init() {
        self.model = "Default"
        self.year = 2020
        self.trunkSpace = 100
        self.baggageArray = []
        self.usedTrunkSpace = 0
        self.color = .white
        self.bluetooth = true
        self.mileage = 0
        self.transmission = .auto
        self.hp = 100
        self.weight = 1000
    }
    
    private func increaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace + space <= trunkSpace {
            usedTrunkSpace += space
            result = true
        }
        
        return result
    }
    
    private func decreaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace - space >= 0 {
            usedTrunkSpace -= space
            result = true
        }
        
        return result
    }
    
    func addBaggage(_ baggage: Baggage) -> Bool {
        var result = false
        if increaseTrunkSpace(baggage.space) {
            baggageArray.append(baggage)
            result = true
        }
        
        return result
    }
    
    func removeBaggageBy(_ id: Int) -> Bool {
        var result = false
        for i in 0..<baggageArray.count {
            let baggage = baggageArray[i]
            if baggage.id == id {
                _ = decreaseTrunkSpace(baggage.space)
                baggageArray.remove(at: i)
                result = true
                break
            }
        }
        
        return result
    }
    
    func printBaggage() {
        guard baggageArray.count > 0 else {
            print("Багажник пуст.")
            return
        }
        
        print("\nСодержимое багажника:")
        for baggage in baggageArray {
            print("\(baggage.name) занимает \(baggage.space) пространства багажника.")
        }
        print("Занято \(usedTrunkSpace) из \(trunkSpace)\n")
    }
    
    func printStatus() {
        print("""
            \n
            Модель: \(model)
            Год выпуска: \(year)
            Цвет: \(color)
            Трансмиссия: \(transmission.rawValue)
            Пробег: \(mileage)
            Мощность двигателя (лс): \(hp)
            Масса: \(weight)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
    }
}

//var car = Car()
//car.printStatus()
//
//let pc = Baggage(id: 0, name: "PC", description: "Default PC", space: 30)
//let chair = Baggage(id: 1, name: "Chair", description: "Default chair", space: 70) // 71 для перевеса (при максимальном объеме в 100)
//
//car.addBaggage(pc)
//car.printBaggage()
//
//if (!car.addBaggage(chair)) {
//    print("\(chair.name), который имеет объем \(chair.space) не помеситался в багажник\n")
//}
//car.printBaggage()
//
//car.removeBaggageBy(pc.id)
//car.printBaggage()


/* ////////////////////////////////////////////////////////////////////////
/// 2. Описать пару его наследников TrunkCar и SportCar. //////////////////
/// Подумать, какими отличительными свойствами обладают эти автомобили. ///
/// Описать в каждом наследнике специфичные для него свойства. ////////////
//////////////////////////////////////////////////////////////////////// */

enum TruckType: String {
    case mixer = "Автомеситель"
    case mobileCrane = "Грузоподъемный кран"
    case dumpTruck = "Самосвал"
    case garbageTruck = "Мусоровоз"
    case logCarrier = "Перевозчик бревен"
    case truck = "Тягач"
}

enum BodyType: String {
    case buggy = "Багги"
    case cabriolet = "Кабриолет"
    case coupe = "Купе"
    case hatchback = "Хэтчбек"
    case kombi = "Комби"
    case limousine = "Лимузин"
    case microvan = "Микровэн"
    case minivan = "Минивэн"
    case pickup = "Пикап"
    case roadster = "Родстер"
    case sedan = "Седан"
    case wagon = "Универсал"
}

//class TrunkCar: Car {
//    let truckType: TruckType
//    let liftingCapacity: Int
//    let cargoWeight: Int
//
//    init?(truckType: TruckType, liftingCapacity: Int, cargoWeight: Int, model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt) {
//        guard liftingCapacity > cargoWeight else {
//            return nil
//        }
//
//        self.truckType = truckType
//        self.liftingCapacity = liftingCapacity
//        self.cargoWeight = cargoWeight
//
//        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
//    }
//
//    override init() {
//        self.truckType = .truck
//        self.liftingCapacity = 15000
//        self.cargoWeight = 0
//        super.init()
//    }
//}
//
//class SportCar: Car {
//    let bodyType: BodyType
//    let accelerationTime: Double
//
//    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt, bodyType: BodyType, accelerationTime: Double) {
//        self.bodyType = bodyType
//        self.accelerationTime = accelerationTime
//        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
//    }
//
//    override init() {
//        self.bodyType = .sedan
//        self.accelerationTime = 10.0
//        super.init()
//    }
//}

/* ///////////////////////////////////////////////////////////////////////////
/// 3. Взять из прошлого урока enum с действиями над автомобилем. ////////////
/// Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. ///
/// Добавить эти действия в перечисление. ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////// */

enum TrailerStatus: String {
    case unloading = "Производится разгрузка"
    case loading = "Производится загрузка"
    case onWay = "В пути"
}

enum WindowStatus: String {
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

//class TrunkCar: Car {
//    let truckType: TruckType
//    let liftingCapacity: Int
//    let cargoWeight: Int
//    var trailerState: TrailerStatus {
//        didSet {
//            print("Грузовик \(model). Статус трейлера: \(trailerState.rawValue)")
//        }
//    }
//
//    init?(truckType: TruckType, liftingCapacity: Int, cargoWeight: Int, model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt, trailerState: TrailerStatus) {
//        guard liftingCapacity > cargoWeight else {
//            return nil
//        }
//
//        self.truckType = truckType
//        self.liftingCapacity = liftingCapacity
//        self.cargoWeight = cargoWeight
//        self.trailerState = trailerState
//
//        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
//    }
//
//    override init() {
//        self.truckType = .truck
//        self.liftingCapacity = 15000
//        self.cargoWeight = 0
//        self.trailerState = .onWay
//        super.init()
//    }
//}
//
//let truck = TrunkCar()
//truck.trailerState = .loading
//truck.trailerState = .onWay
//truck.trailerState = .unloading
//
//class SportCar: Car {
//    let bodyType: BodyType
//    let accelerationTime: Double
//    var windowState: WindowStatus {
//        didSet {
//            print("Автомобиль \(model). Статус окон: \(windowState.rawValue)")
//        }
//    }
//
//    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt, bodyType: BodyType, accelerationTime: Double, windowState: WindowStatus) {
//        self.bodyType = bodyType
//        self.accelerationTime = accelerationTime
//        self.windowState = windowState
//        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
//    }
//
//    override init() {
//        self.bodyType = .sedan
//        self.accelerationTime = 10.0
//        self.windowState = .close
//        super.init()
//    }
//}

//let sportCar = SportCar()
//sportCar.windowState = .close
//sportCar.windowState = .open


/* /////////////////////////////////////////////////////////
/// 4. В каждом подклассе переопределить метод /////////////
/// действия с автомобилем в соответствии с его классом. ///
///////////////////////////////////////////////////////// */

class TrunkCar: Car {
    let truckType: TruckType
    let liftingCapacity: Int
    let cargoWeight: Int
    var trailerState: TrailerStatus {
        didSet {
            print("Грузовик \(model). Статус трейлера: \(trailerState.rawValue)")
        }
    }

    init?(truckType: TruckType, liftingCapacity: Int, cargoWeight: Int, model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt, trailerState: TrailerStatus) {
        guard liftingCapacity > cargoWeight else {
            return nil
        }

        self.truckType = truckType
        self.liftingCapacity = liftingCapacity
        self.cargoWeight = cargoWeight
        self.trailerState = trailerState

        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
    }

    override init() {
        self.truckType = .truck
        self.liftingCapacity = 15000
        self.cargoWeight = 0
        self.trailerState = .onWay
        super.init()
    }
    
    override func printStatus() {
        print("""
            \n
            Тип: Грузовой
            Модель: \(model)
            Год выпуска: \(year)
            Цвет: \(color)
            Трансмиссия: \(transmission.rawValue)
            Пробег: \(mileage)
            Мощность двигателя (лс): \(hp)
            Масса: \(weight)
            Тип: \(truckType.rawValue)
            Грузоподъемность \(liftingCapacity)
            Вес груза: \(cargoWeight)
            Состояние трейлера: \(trailerState.rawValue)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
    }
}

class SportCar: Car {
    let bodyType: BodyType
    let accelerationTime: Double
    var windowState: WindowStatus {
        didSet {
            print("Автомобиль \(model). Статус окон: \(windowState.rawValue)")
        }
    }
    
    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission, hp: UInt, weight: UInt, bodyType: BodyType, accelerationTime: Double, windowState: WindowStatus) {
        self.bodyType = bodyType
        self.accelerationTime = accelerationTime
        self.windowState = windowState
        super.init(model: model, year: year, trunkSpace: trunkSpace, baggageArray: baggageArray, color: color, bluetooth: bluetooth, mileage: mileage, transmission: transmission, hp: hp, weight: weight)
    }
    
    override init() {
        self.bodyType = .sedan
        self.accelerationTime = 10.0
        self.windowState = .close
        super.init()
    }
    
    override func printStatus() {
        print("""
            \n
            Тип: Легковой
            Модель: \(model)
            Год выпуска: \(year)
            Цвет: \(color)
            Трансмиссия: \(transmission.rawValue)
            Пробег: \(mileage)
            Мощность двигателя (лс): \(hp)
            Масса: \(weight)
            Тип: \(bodyType.rawValue)
            Разгон (0 - 100км/ч): \(accelerationTime)
            Состояние окон: \(windowState.rawValue)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
    }
}

/* //////////////////////////////////////////////////
/// 5. Создать несколько объектов каждого класса. ///
/// Применить к ним различные действия. /////////////
////////////////////////////////////////////////// */

// Багаж(личные вещи)
let pc = Baggage(id: 0, name: "PC", description: "Обычный PC", space: 30)
let chair = Baggage(id: 1, name: "Стул", description: "Обычный стул", space: 70)
let table = Baggage(id: 2, name: "Стол", description: "Обычный стол", space: 180)
let wardrobe = Baggage(id: 3, name: "Шкаф", description: "Огромный шкаф", space: 500)

//let trunkCar = TrunkCar()
let trunkCar = TrunkCar(truckType: .truck, liftingCapacity: 25000, cargoWeight: 10000, model: "MAN", year: 2018, trunkSpace: 1500, baggageArray: [], color: .red, bluetooth: true, mileage: 1500, transmission: .auto, hp: 700, weight: 37000, trailerState: .onWay)

if let trunkCar = trunkCar {
    trunkCar.printStatus()
    trunkCar.printBaggage()

    trunkCar.addBaggage(pc)
    trunkCar.addBaggage(chair)
    trunkCar.addBaggage(table)
    trunkCar.addBaggage(wardrobe)
    trunkCar.printBaggage()

    trunkCar.removeBaggageBy(table.id)
    trunkCar.removeBaggageBy(chair.id)
    trunkCar.printBaggage()
}

//let sportCar = SportCar()
let sportCar = SportCar(model: "Toyota", year: 1998, trunkSpace: 300, baggageArray: [], color: .orange, bluetooth: false, mileage: 330000, transmission: .manual, hp: 280, weight: 1270, bodyType: .coupe, accelerationTime: 5.8, windowState: .close)

if let car = sportCar {
    car.printStatus()
    car.printBaggage()

    car.addBaggage(pc)
    car.addBaggage(chair)
    car.addBaggage(table)
    car.printBaggage()

    if (!car.addBaggage(wardrobe)) {
        print("\n\(wardrobe.name) не поместился в \(car.model)\n")
    }
    
    car.printBaggage()

    car.removeBaggageBy(table.id)
    car.removeBaggageBy(chair.id)
    car.printBaggage()
}


/* ///////////////////////////////////////////////////////
/// 6. Вывести значения свойств экземпляров в консоль. ///
/////////////////////////////////////////////////////// */

if let trunkCar = trunkCar {
    trunkCar.trailerState = .loading
    trunkCar.trailerState = .onWay
    trunkCar.trailerState = .unloading
}

if let car = sportCar {
    car.windowState = .close
    car.windowState = .open
}
