ProgramNode(0...10)(
  [IDENTIFIER(0...1)("a")],
  StatementsNode(0...10)(
    [MultiWriteNode(0...10)(
       [LocalVariableWriteNode(0...1)((0...1), nil, nil, 0),
        CallNode(3...6)(
          CallNode(3...4)(
            nil,
            nil,
            IDENTIFIER(3...4)("b"),
            nil,
            nil,
            nil,
            nil,
            "b"
          ),
          DOT(4...5)("."),
          CONSTANT(5...6)("C"),
          nil,
          nil,
          nil,
          nil,
          "C="
        )],
       (7...8),
       CallNode(9...10)(
         nil,
         nil,
         IDENTIFIER(9...10)("d"),
         nil,
         nil,
         nil,
         nil,
         "d"
       ),
       nil,
       nil
     )]
  )
)
