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
//    let year: Date
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
//    let year: Date
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
    let name: String
    let description: String
    let weight: Int
}

struct SportCar {
    let model: String
    let year: Date
    let trunkSize: Int       // Весь объем багажника
    let usedTrunkSize: Int   // Используемый объем багажника
    let isEngineStart: EngineStatus
    let isWindowOpen: WindowStatus
    
    let baggageArray: [Baggage]  // Массив вещей в багажнике
    
    let color: UIColor
    let bluetooth: Bool
    let transmisson: Transmission
    let mileage: Int
}

/* ////////////////////////////////////////////////////////////////////////
/// 4. Добавить в структуры метод с одним аргументом типа перечисления, ///
/// который будет менять свойства структуры в зависимости от действия.  ///
//////////////////////////////////////////////////////////////////////// */



/* ////////////////////////////////////////////////////////////////////
///////// 5. Инициализировать несколько экземпляров структур. /////////
////////////// Применить к ним различные действия. ////////////////////
//////////////////////////////////////////////////////////////////// */



/* ////////////////////////////////////////////////////
/// Вывести значения свойств экземпляров в консоль. ///
//////////////////////////////////////////////////// */


