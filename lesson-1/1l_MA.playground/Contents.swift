import Foundation

/* ///////////////////////////////////////////////////////
/////////////// Решить квадратное уравнение //////////////
/////////////////////////////////////////////////////// */

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


