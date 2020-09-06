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
    
    private var baggageArray: [Baggage]
    
    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage], color: UIColor, bluetooth: Bool, mileage: Int, transmission: Transmission) {
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
//car.removeBaggageBy(0)
//car.printBaggage()


/* ////////////////////////////////////////////////////////////////////////
/// 2. Описать пару его наследников TrunkCar и SportCar. //////////////////
/// Подумать, какими отличительными свойствами обладают эти автомобили. ///
/// Описать в каждом наследнике специфичные для него свойства. ////////////
//////////////////////////////////////////////////////////////////////// */



/* ///////////////////////////////////////////////////////////////////////////
/// 3. Взять из прошлого урока enum с действиями над автомобилем. ////////////
/// Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. ///
/// Добавить эти действия в перечисление. ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////// */



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

