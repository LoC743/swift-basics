import UIKit

/* //////////////////////////////////////////////////////////////
/// 1. Описать несколько структур – любой легковой автомобиль ///
/////////// SportCar и любой грузовик TrunkCar. /////////////////
////////////////////////////////////////////////////////////// */

//struct SportCar {
//    let color: UIColor
//    let bluetooth: Bool
//    let transmisson: Int // 1 - механическая 2 - автоматичекая 3 - отсутствует(для электромобилей)
//    let mileage: Int
//}
//
//struct TrunkCar {
//    let color: UIColor
//    let bluetooth: Bool
//    let transmisson: Int
//    let mileage: Int
//}


/* ///////////////////////////////////////////////////////////////////
/// 2. Структуры должны содержать марку авто, год выпуска, ///////////
/// объем багажника/кузова, запущен ли двигатель, открыты ли окна, ///
/// заполненный объем багажника.  ////////////////////////////////////
/////////////////////////////////////////////////////////////////// */

enum Transmission {
    case manual
    case auto
    case none
}

//struct SportCar {
//    let model: String
//    let year: Int
//    let trunkSize: Int       // Весь объем багажника
//    let usedTrunkSize: Int   // Используемый объем багажника
//    let isEngineStart: Bool
//    let isWindowOpen: Bool
//
//    let color: UIColor
//    let bluetooth: Bool
//    let transmisson: Transmission
//    let mileage: Int
//}
//
//struct TrunkCar {
//    let model: String
//    let year: Int
//    let trunkSize: Int       // Весь объем багажника
//    let usedTrunkSize: Int   // Используемый объем багажника
//    let isEngineStart: Bool
//    let isWindowOpen: Bool
//
//    let color: UIColor
//    let bluetooth: Bool
//    let transmisson: Transmission
//    let mileage: Int
//}

/* ///////////////////////////////////////////////////////////////////////
/// 3. Описать перечисление с возможными действиями с автомобилем: ///////
/// запустить/заглушить двигатель, открыть/закрыть окна, /////////////////
/// погрузить/выгрузить из кузова/багажника груз определенного объема. ///
/////////////////////////////////////////////////////////////////////// */

enum EngineStatus {
    case running
    case stopped
}

enum WindowStatus {
    case open
    case close
}

struct Baggage {
    let id: Int
    let name: String
    let description: String
    let weight: Int
}

//struct SportCar {
//    let model: String
//    let year: Int
//    let trunkSize: Int       // Весь объем багажника
//    let usedTrunkSize: Int   // Используемый объем багажника
//    let engineState: EngineStatus
//    let windowState: WindowStatus
//
//    let baggageArray: [Baggage]  // Массив вещей в багажнике
//
//    let color: UIColor
//    let bluetooth: Bool
//    let transmisson: Transmission
//    let mileage: Int
//}

/* ////////////////////////////////////////////////////////////////////////
/// 4. Добавить в структуры метод с одним аргументом типа перечисления, ///
/// который будет менять свойства структуры в зависимости от действия.  ///
//////////////////////////////////////////////////////////////////////// */

enum LockStatus {
    case open
    case close
}

struct SportCar {
    let model: String
    let year: Int
    let trunkSpace: Int       // Весь объем багажника
    var usedTrunkSpace: Int   // Используемый объем багажника
    var engineState: EngineStatus {
        didSet {
            if engineState == .stopped {
                print("Двигатель автомобиля не запущен.")
            } else {
                print("Двигаетль автомобиля запущен.")
            }
        }
    }
    var windowState: WindowStatus {
        didSet {
            if windowState == .close {
                print("Окна автомобиля закрыты.")
            } else {
                print("Окна автомобиля открыты.")
            }
        }
    }
    
    var baggageArray: [Baggage]  // Массив вещей в багажнике
    
    var lockState: LockStatus { // Закрыт автомобиль или открыт
        didSet {
            if lockState == .close {
                print("Замок автомобиля закрыт.")
            } else {
                print("Замок автомобиля открыт.")
            }
        }
    }
    
    let color: UIColor
    let bluetooth: Bool
    let transmisson: Transmission
    let mileage: Int
    
    mutating func changelockState(to state: LockStatus) {
        // Предположим что когда мы закрываем автомобиль - закрываются окна
        if lockState == .open {
            lockState = .close
            windowState = .close
        } else {
            lockState = .open
        }
    }
    
    private mutating func increaseTruncSpace(_ space: Int) -> Bool {
        var result = false
        
        if (space + usedTrunkSpace) <= trunkSpace {
            usedTrunkSpace += space
            result = true
        }
        
        return result
    }
    
    private mutating func decreaseTruncSpace(_ space: Int) -> Bool {
        var result = false
        
        if (usedTrunkSpace - space) >= 0 {
            usedTrunkSpace -= space
            result = true
        }
        
        return result
    }
    
    mutating func addBaggage(_ baggage: Baggage) -> Bool {
        var result = false
        
        if increaseTruncSpace(baggage.weight) {
            baggageArray.append(baggage)
            result = true
        }
        
        return result
    }
    
    mutating func removeBaggageBy(id: Int) -> Bool {
        var result = false
        
        for i in 0..<baggageArray.count {
            let baggage = baggageArray[i]
            if baggage.id == id {
                _ = decreaseTruncSpace(baggage.weight)
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
        for item in baggageArray {
            print("\(item.name) занимает \(item.weight) кг.")
        }
    }
    
    func printData() {
        print("""
            \nСпортивный автомобиль модели: \(model)
            Год выпуска: \(year)
            Цвет: \(color)
            Трансмиссия: \(transmisson)
            Пробег: \(mileage) km
            Статус двигателя: \(engineState)
            Статус окон: \(windowState)
            Статус замка: \(lockState)
            Объем багажника: \(trunkSpace)
            Заполненность багажника \(usedTrunkSpace)
            """)
        printBaggage()
    }
}

/* ////////////////////////////////////////////////////////////////////
///////// 5. Инициализировать несколько экземпляров структур. /////////
////////////// Применить к ним различные действия. ////////////////////
//////////////////////////////////////////////////////////////////// */

var mercedesBenz = SportCar(model: "Mercedes-Benz AMG GT", year: 2020, trunkSpace: 100, usedTrunkSpace: 0, engineState: .stopped, windowState: .close, baggageArray: [], lockState: .close, color: .cyan, bluetooth: true, transmisson: .auto, mileage: 2000)

mercedesBenz.lockState = .open
mercedesBenz.windowState = .open
mercedesBenz.engineState = .running
mercedesBenz.engineState = .stopped
mercedesBenz.lockState = .close

print()
mercedesBenz.printData()

let pcBaggage = Baggage(id: 0, name: "PC", description: "Desktop PC", weight: 30)
mercedesBenz.addBaggage(pcBaggage)

let chairBaggage = Baggage(id: 1, name: "Chair", description: "Furniture", weight: 70)
mercedesBenz.addBaggage(chairBaggage)

mercedesBenz.printBaggage()

let newpcBaggage = Baggage(id: 2, name: "PC", description: "New desktop PC", weight: 40)
// Если возвращается false - не поместилось. Если true - то все ок.
if !mercedesBenz.addBaggage(newpcBaggage) {
    print("\nНе поместилось\n")
}
mercedesBenz.printBaggage()
mercedesBenz.removeBaggageBy(id: 1)
mercedesBenz.addBaggage(newpcBaggage)
mercedesBenz.printBaggage()

/* ////////////////////////////////////////////////////
/// Вывести значения свойств экземпляров в консоль. ///
//////////////////////////////////////////////////// */
