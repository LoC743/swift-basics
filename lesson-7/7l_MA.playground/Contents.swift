import UIKit
import Darwin

/* ///////////////////////////////////////////////////////////////////
 /// 1. Придумать класс, методы которого могут завершаться неудачей ///
 /// и возвращать либо значение, либо ошибку Error?.                ///
 /// Реализовать их вызов и обработать результат метода             ///
 /// при помощи конструкции if let, или guard let.                  ///
 /////////////////////////////////////////////////////////////////// */

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

enum TrunkError: Error {
    case nothingToRemove // "Багажник пуст!"
    case baggageDoesNotExists(id: Int) // "В багажнике нет вещи с id: \(id)"
    case noSpace // "В багажнике нет места!"
}


class Car {
    var model: String
    var year: UInt16
    var trunkSpace: Int
    var usedTrunkSpace: Int
    
    var baggageArray: [Baggage]

    
    init?(model: String, year: UInt16, trunkSpace: Int, baggageArray: [Baggage]) {
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
    
    func addBaggage(_ baggage: Baggage) -> TrunkError? {
        guard increaseTrunkSpace(baggage.space) else { return .noSpace }
        
        baggageArray.append(baggage)
        
        return nil
    }
    
    func removeBaggageBy(id: Int) -> (Baggage?, TrunkError?) {
        guard baggageArray.count > 0 else { return (nil, .nothingToRemove) }
            
        var result: Baggage? = nil
        
        for i in 0..<baggageArray.count {
            let baggage = baggageArray[i]
            if baggage.id == id {
                guard decreaseTrunkSpace(baggage.space) else {
                    return (nil, .nothingToRemove)
                }
                result = baggageArray.remove(at: i)
                break
            }
        }
        
        guard result != nil else { return (nil, .baggageDoesNotExists(id: id)) }
        
        return (result, nil)
    }
    
    func printStatus() {
        print("""
            \n
            Тип: Легковой
            Модель: \(model)
            Год выпуска: \(year)
            Объем багажника: \(trunkSpace)
            Использованный объем багажника: \(usedTrunkSpace)
            \n
            """)
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
}

func testCar() {
    let car = Car(model: "Test", year: 2000, trunkSpace: 200, baggageArray: [])
    guard let strongCar = car else { return }
    
    let pc = Baggage(id: 0, name: "PC", description: "Обычный PC", space: 30)
    let chair = Baggage(id: 1, name: "Стул", description: "Обычный стул", space: 70)
    let table = Baggage(id: 2, name: "Стол", description: "Обычный стол", space: 180)
    
    strongCar.addBaggage(pc)
    strongCar.addBaggage(chair)
    strongCar.removeBaggageBy(id: 1) // Успешное удаление
    strongCar.addBaggage(table) // Ошибка о том что не поместится
    print(strongCar.removeBaggageBy(id: 1000)) // Удаление несуществующего элемента
    strongCar.removeBaggageBy(id: 0)
    strongCar.printBaggage()
    print(strongCar.removeBaggageBy(id: 0)) // Ошибка удаления элемента из пустого багажника.
}

//testCar()

/* /////////////////////////////////////////////////////////////////////////////////
 /// 2. Придумать класс, методы которого могут выбрасывать ошибки.                ///
 /// Реализуйте несколько throws-функций.                                         ///
 /// Вызовите их и обработайте результат вызова при помощи конструкции try/catch. ///
 ///////////////////////////////////////////////////////////////////////////////// */

