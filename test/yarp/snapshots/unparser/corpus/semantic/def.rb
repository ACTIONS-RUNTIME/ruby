ProgramNode(0...55)(
  [],
  StatementsNode(0...55)(
    [DefNode(0...21)(
       (4...7),
       nil,
       nil,
       StatementsNode(10...17)(
         [ParenthesesNode(10...17)(
            StatementsNode(11...16)(
              [CallNode(11...16)(
                 CallNode(11...12)(
                   nil,
                   nil,
                   IDENTIFIER(11...12)("a"),
                   nil,
                   nil,
                   nil,
                   nil,
                   "a"
                 ),
                 nil,
                 MINUS(13...14)("-"),
                 nil,
                 ArgumentsNode(15...16)(
                   [CallNode(15...16)(
                      nil,
                      nil,
                      IDENTIFIER(15...16)("b"),
                      nil,
                      nil,
                      nil,
                      nil,
                      "b"
                    )]
                 ),
                 nil,
                 nil,
                 "-"
               )]
            ),
            (10...11),
            (16...17)
          )]
       ),
       [],
       (0...3),
       nil,
       nil,
       nil,
       nil,
       (18...21)
     ),
     DefNode(23...55)(
       (27...30),
       nil,
       nil,
       StatementsNode(33...51)(
         [RescueModifierNode(33...51)(
            CallNode(33...34)(
              nil,
              nil,
              IDENTIFIER(33...34)("a"),
              nil,
              nil,
              nil,
              nil,
              "a"
            ),
            (35...41),
            ConstantReadNode(42...51)()
          )]
       ),
       [],
       (23...26),
       nil,
       nil,
       nil,
       nil,
       (52...55)
     )]
  )
)
