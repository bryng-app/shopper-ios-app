//  This file was automatically generated and should not be edited.

import Apollo

public final class AllUsersQuery: GraphQLQuery {
  public let operationDefinition =
    "query AllUsers {\n  allUsers {\n    __typename\n    fullname\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allUsers", type: .list(.nonNull(.object(AllUser.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allUsers: [AllUser]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allUsers": allUsers.flatMap { (value: [AllUser]) -> [ResultMap] in value.map { (value: AllUser) -> ResultMap in value.resultMap } }])
    }

    public var allUsers: [AllUser]? {
      get {
        return (resultMap["allUsers"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [AllUser] in value.map { (value: ResultMap) -> AllUser in AllUser(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllUser]) -> [ResultMap] in value.map { (value: AllUser) -> ResultMap in value.resultMap } }, forKey: "allUsers")
      }
    }

    public struct AllUser: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("fullname", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fullname: String) {
        self.init(unsafeResultMap: ["__typename": "User", "fullname": fullname])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fullname: String {
        get {
          return resultMap["fullname"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fullname")
        }
      }
    }
  }
}