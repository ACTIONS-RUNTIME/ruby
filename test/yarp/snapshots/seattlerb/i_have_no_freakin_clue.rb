ProgramNode(2...20)(
  [],
  StatementsNode(2...20)(
    [IfNode(2...13)(
       (2...3),
       IntegerNode(0...1)(),
       StatementsNode(4...9)(
         [CallNode(4...9)(
            nil,
            nil,
            IDENTIFIER(4...5)("b"),
            PARENTHESIS_LEFT(5...6)("("),
            ArgumentsNode(6...8)(
              [StringNode(6...8)((6...7), (7...7), (7...8), "")]
            ),
            PARENTHESIS_RIGHT(8...9)(")"),
            nil,
            "b"
          )]
       ),
       ElseNode(10...13)(
         (10...11),
         StatementsNode(12...13)([IntegerNode(12...13)()]),
         nil
       ),
       nil
     ),
     CallNode(14...20)(
       nil,
       nil,
       IDENTIFIER(14...15)("a"),
       nil,
       ArgumentsNode(16...20)(
         [KeywordHashNode(16...20)(
            [AssocNode(16...20)(
               SymbolNode(16...18)(
                 nil,
                 LABEL(16...17)("d"),
                 LABEL_END(17...18)(":"),
                 "d"
               ),
               IntegerNode(19...20)(),
               nil
             )]
          )]
       ),
       nil,
       nil,
       "a"
     )]
  )
)
