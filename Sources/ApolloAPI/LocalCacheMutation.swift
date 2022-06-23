import Foundation

public protocol LocalCacheMutation: AnyObject, Hashable {
  static var operationType: GraphQLOperationType { get }

  var variables: GraphQLOperation.Variables? { get }

  associatedtype Data: MutableRootSelectionSet
}

public extension LocalCacheMutation {
  var variables: GraphQLOperation.Variables? {
    return nil
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(variables?.jsonEncodableValue?.jsonValue)
  }

  static func ==(lhs: Self, rhs: Self) -> Bool {
    lhs.variables?.jsonEncodableValue?.jsonValue == rhs.variables?.jsonEncodableValue?.jsonValue
  }
}

public protocol MutableSelectionSet: SelectionSet {
  var __data: DataDict { get set }
}

public extension MutableSelectionSet {
  @inlinable var __typename: String {
    get { __data["__typename"] }
    set { __data["__typename"] = newValue }
  }
}

public extension MutableSelectionSet where Fragments: FragmentContainer {
  @inlinable var fragments: Fragments {
    get { Self.Fragments(data: __data) }
    _modify {
      var f = Self.Fragments(data: __data)
      yield &f
      self.__data._data = f.__data._data
    }
    @available(*, unavailable, message: "mutate properties of the fragment instead.")
    set { preconditionFailure("") }
  }
}

public protocol MutableRootSelectionSet: RootSelectionSet, MutableSelectionSet {}
