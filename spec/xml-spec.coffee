describe "MEI grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-mei")

    runs ->
      grammar = atom.grammars.grammarForScopeName("text.mei")

  it "parses the grammar", ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe "text.mei"

  it "tokenizes comments in internal subsets correctly", ->
    lines = grammar.tokenizeLines """
      <!DOCTYPE root [
      <a> <!-- [] -->
      <b> <!-- [] -->
      <c> <!-- [] -->
      ]>
    """

    expect(lines[1][1]).toEqual value: '<!--', scopes: ['text.mei', 'meta.tag.sgml.doctype.xml', 'meta.internalsubset.xml', 'comment.block.xml', 'punctuation.definition.comment.xml']
    expect(lines[2][1]).toEqual value: '<!--', scopes: ['text.mei', 'meta.tag.sgml.doctype.xml', 'meta.internalsubset.xml', 'comment.block.xml', 'punctuation.definition.comment.xml']
    expect(lines[3][1]).toEqual value: '<!--', scopes: ['text.mei', 'meta.tag.sgml.doctype.xml', 'meta.internalsubset.xml', 'comment.block.xml', 'punctuation.definition.comment.xml']
