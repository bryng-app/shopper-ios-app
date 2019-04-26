//  This file was automatically generated and should not be edited.

import Apollo

public final class AllStoresQuery: GraphQLQuery {
  public let operationDefinition =
    "query AllStores {\n  allStores {\n    __typename\n    name\n    logo\n    openingHours\n    location {\n      __typename\n      latitude\n      longitude\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allStores", type: .nonNull(.list(.nonNull(.object(AllStore.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allStores: [AllStore]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allStores": allStores.map { (value: AllStore) -> ResultMap in value.resultMap }])
    }

    public var allStores: [AllStore] {
      get {
        return (resultMap["allStores"] as! [ResultMap]).map { (value: ResultMap) -> AllStore in AllStore(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllStore) -> ResultMap in value.resultMap }, forKey: "allStores")
      }
    }

    public struct AllStore: GraphQLSelectionSet {
      public static let possibleTypes = ["Store"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("logo", type: .nonNull(.scalar(String.self))),
        GraphQLField("openingHours", type: .nonNull(.scalar(String.self))),
        GraphQLField("location", type: .nonNull(.object(Location.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, logo: String, openingHours: String, location: Location) {
        self.init(unsafeResultMap: ["__typename": "Store", "name": name, "logo": logo, "openingHours": openingHours, "location": location.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var logo: String {
        get {
          return resultMap["logo"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "logo")
        }
      }

      public var openingHours: String {
        get {
          return resultMap["openingHours"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "openingHours")
        }
      }

      public var location: Location {
        get {
          return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "location")
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes = ["GeoPosition"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
          GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoPosition", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }
    }
  }
}

public final class MeQuery: GraphQLQuery {
  public let operationDefinition =
    "query Me {\n  me {\n    __typename\n    fullname\n    email\n    username\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("me", type: .object(Me.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes = ["Me"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("fullname", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fullname: String, email: String, username: String) {
        self.init(unsafeResultMap: ["__typename": "Me", "fullname": fullname, "email": email, "username": username])
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

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
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

public final class AddLoginTokenMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation AddLoginToken {\n  addLoginToken {\n    __typename\n    token\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addLoginToken", type: .object(AddLoginToken.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addLoginToken: AddLoginToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addLoginToken": addLoginToken.flatMap { (value: AddLoginToken) -> ResultMap in value.resultMap }])
    }

    public var addLoginToken: AddLoginToken? {
      get {
        return (resultMap["addLoginToken"] as? ResultMap).flatMap { AddLoginToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addLoginToken")
      }
    }

    public struct AddLoginToken: GraphQLSelectionSet {
      public static let possibleTypes = ["LoginToken"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String) {
        self.init(unsafeResultMap: ["__typename": "LoginToken", "token": token])
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

public final class GetJwtTokenMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation GetJWTToken($loginToken: String!) {\n  getJWTToken(loginToken: $loginToken) {\n    __typename\n    token\n  }\n}"

  public var loginToken: String

  public init(loginToken: String) {
    self.loginToken = loginToken
  }

  public var variables: GraphQLMap? {
    return ["loginToken": loginToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getJWTToken", arguments: ["loginToken": GraphQLVariable("loginToken")], type: .object(GetJwtToken.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getJwtToken: GetJwtToken? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "getJWTToken": getJwtToken.flatMap { (value: GetJwtToken) -> ResultMap in value.resultMap }])
    }

    public var getJwtToken: GetJwtToken? {
      get {
        return (resultMap["getJWTToken"] as? ResultMap).flatMap { GetJwtToken(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getJWTToken")
      }
    }

    public struct GetJwtToken: GraphQLSelectionSet {
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

public final class RegisterMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation Register($fullname: String!, $email: String!, $password: String!, $username: String!, $phoneNumber: String, $age: Int, $avatar: String) {\n  createUser(fullname: $fullname, email: $email, password: $password, username: $username, phoneNumber: $phoneNumber, age: $age, avatar: $avatar) {\n    __typename\n    token\n  }\n}"

  public var fullname: String
  public var email: String
  public var password: String
  public var username: String
  public var phoneNumber: String?
  public var age: Int?
  public var avatar: String?

  public init(fullname: String, email: String, password: String, username: String, phoneNumber: String? = nil, age: Int? = nil, avatar: String? = nil) {
    self.fullname = fullname
    self.email = email
    self.password = password
    self.username = username
    self.phoneNumber = phoneNumber
    self.age = age
    self.avatar = avatar
  }

  public var variables: GraphQLMap? {
    return ["fullname": fullname, "email": email, "password": password, "username": username, "phoneNumber": phoneNumber, "age": age, "avatar": avatar]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createUser", arguments: ["fullname": GraphQLVariable("fullname"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "username": GraphQLVariable("username"), "phoneNumber": GraphQLVariable("phoneNumber"), "age": GraphQLVariable("age"), "avatar": GraphQLVariable("avatar")], type: .object(CreateUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
    }

    public var createUser: CreateUser? {
      get {
        return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
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

public final class AddLocationMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation AddLocation($latitude: Float!, $longitude: Float!) {\n  addLocation(location: {latitude: $latitude, longitude: $longitude}) {\n    __typename\n    location {\n      __typename\n      latitude\n      longitude\n    }\n  }\n}"

  public var latitude: Double
  public var longitude: Double

  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }

  public var variables: GraphQLMap? {
    return ["latitude": latitude, "longitude": longitude]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addLocation", arguments: ["location": ["latitude": GraphQLVariable("latitude"), "longitude": GraphQLVariable("longitude")]], type: .nonNull(.object(AddLocation.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addLocation: AddLocation) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addLocation": addLocation.resultMap])
    }

    public var addLocation: AddLocation {
      get {
        return AddLocation(unsafeResultMap: resultMap["addLocation"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addLocation")
      }
    }

    public struct AddLocation: GraphQLSelectionSet {
      public static let possibleTypes = ["Location"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("location", type: .nonNull(.object(Location.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(location: Location) {
        self.init(unsafeResultMap: ["__typename": "Location", "location": location.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var location: Location {
        get {
          return Location(unsafeResultMap: resultMap["location"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "location")
        }
      }

      public struct Location: GraphQLSelectionSet {
        public static let possibleTypes = ["GeoPosition"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("latitude", type: .nonNull(.scalar(Double.self))),
          GraphQLField("longitude", type: .nonNull(.scalar(Double.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(latitude: Double, longitude: Double) {
          self.init(unsafeResultMap: ["__typename": "GeoPosition", "latitude": latitude, "longitude": longitude])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var latitude: Double {
          get {
            return resultMap["latitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "latitude")
          }
        }

        public var longitude: Double {
          get {
            return resultMap["longitude"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "longitude")
          }
        }
      }
    }
  }
}