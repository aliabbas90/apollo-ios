// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public class HeroNameWithIDQuery: GraphQLQuery {
  public let operationName: String = "HeroNameWithID"
  public let document: DocumentType = .notPersisted(
    definition: .init(
      """
      query HeroNameWithID($episode: Episode) {
        hero(episode: $episode) {
          __typename
          id
          name
        }
      }
      """
    ))

  public var episode: GraphQLNullable<GraphQLEnum<Episode>>

  public init(episode: GraphQLNullable<GraphQLEnum<Episode>>) {
    self.episode = episode
  }

  public var variables: Variables? {
    ["episode": episode]
  }

  public struct Data: StarWarsAPI.SelectionSet {
    public let data: DataDict
    public init(data: DataDict) { self.data = data }

    public static var __parentType: ParentType { .Object(StarWarsAPI.Query.self) }
    public static var selections: [Selection] { [
      .field("hero", Hero?.self, arguments: ["episode": .variable("episode")]),
    ] }

    public var hero: Hero? { data["hero"] }

    /// Hero
    public struct Hero: StarWarsAPI.SelectionSet {
      public let data: DataDict
      public init(data: DataDict) { self.data = data }

      public static var __parentType: ParentType { .Interface(StarWarsAPI.Character.self) }
      public static var selections: [Selection] { [
        .field("id", ID.self),
        .field("name", String.self),
      ] }

      public var id: ID { data["id"] }
      public var name: String { data["name"] }
    }
  }
}