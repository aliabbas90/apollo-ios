import Foundation
import ApolloUtils

/// Provides the format to convert a [GraphQL Input Object](https://spec.graphql.org/draft/#sec-Input-Objects)
/// into Swift code.
struct InputObjectTemplate: TemplateRenderer {
  /// IR representation of source [GraphQL Input Object](https://spec.graphql.org/draft/#sec-Input-Objects).
  let graphqlInputObject: GraphQLInputObjectType
  /// IR representation of a GraphQL schema.
  let schema: IR.Schema

  let config: ReferenceWrapped<ApolloCodegenConfiguration>

  let target: TemplateTarget = .schemaFile

  var template: TemplateString {
    TemplateString(
    """
    \(embeddedAccessControlModifier)\
    struct \(graphqlInputObject.name.firstUppercased): InputObject {
      public private(set) var __data: InputDict
    
      public init(_ data: InputDict) {
        __data = data
      }

      public init(
        \(InitializerParametersTemplate())
      ) {
        __data = InputDict([
          \(InputDictInitializerTemplate())
        ])
      }

      \(graphqlInputObject.fields.map({ "\(FieldPropertyTemplate($1))" }), separator: "\n\n")
    }
    """
    )
  }

  private func InitializerParametersTemplate() -> TemplateString {
    TemplateString("""
    \(graphqlInputObject.fields.map({
      "\($1.name): \($1.renderInputValueType(includeDefault: true, inSchemaNamed: schema.name))"
    }), separator: ",\n")
    """)
  }

  private func InputDictInitializerTemplate() -> TemplateString {
    TemplateString("""
    \(graphqlInputObject.fields.map({ "\"\($1.name)\": \($1.name)" }), separator: ",\n")
    """)
  }

  private func FieldPropertyTemplate(_ field: GraphQLInputField) -> String {
    """
    public var \(field.name): \(field.renderInputValueType(inSchemaNamed: schema.name)) {
      get { __data.\(field.name) }
      set { __data.\(field.name) = newValue }
    }
    """
  }
}
