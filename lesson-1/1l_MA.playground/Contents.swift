import Foundation

/* ///////////////////////////////////////////////////////
/////////////// Решить квадратное уравнение //////////////
/////////////////////////////////////////////////////// */
print("Задание 1:")
// ax^2 + bx + c = 0
func solveQuadEquation(a: Double, b: Double, c: Double) {
    let discriminant = (b * b) - (4 * a * c)

    if discriminant < 0 {
        print("Действительных корней нет.")
        print("""
            Комплексные корни:
            x1 = (\(-b) + \(sqrt(fabs(discriminant))) * i) / \(2 * a)
            x2 = (\(-b) - \(sqrt(fabs(discriminant))) * i) / \(2 * a)\n
            """)
    } else if discriminant == 0 {
        let x: Double = -b / (2 * a)
        print("Уравнение имеет один корень. x: \(x)\n")
    } else {
        let x1: Double = (-b + discriminant.squareRoot()) / (2 * a)
        let x2: Double = (-b - discriminant.squareRoot()) / (2 * a)
        print("Уравнение имеет два корня. x1: \(x1.round(to: 4)); x2: \(x2.round(to: 4))\n")
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

solveQuadEquation(a: 1.0, b: 2.0, c: -6.0)      // Ответ с двумя корнями
solveQuadEquation(a: -4.0, b: 28.0, c: -49.0)   // Ответ с одним корнем
solveQuadEquation(a: 5.0, b: 6.0, c: 2.0)       // Ответ без действительных корней


/* ///////////////////////////////////////////////////////
////// Даны катеты прямоугольного треугольника. //////////
/// Найти площадь, периметр и гипотенузу треугольника. ///
/////////////////////////////////////////////////////// */
print("Задание 2:")

func solveTriangleData(a: Double, b: Double) {
    guard a > 0 && b > 0 else {
        print("Ошибка! Длинна катетов должна быть больше 0.")
        return
    }
    
    let c: Double = sqrt( (a * a) + (b * b) )  // Гипотенуза
    
    let square: Double = 1/2 * a * b  // Площадь
    
    let perimeter: Double = a + b + c // Периметр

    print("""
        Катет a: \(a)
        Катет b: \(b)
        Гипотенуза с: \(c)
        Площадь S: \(square)
        Периметр P: \(perimeter)\n
        """)
}

let a: Double = 3.0  // Первый катет
let b: Double = 4.0  // Второй катет

solveTriangleData(a: a, b: b)
