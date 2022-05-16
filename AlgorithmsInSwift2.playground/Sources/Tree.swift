import Foundation
/// 树节点
public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []
    
    public init(_ value: T) {
        self.value = value
    }
    
    public  func add(_ child: TreeNode) {
        children.append(child)
    }
}


extension TreeNode {
    /// 深度优先搜索
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
    
    /// 广度优先搜索
    public func forEachLeverOrder(visit: (TreeNode) -> Void) {
        visit(self)
        var queue = QueueArray<TreeNode>()
        children.forEach {
            queue.enqueue($0)
        }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach{ queue.enqueue($0) }
        }
    }
}

extension TreeNode where T: Equatable {
    /// 元素搜索
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLeverOrder { node in
            if node.value == value {
                result = node
            }
        }
        return result
    }
}


