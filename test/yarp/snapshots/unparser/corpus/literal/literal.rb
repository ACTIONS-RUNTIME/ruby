ProgramNode(0...916)(
  [],
  StatementsNode(0...916)(
    [HashNode(0...38)(
       (0...1),
       [AssocNode(2...53)(
          StringNode(2...7)((2...3), (3...6), (6...7), "foo"),
          InterpolatedStringNode(11...53)(
            (11...21),
            [StringNode(39...41)(nil, (39...41), nil, "  "),
             StringInterpolatedNode(41...44)((41...43), nil, (43...44)),
             StringNode(44...45)(nil, (44...45), nil, "\n")],
            (45...53)
          ),
          (8...10)
        ),
        AssocNode(23...36)(
          StringNode(23...28)((23...24), (24...27), (27...28), "bar"),
          SymbolNode(32...36)(
            SYMBOL_BEGIN(32...33)(":"),
            IDENTIFIER(33...36)("baz"),
            nil,
            "baz"
          ),
          (29...31)
        )],
       (37...38)
     ),
     HashNode(53...84)(
       (53...54),
       [AssocNode(55...67)(
          StringNode(55...60)((55...56), (56...59), (59...60), "foo"),
          StringNode(64...67)((64...66), (66...66), (66...67), ""),
          (61...63)
        ),
        AssocNode(69...82)(
          StringNode(69...74)((69...70), (70...73), (73...74), "bar"),
          SymbolNode(78...82)(
            SYMBOL_BEGIN(78...79)(":"),
            IDENTIFIER(79...82)("baz"),
            nil,
            "baz"
          ),
          (75...77)
        )],
       (83...84)
     ),
     ArrayNode(85...97)(
       [StringNode(86...91)((86...87), (87...90), (90...91), "foo"),
        StringNode(93...96)((93...95), (95...95), (95...96), "")],
       (85...86),
       (96...97)
     ),
     CallNode(98...113)(
       CallNode(98...111)(
         nil,
         nil,
         IDENTIFIER(98...99)("a"),
         PARENTHESIS_LEFT(99...100)("("),
         ArgumentsNode(100...128)(
           [InterpolatedStringNode(100...128)(
              (100...110),
              [StringNode(114...116)(nil, (114...116), nil, "  "),
               StringInterpolatedNode(116...119)(
                 (116...118),
                 nil,
                 (118...119)
               ),
               StringNode(119...120)(nil, (119...120), nil, "\n")],
              (120...128)
            )]
         ),
         PARENTHESIS_RIGHT(110...111)(")"),
         nil,
         "a"
       ),
       DOT(111...112)("."),
       IDENTIFIER(112...113)("a"),
       nil,
       nil,
       nil,
       nil,
       "a"
     ),
     CallNode(128...136)(
       CallNode(128...134)(
         nil,
         nil,
         IDENTIFIER(128...129)("a"),
         PARENTHESIS_LEFT(129...130)("("),
         ArgumentsNode(130...133)(
           [StringNode(130...133)((130...132), (132...132), (132...133), "")]
         ),
         PARENTHESIS_RIGHT(133...134)(")"),
         nil,
         "a"
       ),
       DOT(134...135)("."),
       IDENTIFIER(135...136)("a"),
       nil,
       nil,
       nil,
       nil,
       "a"
     ),
     HashNode(137...167)(
       (137...138),
       [AssocNode(139...182)(
          StringNode(139...144)((139...140), (140...143), (143...144), "foo"),
          InterpolatedStringNode(148...182)(
            (148...158),
            [StringNode(168...170)(nil, (168...170), nil, "  "),
             StringInterpolatedNode(170...173)((170...172), nil, (172...173)),
             StringNode(173...174)(nil, (173...174), nil, "\n")],
            (174...182)
          ),
          (145...147)
        ),
        AssocSplatNode(160...165)(
          CallNode(162...165)(
            nil,
            nil,
            IDENTIFIER(162...165)("baz"),
            nil,
            nil,
            nil,
            nil,
            "baz"
          ),
          (160...162)
        )],
       (166...167)
     ),
     HashNode(182...205)(
       (182...183),
       [AssocNode(184...196)(
          StringNode(184...189)((184...185), (185...188), (188...189), "foo"),
          StringNode(193...196)((193...195), (195...195), (195...196), ""),
          (190...192)
        ),
        AssocSplatNode(198...203)(
          CallNode(200...203)(
            nil,
            nil,
            IDENTIFIER(200...203)("baz"),
            nil,
            nil,
            nil,
            nil,
            "baz"
          ),
          (198...200)
        )],
       (204...205)
     ),
     InterpolatedStringNode(206...220)(
       (206...207),
       [InstanceVariableReadNode(208...210)(),
        StringNode(210...211)(nil, (210...211), nil, " "),
        ClassVariableReadNode(212...215)(),
        StringNode(215...216)(nil, (215...216), nil, " "),
        GlobalVariableReadNode(217...219)(GLOBAL_VARIABLE(217...219)("$a"))],
       (219...220)
     ),
     IntegerNode(221...222)(),
     CallNode(223...226)(
       IntegerNode(224...226)(),
       nil,
       UPLUS(223...224)("+"),
       nil,
       nil,
       nil,
       nil,
       "+@"
     ),
     IntegerNode(227...228)(),
     IntegerNode(229...230)(),
     RationalNode(231...233)(IntegerNode(231...232)()),
     RationalNode(234...238)(FloatNode(234...237)()),
     RationalNode(239...243)(FloatNode(239...242)()),
     ImaginaryNode(244...246)(IntegerNode(244...245)()),
     CallNode(247...250)(
       ImaginaryNode(248...250)(IntegerNode(248...249)()),
       nil,
       UMINUS_NUM(247...248)("-"),
       nil,
       nil,
       nil,
       nil,
       "-@"
     ),
     ImaginaryNode(251...255)(FloatNode(251...254)()),
     CallNode(256...261)(
       ImaginaryNode(257...261)(FloatNode(257...260)()),
       nil,
       UMINUS_NUM(256...257)("-"),
       nil,
       nil,
       nil,
       nil,
       "-@"
     ),
     ImaginaryNode(262...294)(IntegerNode(262...293)()),
     ImaginaryNode(295...298)(
       RationalNode(295...297)(IntegerNode(295...296)())
     ),
     StringConcatNode(299...310)(
       StringNode(299...304)((299...300), (300...303), (303...304), "foo"),
       StringNode(305...310)((305...306), (306...309), (309...310), "bar")
     ),
     InterpolatedStringNode(311...326)(
       (311...312),
       [StringNode(312...319)(nil, (312...319), nil, "foobar "),
        StringInterpolatedNode(319...325)(
          (319...321),
          StatementsNode(321...324)(
            [CallNode(321...324)(
               nil,
               nil,
               IDENTIFIER(321...324)("baz"),
               nil,
               nil,
               nil,
               nil,
               "baz"
             )]
          ),
          (324...325)
        )],
       (325...326)
     ),
     InterpolatedStringNode(327...339)(
       (327...328),
       [StringNode(328...331)(nil, (328...331), nil, "foo"),
        StringInterpolatedNode(331...335)(
          (331...333),
          StatementsNode(333...334)([IntegerNode(333...334)()]),
          (334...335)
        ),
        StringNode(335...338)(nil, (335...338), nil, "bar")],
       (338...339)
     ),
     InterpolatedStringNode(340...349)(
       (340...341),
       [StringNode(341...345)(nil, (341...345), nil, "\\\\"),
        StringInterpolatedNode(345...348)((345...347), nil, (347...348))],
       (348...349)
     ),
     InterpolatedStringNode(350...359)(
       (350...351),
       [StringInterpolatedNode(351...354)((351...353), nil, (353...354)),
        StringNode(354...358)(nil, (354...358), nil, "\#{}")],
       (358...359)
     ),
     InterpolatedStringNode(360...369)(
       (360...361),
       [StringNode(361...365)(nil, (361...365), nil, "\#{}"),
        StringInterpolatedNode(365...368)((365...367), nil, (367...368))],
       (368...369)
     ),
     StringNode(370...385)(
       (370...371),
       (371...384),
       (384...385),
       "foo\\\#{@bar}"
     ),
     StringNode(386...390)((386...387), (387...389), (389...390), "\""),
     StringNode(391...400)((391...392), (392...399), (399...400), "foo bar"),
     StringNode(401...411)(
       (401...402),
       (402...410),
       (410...411),
       "foo\n" + "bar"
     ),
     XStringNode(412...417)((412...413), (413...416), (416...417), "foo"),
     InterpolatedXStringNode(418...430)(
       (418...419),
       [StringNode(419...422)(nil, (419...422), nil, "foo"),
        StringInterpolatedNode(422...429)(
          (422...424),
          StatementsNode(424...428)([InstanceVariableReadNode(424...428)()]),
          (428...429)
        )],
       (429...430)
     ),
     XStringNode(431...434)((431...432), (432...433), (433...434), ")"),
     XStringNode(435...439)((435...436), (436...438), (438...439), "`"),
     XStringNode(440...443)((440...441), (441...442), (442...443), "\""),
     SymbolNode(444...448)(
       SYMBOL_BEGIN(444...445)(":"),
       IDENTIFIER(445...448)("foo"),
       nil,
       "foo"
     ),
     InterpolatedSymbolNode(449...455)(
       SYMBOL_BEGIN(449...451)(":\""),
       [StringNode(451...454)(nil, (451...454), nil, "A B")],
       STRING_END(454...455)("\"")
     ),
     SymbolNode(456...460)(
       SYMBOL_BEGIN(456...457)(":"),
       IDENTIFIER(457...460)("foo"),
       nil,
       "foo"
     ),
     InterpolatedSymbolNode(461...467)(
       SYMBOL_BEGIN(461...463)(":\""),
       [StringNode(463...466)(nil, (463...466), nil, "A B")],
       STRING_END(466...467)("\"")
     ),
     InterpolatedSymbolNode(468...475)(
       SYMBOL_BEGIN(468...470)(":\""),
       [StringNode(470...474)(nil, (470...474), nil, "A\"B")],
       STRING_END(474...475)("\"")
     ),
     InterpolatedSymbolNode(476...479)(
       SYMBOL_BEGIN(476...478)(":\""),
       [],
       STRING_END(478...479)("\"")
     ),
     RegularExpressionNode(480...485)(
       (480...481),
       (481...484),
       (484...485),
       "foo",
       0
     ),
     RegularExpressionNode(486...514)(
       (486...487),
       (487...513),
       (513...514),
       "[^-+',./:@[:alnum:][]]+",
       0
     ),
     InterpolatedRegularExpressionNode(515...527)(
       (515...516),
       [StringNode(516...519)(nil, (516...519), nil, "foo"),
        StringInterpolatedNode(519...526)(
          (519...521),
          StatementsNode(521...525)([InstanceVariableReadNode(521...525)()]),
          (525...526)
        )],
       (526...527),
       0
     ),
     InterpolatedRegularExpressionNode(528...543)(
       (528...529),
       [StringNode(529...532)(nil, (529...532), nil, "foo"),
        StringInterpolatedNode(532...539)(
          (532...534),
          StatementsNode(534...538)([InstanceVariableReadNode(534...538)()]),
          (538...539)
        )],
       (539...543),
       7
     ),
     InterpolatedRegularExpressionNode(544...557)(
       (544...545),
       [StringInterpolatedNode(545...556)(
          (545...547),
          StatementsNode(547...555)(
            [StringNode(547...555)(
               (547...548),
               (548...554),
               (554...555),
               "\u0000"
             )]
          ),
          (555...556)
        )],
       (556...557),
       0
     ),
     RegularExpressionNode(558...562)(
       (558...559),
       (559...561),
       (561...562),
       "\n",
       0
     ),
     RegularExpressionNode(563...567)(
       (563...564),
       (564...566),
       (566...567),
       "\n",
       0
     ),
     RegularExpressionNode(568...573)(
       (568...569),
       (569...571),
       (571...573),
       "\n",
       4
     ),
     RegularExpressionNode(574...581)(
       (574...575),
       (575...579),
       (579...581),
       "//",
       4
     ),
     InterpolatedSymbolNode(582...597)(
       SYMBOL_BEGIN(582...584)(":\""),
       [StringNode(584...587)(nil, (584...587), nil, "foo"),
        StringInterpolatedNode(587...593)(
          (587...589),
          StatementsNode(589...592)(
            [CallNode(589...592)(
               nil,
               nil,
               IDENTIFIER(589...592)("bar"),
               nil,
               nil,
               nil,
               nil,
               "bar"
             )]
          ),
          (592...593)
        ),
        StringNode(593...596)(nil, (593...596), nil, "baz")],
       STRING_END(596...597)("\"")
     ),
     InterpolatedSymbolNode(598...609)(
       SYMBOL_BEGIN(598...600)(":\""),
       [StringInterpolatedNode(600...608)(
          (600...602),
          StatementsNode(602...607)(
            [StringNode(602...607)(
               (602...603),
               (603...606),
               (606...607),
               "foo"
             )]
          ),
          (607...608)
        )],
       STRING_END(608...609)("\"")
     ),
     RangeNode(610...624)(
       ParenthesesNode(610...621)(
         StatementsNode(611...620)(
           [CallNode(611...620)(
              FloatNode(611...614)(),
              nil,
              SLASH(615...616)("/"),
              nil,
              ArgumentsNode(617...620)([FloatNode(617...620)()]),
              nil,
              nil,
              "/"
            )]
         ),
         (610...611),
         (620...621)
       ),
       IntegerNode(623...624)(),
       (621...623)
     ),
     RangeNode(625...639)(
       IntegerNode(625...626)(),
       ParenthesesNode(628...639)(
         StatementsNode(629...638)(
           [CallNode(629...638)(
              FloatNode(629...632)(),
              nil,
              SLASH(633...634)("/"),
              nil,
              ArgumentsNode(635...638)([FloatNode(635...638)()]),
              nil,
              nil,
              "/"
            )]
         ),
         (628...629),
         (638...639)
       ),
       (626...628)
     ),
     RangeNode(640...656)(
       ParenthesesNode(640...651)(
         StatementsNode(641...650)(
           [CallNode(641...650)(
              FloatNode(641...644)(),
              nil,
              SLASH(645...646)("/"),
              nil,
              ArgumentsNode(647...650)([FloatNode(647...650)()]),
              nil,
              nil,
              "/"
            )]
         ),
         (640...641),
         (650...651)
       ),
       IntegerNode(653...656)(),
       (651...653)
     ),
     CallNode(657...661)(
       FloatNode(658...661)(),
       nil,
       UMINUS_NUM(657...658)("-"),
       nil,
       nil,
       nil,
       nil,
       "-@"
     ),
     FloatNode(662...665)(),
     ArrayNode(666...672)(
       [IntegerNode(667...668)(), IntegerNode(670...671)()],
       (666...667),
       (671...672)
     ),
     ArrayNode(673...684)(
       [IntegerNode(674...675)(),
        ParenthesesNode(677...679)(nil, (677...678), (678...679)),
        CallNode(681...683)(
          nil,
          nil,
          IDENTIFIER(681...683)("n2"),
          nil,
          nil,
          nil,
          nil,
          "n2"
        )],
       (673...674),
       (683...684)
     ),
     ArrayNode(685...688)(
       [IntegerNode(686...687)()],
       (685...686),
       (687...688)
     ),
     ArrayNode(689...691)([], (689...690), (690...691)),
     ArrayNode(692...702)(
       [IntegerNode(693...694)(),
        SplatNode(696...701)(
          (696...697),
          InstanceVariableReadNode(697...701)()
        )],
       (692...693),
       (701...702)
     ),
     ArrayNode(703...713)(
       [SplatNode(704...709)(
          (704...705),
          InstanceVariableReadNode(705...709)()
        ),
        IntegerNode(711...712)()],
       (703...704),
       (712...713)
     ),
     ArrayNode(714...728)(
       [SplatNode(715...720)(
          (715...716),
          InstanceVariableReadNode(716...720)()
        ),
        SplatNode(722...727)(
          (722...723),
          InstanceVariableReadNode(723...727)()
        )],
       (714...715),
       (727...728)
     ),
     HashNode(729...731)((729...730), [], (730...731)),
     HashNode(732...744)(
       (732...733),
       [AssocNode(734...742)(
          ParenthesesNode(734...736)(nil, (734...735), (735...736)),
          ParenthesesNode(740...742)(nil, (740...741), (741...742)),
          (737...739)
        )],
       (743...744)
     ),
     HashNode(745...755)(
       (745...746),
       [AssocNode(747...753)(
          IntegerNode(747...748)(),
          IntegerNode(752...753)(),
          (749...751)
        )],
       (754...755)
     ),
     HashNode(756...774)(
       (756...757),
       [AssocNode(758...764)(
          IntegerNode(758...759)(),
          IntegerNode(763...764)(),
          (760...762)
        ),
        AssocNode(766...772)(
          IntegerNode(766...767)(),
          IntegerNode(771...772)(),
          (768...770)
        )],
       (773...774)
     ),
     HashNode(775...802)(
       (775...776),
       [AssocNode(777...794)(
          SymbolNode(777...779)(
            nil,
            LABEL(777...778)("a"),
            LABEL_END(778...779)(":"),
            "a"
          ),
          ParenthesesNode(780...794)(
            StatementsNode(781...793)(
              [RescueModifierNode(781...793)(
                 IntegerNode(781...782)(),
                 (783...789),
                 CallNode(790...793)(
                   nil,
                   nil,
                   IDENTIFIER(790...793)("foo"),
                   nil,
                   nil,
                   nil,
                   nil,
                   "foo"
                 )
               )]
            ),
            (780...781),
            (793...794)
          ),
          nil
        ),
        AssocNode(796...800)(
          SymbolNode(796...798)(
            nil,
            LABEL(796...797)("b"),
            LABEL_END(797...798)(":"),
            "b"
          ),
          IntegerNode(799...800)(),
          nil
        )],
       (801...802)
     ),
     HashNode(803...817)(
       (803...804),
       [AssocNode(805...809)(
          SymbolNode(805...807)(
            nil,
            LABEL(805...806)("a"),
            LABEL_END(806...807)(":"),
            "a"
          ),
          IntegerNode(808...809)(),
          nil
        ),
        AssocNode(811...815)(
          SymbolNode(811...813)(
            nil,
            LABEL(811...812)("b"),
            LABEL_END(812...813)(":"),
            "b"
          ),
          IntegerNode(814...815)(),
          nil
        )],
       (816...817)
     ),
     HashNode(818...827)(
       (818...819),
       [AssocNode(820...825)(
          SymbolNode(820...822)(
            nil,
            LABEL(820...821)("a"),
            LABEL_END(821...822)(":"),
            "a"
          ),
          SymbolNode(823...825)(
            SYMBOL_BEGIN(823...824)(":"),
            IDENTIFIER(824...825)("a"),
            nil,
            "a"
          ),
          nil
        )],
       (826...827)
     ),
     HashNode(828...843)(
       (828...829),
       [AssocNode(830...841)(
          InterpolatedSymbolNode(830...836)(
            SYMBOL_BEGIN(830...832)(":\""),
            [StringNode(832...835)(nil, (832...835), nil, "a b")],
            STRING_END(835...836)("\"")
          ),
          IntegerNode(840...841)(),
          (837...839)
        )],
       (842...843)
     ),
     HashNode(844...856)(
       (844...845),
       [AssocNode(846...854)(
          SymbolNode(846...849)(
            SYMBOL_BEGIN(846...847)(":"),
            UMINUS(847...849)("-@"),
            nil,
            "-@"
          ),
          IntegerNode(853...854)(),
          (850...852)
        )],
       (855...856)
     ),
     InterpolatedStringNode(857...869)(
       (857...858),
       [StringInterpolatedNode(858...861)((858...860), nil, (860...861)),
        StringNode(861...862)(nil, (861...862), nil, "\n"),
        StringInterpolatedNode(862...865)((862...864), nil, (864...865)),
        StringNode(865...868)(nil, (865...868), nil, "\n" + "a")],
       (868...869)
     ),
     CallNode(870...892)(
       nil,
       nil,
       IDENTIFIER(870...873)("foo"),
       nil,
       nil,
       nil,
       BlockNode(874...892)(
         [],
         nil,
         StatementsNode(878...890)(
           [InterpolatedStringNode(878...890)(
              (878...879),
              [StringInterpolatedNode(879...882)(
                 (879...881),
                 nil,
                 (881...882)
               ),
               StringNode(882...883)(nil, (882...883), nil, "\n"),
               StringInterpolatedNode(883...886)(
                 (883...885),
                 nil,
                 (885...886)
               ),
               StringNode(886...889)(nil, (886...889), nil, "\n" + "a")],
              (889...890)
            )]
         ),
         (874...875),
         (891...892)
       ),
       "foo"
     ),
     InterpolatedSymbolNode(893...901)(
       SYMBOL_BEGIN(893...895)(":\""),
       [StringNode(895...900)(nil, (895...900), nil, "a\\\n" + "b")],
       STRING_END(900...901)("\"")
     ),
     InterpolatedXStringNode(902...916)(
       (902...903),
       [StringNode(903...907)(nil, (903...907), nil, "  x\n"),
        StringInterpolatedNode(907...913)(
          (907...909),
          StatementsNode(909...912)(
            [CallNode(909...912)(
               nil,
               nil,
               IDENTIFIER(909...912)("foo"),
               nil,
               nil,
               nil,
               nil,
               "foo"
             )]
          ),
          (912...913)
        ),
        StringNode(913...915)(nil, (913...915), nil, "\n" + "#")],
       (915...916)
     )]
  )
)
