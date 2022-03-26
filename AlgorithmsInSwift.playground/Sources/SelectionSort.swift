import Foundation
/// 选择排序
///
/// - note: 时间复杂度
/// O(n²)
public func selectionSort<Element>(_ array: inout [Element]) where Element:Comparable {
    guard array.count >= 2 else {
        return
    }
    for current in 0..<(array.count - 1) {
        var lowest = current
        for other in current + 1 ..< array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        if lowest != current {
            array.swapAt(current, lowest)
        }
    }
}


