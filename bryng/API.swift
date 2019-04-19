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

public final class LoginMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation Login($email: String!, $password: String!) {\n  login(email: $email, password: $password) {\n    __typename\n    token\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["Auth"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String) {
        self.init(unsafeResultMap: ["__typename": "Auth", "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}