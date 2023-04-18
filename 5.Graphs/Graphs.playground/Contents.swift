import Foundation

/// **Graphs**
/// - A graph is a data structure that captures relationships between objects.
/// - It is made up of vertices connected by edges.
/// **Weighted graphs**
/// - In a weighted graph, every edge has a weight associated with it that represents the cost ot using this edge.
/// - These weights let you choose the cheapest or shortest path between two vertices.
/// **Directed graphs**
/// - As well as assigning a weight to an edge, your graphs can also have direction. Directed graphs are more restrictive to traverse, as an edge may only permit traversal in one direction.
/// **Undirected graphs**
/// - You can think of an undirected graph as a directed graph where all edges are bi-directional.
/// - Two connected vertices have edges going back and forth.
/// - The weight of an edge applies to both directions.

public enum EdgeType {

  case directed
  case undirected
}

public protocol Graph {
    
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}


public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable where T: Hashable { }
extension Vertex: Equatable where T: Equatable { }
extension Vertex: CustomStringConvertible {

  public var description: String {
    "\(index): \(data)"
  }
}

public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}


/// **Adjacency list**
public class AdjacencyList<T: Hashable>: Graph {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    public init() { }
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    /// Every edge in an undirected graph can be traversed in both directions.
    public func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source)
            .first { $0.destination == destination }?
            .weight
    }
}

extension AdjacencyList: CustomStringConvertible {

  public var description: String {
    var result = ""
    for (vertex, edges) in adjacencies { // 1
      var edgeString = ""
      for (index, edge) in edges.enumerated() { // 2
        if index != edges.count - 1 {
          edgeString.append("\(edge.destination), ")
        } else {
          edgeString.append("\(edge.destination)")
        }
      }
      result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
    }
    return result
  }
}

let graph = AdjacencyList<String>()

let singapore = graph.createVertex(data: "Singapore")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")

graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(graph)

graph.weight(from: singapore, to: tokyo)

graph.weight(from: singapore, to: seattle)

for edge in graph.edges(from: sanFrancisco) {
    print("from: \(edge.source) to: \(edge.destination)")
}


/// **Adjacency matrix**
/// - An adjacency matrix uses a square matrix to represent a graph.
/// - This matrix is a two-dimensional array wherein the value of matrix[row][colum] is the weight of the edge between the vertices at row and column.
/// 1. First create a list of the vertices.
/// 2. Then, build up a grid of weights, row by row.
/// 3. Finally, join both descriptions together and return them.
public class AdjacencyMatrix<T>: Graph {
    private var vertices: [Vertex<T>] = []
    private var weights: [[Double?]] = []

    public init() { }

    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)

        // 기존에 있던 값에 추가된 vertex 가중치를 위한 자리 만들기
        for i in 0..<weights.count {
            weights[i].append(nil)
        }
        
        // 추가된 vertex의 가중치를 위한 자리 만들기
        let row = [Double?](repeating: nil, count: vertices.count)
        weights.append(row)

        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        weights[source.index][destination.index] = weight
    }
    
    public func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        var edges: [Edge<T>] = []
        for column in 0..<weights.count {
            if let weight = weights[source.index][column] {
                edges.append(Edge(
                    source: source,
                    destination: vertices[column],
                    weight: weight
                ))
            }
        }
        return edges
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weights[source.index][destination.index]
    }
}

extension AdjacencyMatrix: CustomStringConvertible {

  public var description: String {
    // 1
    let verticesDescription = vertices.map { "\($0)" }
                                      .joined(separator: "\n")
    // 2
    var grid: [String] = []
    for i in 0..<weights.count {
      var row = ""
      for j in 0..<weights.count {
        if let value = weights[i][j] {
          row += "\(value)\t"
        } else {
          row += "ø\t\t"
        }
      }
      grid.append(row)
    }
    let edgesDescription = grid.joined(separator: "\n")
    // 3
    return "\(verticesDescription)\n\n\(edgesDescription)"
  }
}

let graph2 = AdjacencyMatrix<String>()

let singapore2 = graph2.createVertex(data: "Singapore")
let tokyo2 = graph2.createVertex(data: "Tokyo")
let hongKong2 = graph2.createVertex(data: "Hong Kong")
let detroit2 = graph2.createVertex(data: "Detroit")
let sanFrancisco2 = graph2.createVertex(data: "San Francisco")
let washingtonDC2 = graph2.createVertex(data: "Washington DC")
let austinTexas2 = graph2.createVertex(data: "Austin Texas")
let seattle2 = graph2.createVertex(data: "Seattle")

graph2.add(.directed, from: singapore2, to: hongKong2, weight: 300)
graph2.add(.directed, from: singapore2, to: tokyo2, weight: 500)
graph2.add(.directed, from: hongKong2, to: tokyo2, weight: 250)
graph2.add(.directed, from: tokyo2, to: detroit2, weight: 450)
graph2.add(.directed, from: tokyo2, to: washingtonDC2, weight: 300)
graph2.add(.directed, from: hongKong2, to: sanFrancisco2, weight: 600)
graph2.add(.directed, from: detroit2, to: austinTexas2, weight: 50)
graph2.add(.directed, from: austinTexas2, to: washingtonDC2, weight: 292)
graph2.add(.directed, from: sanFrancisco2, to: washingtonDC2, weight: 337)
graph2.add(.directed, from: washingtonDC2, to: seattle2, weight: 277)
graph2.add(.directed, from: sanFrancisco2, to: seattle2, weight: 218)
graph2.add(.directed, from: austinTexas2, to: sanFrancisco2, weight: 297)

print(graph2)


24 % 5
24/3
24/1
5/2
6/2

func solution(_ citations:[Int]) -> Int {
    var sortedCitations = citations.sorted()
    
    let count = sortedCitations.count
    
    var result = 0
    
    var big = false
    
    for (index, value) in sortedCitations.enumerated() {
        if value <= count - index && index <= value {
            result = value
            big = true
            print(result)
        }
//        print(index)
    }
    if big == false {
        return count
    }
    
    return result
}
solution([10,100])
