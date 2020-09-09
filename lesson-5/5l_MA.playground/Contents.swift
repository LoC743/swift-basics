import UIKit

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

enum EngineStatus: String {
    case running = "Запущен"
    case stopped = "Не запущен"
}

enum WindowsStauts: String {
    case open = "Открыты"
    case close = "Закрыты"
}

/* ///////////////////////////////////////////////////
/// 1. Создать протокол «Car» и описать свойства,  ///
/// общие для автомобилей, а также метод действия. ///
/////////////////////////////////////////////////// */

protocol Car {
    var model: String { get }
    var year: UInt16 { get }
    var trunkSpace: Int { get }
    var usedTrunkSpace: Int { get set }
    var color: UIColor { get }
    var bluetooth: Bool { get }
    var mileage: Int { get }
    var hp: UInt { get }
    var weight: UInt { get }
    var transmission: Transmission { get }
    
    var engineState: EngineStatus { get set }
    var windowsState: WindowsStauts { get set }
    
    var baggageArray: [Baggage] { get set }
    
    func increaseTrunkSpace(_ space: Int) -> Bool
    func decreaseTrunkSpace(_ space: Int) -> Bool
    
    func addBaggage(_ baggage: Baggage) -> Bool
    func removeBaggageBy(_ id: Int) -> Bool
    
    func openWindows()
    func closeWindows()
    
    func startEngine()
    func stopEngine()
    
    func printBaggage()
    func printStatus()
}


/* /////////////////////////////////////////////////////////////////////////////
/// 2. Создать расширения для протокола «Car» и реализовать                  ///
/// в них методы конкретных действий с автомобилем:                          ///
/// открыть/закрыть окно, запустить/заглушить двигатель и т.д.               ///
/// (по одному методу на действие, реализовывать следует только те действия, ///
/// реализация которых общая для всех автомобилей).                          ///
///////////////////////////////////////////////////////////////////////////// */


// Управление двигателем
extension Car {
    mutating func startEngine() {
        engineState = .running
    }
    
    mutating func stopEngine() {
        engineState = .stopped
    }
}

// Управление окнами
extension Car {
    mutating func openWindows() {
        windowsState = .open
    }
    
    mutating func closeWindows() {
        windowsState = .close
    }
}

// Управление багажником
extension Car {
    private mutating func increaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace + space <= trunkSpace {
            usedTrunkSpace += space
            result = true
        }
        
        return result
    }
    
    private mutating func decreaseTrunkSpace(_ space: Int) -> Bool {
        var result = false
        if usedTrunkSpace - space >= 0 {
            usedTrunkSpace -= space
            result = true
        }
        
        return result
    }
    
    mutating func addBaggage(_ baggage: Baggage) -> Bool {
        var result = false
        if increaseTrunkSpace(baggage.space) {
            baggageArray.append(baggage)
            result = true
        }
        
        return result
    }
    
    mutating func removeBaggageBy(_ id: Int) -> Bool {
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
}

// Вывод информации о полях Car
extension Car {
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
            Состояние окон: \(windowsState.rawValue)
            Состояние двигателя: \(engineState.rawValue)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
    }
}

/* //////////////////////////////////////////////////////////////////////////////////
/// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. ///
/// Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.   ///
////////////////////////////////////////////////////////////////////////////////// */



/* ///////////////////////////////////////////////////////
/// 4. Для каждого класса написать расширение,         ///
/// имплементирующее протокол CustomStringConvertible. ///
/////////////////////////////////////////////////////// */



/* //////////////////////////////////////////////////
/// 5. Создать несколько объектов каждого класса. ///
/// Применить к ним различные действия.           ///
////////////////////////////////////////////////// */



/* ///////////////////////////////////////
/// 6. Вывести сами объекты в консоль. ///
/////////////////////////////////////// */

