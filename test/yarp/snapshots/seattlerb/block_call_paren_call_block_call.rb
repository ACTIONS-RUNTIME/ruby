ProgramNode(0...16)(
  [],
  StatementsNode(0...16)(
    [CallNode(0...5)(
       nil,
       nil,
       IDENTIFIER(0...1)("a"),
       nil,
       ArgumentsNode(2...5)(
         [ParenthesesNode(2...5)(
            StatementsNode(3...4)(
              [CallNode(3...4)(
                 nil,
                 nil,
                 IDENTIFIER(3...4)("b"),
                 nil,
                 nil,
                 nil,
                 nil,
                 "b"
               )]
            ),
            (2...3),
            (4...5)
          )]
       ),
       nil,
       nil,
       "a"
     ),
     CallNode(6...16)(
       CallNode(6...7)(
         nil,
         nil,
         IDENTIFIER(6...7)("c"),
         nil,
         nil,
         nil,
         nil,
         "c"
       ),
       DOT(7...8)("."),
       IDENTIFIER(8...9)("d"),
       nil,
       nil,
       nil,
       BlockNode(10...16)([], nil, nil, (10...12), (13...16)),
       "d"
     )]
  )
)
