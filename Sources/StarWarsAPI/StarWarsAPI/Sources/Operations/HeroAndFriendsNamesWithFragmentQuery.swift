// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI
@_exported import enum ApolloAPI.GraphQLEnum
@_exported import enum ApolloAPI.GraphQLNullable

public class HeroAndFriendsNamesWithFragmentQuery: GraphQLQuery {
  public static let operationName: String = "HeroAndFriendsNamesWithFragment"
  public static let document: DocumentType = .notPersisted(
    definition: .init(
      """
      query HeroAndFriendsNamesWithFragment($episode: Episode) {
        hero(episode: $episode) {
          __typename
          name
          ...FriendsNames
        }
      }
      """,
      fragments: [FriendsNames.self]
    ))

  public var episode: GraphQLNullable<GraphQLEnum<Episode>>

  public init(episode: GraphQLNullable<GraphQLEnum<Episode>>) {
    self.episode = episode
  }

  public var variables: Variables? {
    ["episode": episode]
  }

  public struct Data: StarWarsAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { .Object(StarWarsAPI.Query.self) }
    public static var selections: [Selection] { [
      .field("hero", Hero?.self, arguments: ["episode": .variable("episode")]),
    ] }

    public var hero: Hero? { __data["hero"] }

    /// Hero
    public struct Hero: StarWarsAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { .Interface(StarWarsAPI.Character.self) }
      public static var selections: [Selection] { [
        .field("name", String.self),
        .fragment(FriendsNames.self),
      ] }

      public var name: String { __data["name"] }
      public var friends: [FriendsNames.Friend?]? { __data["friends"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public var friendsNames: FriendsNames { _toFragment() }
      }
    }
  }
}