ProgramNode(0...278)(
  [IDENTIFIER(64...67)("foo")],
  StatementsNode(0...278)(
    [CallNode(0...9)(
       nil,
       nil,
       IDENTIFIER(0...3)("foo"),
       nil,
       ArgumentsNode(4...9)(
         [RegularExpressionNode(4...9)((4...5), (5...8), (8...9), "bar", 0)]
       ),
       nil,
       nil,
       "foo"
     ),
     RegularExpressionNode(11...19)((11...14), (14...17), (17...19), "abc", 1),
     RegularExpressionNode(21...26)((21...22), (22...25), (25...26), "a\b", 0),
     InterpolatedRegularExpressionNode(28...39)(
       (28...29),
       [StringNode(29...33)(nil, (29...33), nil, "aaa "),
        GlobalVariableReadNode(34...38)(GLOBAL_VARIABLE(34...38)("$bbb"))],
       (38...39),
       0
     ),
     InterpolatedRegularExpressionNode(41...57)(
       (41...42),
       [StringNode(42...46)(nil, (42...46), nil, "aaa "),
        StringInterpolatedNode(46...52)(
          (46...48),
          StatementsNode(48...51)(
            [CallNode(48...51)(
               nil,
               nil,
               IDENTIFIER(48...51)("bbb"),
               nil,
               nil,
               nil,
               nil,
               "bbb"
             )]
          ),
          (51...52)
        ),
        StringNode(52...56)(nil, (52...56), nil, " ccc")],
       (56...57),
       0
     ),
     ArrayNode(59...86)(
       [CallNode(60...80)(
          RegularExpressionNode(60...73)(
            (60...61),
            (61...72),
            (72...73),
            "(?<foo>bar)",
            0
          ),
          nil,
          EQUAL_TILDE(74...76)("=~"),
          nil,
          ArgumentsNode(77...80)(
            [CallNode(77...80)(
               nil,
               nil,
               IDENTIFIER(77...80)("baz"),
               nil,
               nil,
               nil,
               nil,
               "baz"
             )]
          ),
          nil,
          nil,
          "=~"
        ),
        LocalVariableReadNode(82...85)(0)],
       (59...60),
       (85...86)
     ),
     RegularExpressionNode(88...94)((88...89), (89...92), (92...94), "abc", 1),
     RegularExpressionNode(96...122)(
       (96...99),
       (99...120),
       (120...122),
       "[a-z$._?][w$.?\#@~]*:",
       1
     ),
     RegularExpressionNode(124...161)(
       (124...127),
       (127...159),
       (159...161),
       "([a-z$._?][w$.?\#@~]*)( +)(equ)",
       1
     ),
     RegularExpressionNode(163...188)(
       (163...166),
       (166...186),
       (186...188),
       "[a-z$._?][w$.?\#@~]*",
       1
     ),
     RegularExpressionNode(190...249)(
       (190...193),
       (193...248),
       (248...249),
       "\n" + "(?:[w\#$%_']|()|(,)|[]|[0-9])*\n" + "  (?:[w\#$%_']+)\n",
       0
     ),
     CallNode(251...267)(
       RegularExpressionNode(251...259)(
         (251...252),
         (252...258),
         (258...259),
         "(?#))",
         0
       ),
       nil,
       EQUAL_TILDE(260...262)("=~"),
       nil,
       ArgumentsNode(263...267)(
         [StringNode(263...267)((263...264), (264...266), (266...267), "hi")]
       ),
       nil,
       nil,
       "=~"
     ),
     RegularExpressionNode(269...278)(
       (269...272),
       (272...277),
       (277...278),
       "pound",
       0
     )]
  )
)
