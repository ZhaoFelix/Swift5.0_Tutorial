import Foundation
/// 插入排序
///
/// - note:时间复杂度
/// O(n²)
public func insertionSort<Element>( _ array: inout [Element]) where Element:Comparable {
    guard array.count >= 2 else {
        return
    }
    for current in 1..<array.count {
        for  shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting-1)
            } else {
                break
            }
        }
    }
}
