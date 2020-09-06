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

enum Transmission {
    case auto
    case manual
    case none
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
        
        print("Содержимое багажника:")
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
            Трансмиссия: \(transmission)
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

enum TruckType {
    case mixer
    case mobileCrane
    case dumpTruck
    case garbageTruck
    case logCarrier
    case truck
}

enum BodyType {
    case buggy
    case cabriolet
    case coupe
    case hatchback
    case kombi
    case limousine
    case microvan
    case minivan
    case pickup
    case roadster
    case sedan
    case wagon
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
}

//let truck = TrunkCar()
//truck.trailerState = .loading
//truck.trailerState = .onWay
//truck.trailerState = .unloading

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
}

//let sportCar = SportCar()
//sportCar.windowState = .close
//sportCar.windowState = .open


/* /////////////////////////////////////////////////////////
/// 4. В каждом подклассе переопределить метод /////////////
/// действия с автомобилем в соответствии с его классом. ///
///////////////////////////////////////////////////////// */



/* //////////////////////////////////////////////////
/// 5. Создать несколько объектов каждого класса. ///
/// Применить к ним различные действия. /////////////
////////////////////////////////////////////////// */



/* ///////////////////////////////////////////////////////
/// 6. Вывести значения свойств экземпляров в консоль. ///
/////////////////////////////////////////////////////// */

