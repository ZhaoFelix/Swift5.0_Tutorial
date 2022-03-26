import Foundation

/*
 1、什么是堆
 堆一种完全二叉树。
 2、堆的分类
 大顶堆：左右子树的元素都比根的值小，左子树的值大于右子树的值；
 小顶堆：左右子树的值都比根的值大，左子树的值小于右子树的值；
 3、堆的应用
 查找集合中的最大值和最小值；
 堆排序；
 优先队列；
 Dijkstra 和 Prim 算法
 4、堆的表现形式
 堆的展现形式依然是以数组的形式进行展现和存储的；
 当前节点i的左子树索引未2i+1，右子树索引为2i+2；
 
 */

public struct Heap<Element: Equatable> {
    var elements: [Element] = []
    // 堆的排序规则
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var count: Int {
        elements.count
    }
    // 返回栈顶元素
    public func peek() -> Element? {
        elements.first
    }
    // 注意：在二叉树中访问左右子节点的时间复杂度是O(log n)
    public func leftChildIndex(ofParentIndex index: Int) -> Int {
        2 * index + 1
    }
    
    public func rightChildIndex(ofParentIndex index: Int) -> Int {
        2 * index + 2
    }
    // 根据子节点的索引获取父节点的索引
    public func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    // 删除一个节点
    // 注意：删除节点的时间复杂度为O(log n)，主要耗时为向下的筛选
    public mutating func remove() -> Element? {
        // 1、检查是否为空
        guard !isEmpty else {
            return nil
        }
        // 2、将要删除的元素与最后一个位置的元素进行交换，此处以删除堆顶元素为例
        elements.swapAt(0, count - 1)
        defer {
            // 4、向下筛选重新进行排列
            siftDown(from: 0)
        }
        // 3、删除最后一个元素
        return elements.removeLast()
    }
    
    // 向下进行筛选
    public mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            // 1、获取左右节点的索引
            let left = leftChildIndex(ofParentIndex: parent)
            let right = rightChildIndex(ofParentIndex: parent)
            var candidate = parent
            // 2、如果左子节点的优先权高于父节点的优先权
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            // 3、如果右子节点的优先权高于候选节点的优先权
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            // 4、如果最后的候选节点没变，直接返回
            if candidate == parent {
                return
            }
            // 5、父节点和候选节点进行交换
            elements.swapAt(parent, candidate)
            // 6、将候选节点视为新的父节点，重复上述操作
            parent = candidate
        }
    }
    
    
    // 元素插入
    // 注意：节点插入的时间复杂度为O(log n)，主要耗时为向上的筛选
    public mutating func insert(_ element: Element) {
        // 1、将元素添加到末尾
        elements.append(element)
        // 2、向上进行筛选重排
        siftUp(from: elements.count - 1)
    }
    
    // 向上筛选重排
    public mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    // 删除任意索引的节点
    public mutating func remove(at index: Int) -> Element? {
        // 1、索引不能大于元素个数
        guard index < elements.count else {
            return nil
        }
        // 2、最后一个元素，直接删除，无需重排
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            // 3、删除的元素和末尾元素进行交换
            elements.swapAt(index, elements.count - 1)
            defer {
                // 5、根据删除的索引向上和向下筛选重排
                siftDown(from: index)
                siftUp(from: index)
            }
            // 4、删除最后一个元素
            return elements.removeLast()
        }
    }
    
    // 搜索一个元素在堆中的索引
    public func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        // 如果搜索的元素优先权小于对应所有的优先权，则说明该值不在以该索引为根节点的子树
        if sort(element, elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        // 递归搜索该节点的左右子树
        if let j = index(of: element, startingAt: leftChildIndex(ofParentIndex: i)) {
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentIndex: i)) {
            return j
        }
        return nil
    }
    // 判断一个元素是否在堆中
    public func search(of element: Element) -> Bool {
        elements.contains(element)
    }
    
}

