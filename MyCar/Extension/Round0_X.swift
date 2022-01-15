import Foundation

extension Double {
    var rounded0_X: Double {
        return Double((self * 10).rounded()/10)
    }
}
