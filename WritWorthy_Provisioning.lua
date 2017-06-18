-- Parse a food or dring request.

local WritWorthy = _G['WritWorthy'] -- defined in WritWorthy_Define.lua

WritWorthy.Provisioning = {
    savedVarVersion = 2
}

local Provisioning = WritWorthy.Provisioning
local Util         = WritWorthy.Util
local Fail         = WritWorthy.Util.Fail
local Log          = WritWorthy.Log

-- Recipe item_id list from @Phinix's most excellent ESO Master Recipe List
-- which in turn got much of its data from @Sneak-Thief's ESO Master Provisioning Database
-- and @Daveh's ESO Data Pages.
--
--  fooddrink  recipe
--  item_id    item_id
--  --------   -----
--
Provisioning.FOODDRINK_TO_RECIPE_ITEM_ID = {
    [ 33526] = 45888
,   [ 28358] = 45911
,   [ 33819] = 45935
,   [ 42804] = 45891
,   [ 28289] = 45915
,   [ 28362] = 45938
,   [ 28334] = 45894
,   [ 28301] = 45918
,   [ 28374] = 45941
,   [ 33849] = 45897
,   [ 28313] = 45921
,   [ 28386] = 45944
,   [ 28342] = 45900
,   [ 33484] = 45924
,   [ 28398] = 45947
,   [ 33861] = 45903
,   [ 33502] = 45927
,   [ 33563] = 45950
,   [ 28350] = 45906
,   [ 33520] = 45930
,   [ 33581] = 45953
,   [ 33873] = 45909
,   [ 33885] = 45956
,   [ 33801] = 45933
,   [ 33903] = 45959
,   [ 57085] = 56948
,   [ 57088] = 56951
,   [ 33921] = 45962
,   [ 57098] = 56961
,   [ 57101] = 56964
,   [ 43088] = 45965
,   [ 57111] = 56974
,   [ 57114] = 56977
,   [ 43142] = 45968
,   [ 57123] = 56986
,   [ 57126] = 56989
,   [ 57135] = 56998
,   [ 57136] = 56999
,   [ 57137] = 57000
,   [ 68233] = 68189
,   [ 68234] = 68190
,   [ 68235] = 68191
,   [ 33837] = 45889
,   [ 28281] = 45913
,   [ 33825] = 45936
,   [ 33843] = 45892
,   [ 28293] = 45916
,   [ 28366] = 45939
,   [ 42807] = 45895
,   [ 28305] = 45919
,   [ 28378] = 45942
,   [ 33855] = 45898
,   [ 28317] = 45922
,   [ 28390] = 45945
,   [ 42814] = 45901
,   [ 33490] = 45925
,   [ 33552] = 45948
,   [ 33867] = 45904
,   [ 33508] = 45928
,   [ 33569] = 45951
,   [ 42790] = 45907
,   [ 33789] = 45931
,   [ 33587] = 45954
,   [ 33879] = 45910
,   [ 57083] = 56946
,   [ 33891] = 45957
,   [ 33909] = 45960
,   [ 57086] = 56949
,   [ 57087] = 56950
,   [ 33927] = 45963
,   [ 57099] = 56962
,   [ 57100] = 56963
,   [ 43094] = 45966
,   [ 57112] = 56975
,   [ 57113] = 56976
,   [ 43154] = 45969
,   [ 57124] = 56987
,   [ 57125] = 56988
,   [ 57138] = 57001
,   [ 57139] = 57002
,   [ 57140] = 57003
,   [ 68236] = 68192
,   [ 68237] = 68193
,   [ 68238] = 68194
,   [ 28321] = 45887
,   [ 28354] = 45912
,   [ 33813] = 45934
,   [ 28325] = 45890
,   [ 33358] = 45914
,   [ 33831] = 45937
,   [ 28330] = 45893
,   [ 28297] = 45917
,   [ 28370] = 45940
,   [ 42811] = 45896
,   [ 28309] = 45920
,   [ 28382] = 45943
,   [ 28338] = 45899
,   [ 33478] = 45923
,   [ 28394] = 45946
,   [ 42784] = 45902
,   [ 33496] = 45926
,   [ 33557] = 45949
,   [ 28346] = 45905
,   [ 33514] = 45929
,   [ 33575] = 45952
,   [ 42796] = 45908
,   [ 33795] = 45932
,   [ 33593] = 45955
,   [ 33897] = 45958
,   [ 57089] = 56952
,   [ 57090] = 56953
,   [ 33915] = 45961
,   [ 57102] = 56965
,   [ 57103] = 56966
,   [ 32160] = 45964
,   [ 57115] = 56978
,   [ 57116] = 56979
,   [ 43124] = 45967
,   [ 57127] = 56990
,   [ 57128] = 56991
,   [ 57141] = 57004
,   [ 57142] = 57005
,   [ 57143] = 57006
,   [ 68239] = 68195
,   [ 68240] = 68196
,   [ 68241] = 68197
,   [ 28348] = 45636
,   [ 28299] = 45654
,   [ 28373] = 45675
,   [ 28360] = 45639
,   [ 28311] = 45657
,   [ 28385] = 45678
,   [ 42808] = 45642
,   [ 33480] = 45660
,   [ 28397] = 45681
,   [ 42793] = 45646
,   [ 33505] = 45664
,   [ 33567] = 45685
,   [ 33846] = 45649
,   [ 33523] = 45667
,   [ 33585] = 45688
,   [ 33864] = 45652
,   [ 33804] = 45672
,   [ 33889] = 45693
,   [ 43158] = 45699
,   [ 57092] = 56955
,   [ 57093] = 56956
,   [ 33913] = 45705
,   [ 57105] = 56968
,   [ 57106] = 56969
,   [ 33931] = 45711
,   [ 57118] = 56981
,   [ 57119] = 56982
,   [ 43097] = 45717
,   [ 57130] = 56993
,   [ 57131] = 56994
,   [ 57144] = 57007
,   [ 57145] = 57008
,   [ 57146] = 57009
,   [ 68242] = 68198
,   [ 68243] = 68199
,   [ 68244] = 68200
,   [ 28353] = 45637
,   [ 28304] = 45655
,   [ 33403] = 45676
,   [ 33528] = 45640
,   [ 28316] = 45658
,   [ 33409] = 45679
,   [ 33537] = 45643
,   [ 33487] = 45661
,   [ 33416] = 45682
,   [ 42786] = 45645
,   [ 33498] = 45663
,   [ 33560] = 45684
,   [ 33839] = 45648
,   [ 33516] = 45666
,   [ 33578] = 45687
,   [ 33857] = 45651
,   [ 33797] = 45670
,   [ 33596] = 54243
,   [ 43092] = 45697
,   [ 57091] = 56954
,   [ 57094] = 56957
,   [ 33906] = 45703
,   [ 57104] = 56967
,   [ 57107] = 56970
,   [ 33924] = 45709
,   [ 57117] = 56980
,   [ 57120] = 56983
,   [ 33900] = 45715
,   [ 57129] = 56992
,   [ 57132] = 56995
,   [ 57147] = 57010
,   [ 57148] = 57011
,   [ 57149] = 57012
,   [ 68245] = 68201
,   [ 68246] = 68202
,   [ 68247] = 68203
,   [ 28357] = 45638
,   [ 28308] = 45656
,   [ 33405] = 45677
,   [ 33531] = 45641
,   [ 28320] = 45659
,   [ 33411] = 45680
,   [ 33540] = 45644
,   [ 33493] = 45662
,   [ 33555] = 45683
,   [ 42799] = 45647
,   [ 33511] = 45665
,   [ 33573] = 45686
,   [ 33852] = 45650
,   [ 42759] = 45668
,   [ 33591] = 45689
,   [ 33870] = 45653
,   [ 33810] = 45674
,   [ 33895] = 45695
,   [ 54377] = 45700
,   [ 57095] = 56958
,   [ 57096] = 56959
,   [ 33916] = 45706
,   [ 57108] = 56971
,   [ 57109] = 56972
,   [ 28332] = 45712
,   [ 57121] = 56984
,   [ 57122] = 56985
,   [ 43155] = 45718
,   [ 57133] = 56996
,   [ 57134] = 56997
,   [ 57150] = 57013
,   [ 57151] = 57014
,   [ 57152] = 57015
,   [ 68248] = 68204
,   [ 68249] = 68205
,   [ 68250] = 68206
,   [ 57080] = 56943
,   [ 57081] = 56944
,   [ 57082] = 56947
,   [ 57084] = 56945
,   [ 33802] = 45671
,   [ 33594] = 45690
,   [ 33856] = 54370
,   [ 55922] = 45701
,   [ 33886] = 45692
,   [ 33892] = 45694
,   [ 28331] = 45696
,   [ 57110] = 56973
,   [ 33808] = 45673
,   [ 33868] = 45791
,   [ 33919] = 45707
,   [ 33862] = 54369
,   [ 33796] = 54371
,   [ 43128] = 45698
,   [ 33928] = 45710
,   [ 33910] = 45704
,   [ 33904] = 45702
,   [ 33922] = 45708
,   [ 28333] = 45719
,   [ 43089] = 45713
,   [ 43143] = 45716
,   [ 33898] = 45714
,   [ 57153] = 57016
,   [ 68251] = 68207
,   [ 68252] = 68208
,   [ 68253] = 68209
,   [ 68254] = 68210
,   [ 28401] = 45970
,   [ 33600] = 45980
,   [ 33933] = 45988
,   [ 28405] = 45971
,   [ 33606] = 45981
,   [ 33939] = 45989
,   [ 28409] = 45972
,   [ 33612] = 45982
,   [ 33945] = 45990
,   [ 28413] = 45973
,   [ 33618] = 46035
,   [ 33951] = 45991
,   [ 28417] = 45974
,   [ 33624] = 45984
,   [ 33957] = 45992
,   [ 28421] = 45975
,   [ 33630] = 45985
,   [ 33963] = 45993
,   [ 28425] = 45976
,   [ 33636] = 45986
,   [ 33969] = 45994
,   [ 28429] = 45977
,   [ 33642] = 45987
,   [ 33975] = 45995
,   [ 28433] = 45978
,   [ 57158] = 57020
,   [ 57161] = 57023
,   [ 28437] = 45979
,   [ 57170] = 57032
,   [ 57173] = 57035
,   [ 28402] = 46048
,   [ 57182] = 57044
,   [ 57185] = 57047
,   [ 33652] = 46051
,   [ 34032] = 46054
,   [ 57194] = 57056
,   [ 57200] = 57062
,   [ 57201] = 57063
,   [ 57202] = 57064
,   [ 68255] = 68211
,   [ 68256] = 68212
,   [ 68257] = 68213
,   [ 28441] = 45996
,   [ 33648] = 46006
,   [ 33981] = 46014
,   [ 28445] = 45997
,   [ 33654] = 46007
,   [ 33987] = 46015
,   [ 28449] = 45998
,   [ 33660] = 46008
,   [ 33993] = 46016
,   [ 28453] = 45999
,   [ 33666] = 46009
,   [ 33999] = 46017
,   [ 28457] = 46000
,   [ 33672] = 46010
,   [ 34005] = 46018
,   [ 28461] = 46001
,   [ 33678] = 46011
,   [ 34011] = 46019
,   [ 28465] = 46002
,   [ 33684] = 46012
,   [ 34017] = 46020
,   [ 28469] = 46003
,   [ 33690] = 46013
,   [ 34023] = 46021
,   [ 28473] = 46004
,   [ 57159] = 57021
,   [ 57160] = 57022
,   [ 28477] = 46005
,   [ 57171] = 57033
,   [ 57172] = 57034
,   [ 33602] = 46049
,   [ 57183] = 57045
,   [ 57184] = 57046
,   [ 28482] = 46052
,   [ 46061] = 46055
,   [ 57195] = 57057
,   [ 57203] = 57065
,   [ 57204] = 57066
,   [ 57205] = 57067
,   [ 68258] = 68214
,   [ 68259] = 68215
,   [ 68260] = 68216
,   [ 28481] = 46022
,   [ 33696] = 46032
,   [ 34029] = 46040
,   [ 28485] = 46023
,   [ 33702] = 46033
,   [ 34035] = 46041
,   [ 28489] = 46024
,   [ 33708] = 46034
,   [ 34041] = 46042
,   [ 28493] = 46025
,   [ 33714] = 45983
,   [ 34047] = 46043
,   [ 28497] = 46026
,   [ 33720] = 46036
,   [ 34053] = 46044
,   [ 28501] = 46027
,   [ 33726] = 46037
,   [ 34059] = 46045
,   [ 28505] = 46028
,   [ 33732] = 46038
,   [ 34065] = 46046
,   [ 28509] = 46029
,   [ 33738] = 46039
,   [ 34071] = 46047
,   [ 28513] = 46030
,   [ 57162] = 57024
,   [ 57163] = 57025
,   [ 28517] = 46031
,   [ 57174] = 57036
,   [ 57175] = 57037
,   [ 28444] = 46050
,   [ 57186] = 57048
,   [ 57187] = 57049
,   [ 33698] = 46053
,   [ 46063] = 46056
,   [ 57196] = 57058
,   [ 57206] = 57068
,   [ 57207] = 57069
,   [ 57208] = 57070
,   [ 68261] = 68217
,   [ 68262] = 68218
,   [ 68263] = 68219
,   [ 28411] = 45539
,   [ 33614] = 45551
,   [ 33947] = 45559
,   [ 28415] = 45540
,   [ 33620] = 45552
,   [ 33953] = 45560
,   [ 28419] = 45541
,   [ 33626] = 45553
,   [ 33959] = 45561
,   [ 28423] = 45542
,   [ 33632] = 45554
,   [ 33965] = 45562
,   [ 28427] = 45543
,   [ 33638] = 45555
,   [ 33971] = 45563
,   [ 28431] = 45544
,   [ 33644] = 45556
,   [ 33977] = 45564
,   [ 28435] = 45546
,   [ 57164] = 57026
,   [ 57167] = 57029
,   [ 28439] = 45548
,   [ 57176] = 57038
,   [ 57179] = 57041
,   [ 33420] = 54241
,   [ 57188] = 57050
,   [ 57191] = 57053
,   [ 46062] = 45631
,   [ 33984] = 54242
,   [ 57197] = 57059
,   [ 57209] = 57071
,   [ 57210] = 57072
,   [ 57211] = 57073
,   [ 68264] = 68220
,   [ 68265] = 68221
,   [ 68266] = 68222
,   [ 28452] = 45567
,   [ 33663] = 45579
,   [ 33996] = 45587
,   [ 28456] = 45568
,   [ 33669] = 45580
,   [ 34002] = 45588
,   [ 28460] = 45569
,   [ 33675] = 45581
,   [ 34008] = 45589
,   [ 28464] = 45570
,   [ 33681] = 45582
,   [ 34014] = 45590
,   [ 28468] = 45571
,   [ 33687] = 45583
,   [ 34020] = 45591
,   [ 28472] = 45572
,   [ 33693] = 45584
,   [ 34026] = 45592
,   [ 28476] = 45574
,   [ 57165] = 57027
,   [ 57166] = 57028
,   [ 28487] = 45604
,   [ 57177] = 57039
,   [ 57178] = 57040
,   [ 28443] = 45622
,   [ 57189] = 57051
,   [ 57190] = 57052
,   [ 33697] = 45627
,   [ 46058] = 45633
,   [ 57198] = 57060
,   [ 57212] = 57074
,   [ 57213] = 57075
,   [ 57214] = 57076
,   [ 68267] = 68223
,   [ 68268] = 68224
,   [ 68269] = 68225
,   [ 28492] = 45594
,   [ 33711] = 45607
,   [ 34044] = 45614
,   [ 28496] = 45595
,   [ 33717] = 45608
,   [ 34050] = 45615
,   [ 28500] = 45596
,   [ 33723] = 45609
,   [ 34056] = 45616
,   [ 28504] = 45597
,   [ 33729] = 45610
,   [ 34062] = 45617
,   [ 28508] = 45598
,   [ 33735] = 45611
,   [ 34068] = 45618
,   [ 28512] = 45600
,   [ 33741] = 45612
,   [ 34074] = 45619
,   [ 28516] = 45602
,   [ 57168] = 57030
,   [ 57169] = 57031
,   [ 33458] = 45576
,   [ 57180] = 57042
,   [ 57181] = 57043
,   [ 33650] = 45624
,   [ 57192] = 57054
,   [ 57193] = 57055
,   [ 34030] = 45629
,   [ 46060] = 45535
,   [ 57199] = 57061
,   [ 57215] = 57077
,   [ 57216] = 57078
,   [ 57217] = 57079
,   [ 68270] = 68226
,   [ 68271] = 68227
,   [ 68272] = 68228
,   [ 57155] = 57017
,   [ 57156] = 57018
,   [ 57157] = 57019
,   [ 34027] = 46079
,   [ 33434] = 45545
,   [ 33694] = 45691
,   [ 33979] = 45565
,   [ 33739] = 46081
,   [ 33436] = 45547
,   [ 33456] = 45575
,   [ 28514] = 45601
,   [ 34072] = 46082
,   [ 33459] = 45577
,   [ 28518] = 45603
,   [ 33438] = 45549
,   [ 33603] = 45621
,   [ 28403] = 45620
,   [ 33440] = 45623
,   [ 33454] = 45573
,   [ 46057] = 45632
,   [ 33982] = 45625
,   [ 28483] = 45628
,   [ 33699] = 45626
,   [ 28510] = 45599
,   [ 33646] = 45557
,   [ 34033] = 45630
,   [ 46059] = 45634
,   [ 68273] = 68229
,   [ 68274] = 68230
,   [ 68275] = 68231
,   [ 68276] = 68232
,   [ 64221] = 64223
,   [ 71056] = 71060
,   [ 87687] = 87684
,   [ 87690] = 87688
,   [ 87695] = 87692
,   [ 87699] = 87698
,   [ 87697] = 87694
,   [112426] = 96966
,   [112433] = 96965
,   [112440] = 96960
,   [101879] = 96968
,   [ 71057] = 71061
,   [ 71058] = 71062
,   [ 71059] = 71063
,   [ 87685] = 87682
,   [ 87686] = 87683
,   [ 87691] = 87689
,   [ 87696] = 87693
,   [112425] = 96967
,   [112434] = 96964
,   [112435] = 96963
,   [112438] = 96962
,   [112439] = 96961
}

    -- Recipe --------------------------------------------------------------------

Provisioning.Recipe  = {}
local Recipe = Provisioning.Recipe
function Recipe:New(args)
    local o = {
        class             = "provisioning"
    ,   fooddrink_item_id = args.fooddrink_item_id  -- int(33526)
    ,   recipe_item_id    = args.recipe_item_id     -- int(45888)
    ,   recipe_link       = args.recipe_link        -- "|H1:item:45888:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
    ,   is_known          = args.is_known           -- true
    ,   mat_list          = {}                      -- list of MatRow ingredients
    ,   fooddrink_link    = nil
    ,   fooddrink_name    = nil
    }

    setmetatable(o, self)
    self.__index = self
    return o
end

function Recipe:FromFoodDrinkItemID(fooddrink_item_id)
    local MatRow = WritWorthy.MatRow

    local o = Recipe:New({ fooddrink_item_id= fooddrink_item_id })
    Log:Add("fooddrink_item_id:"..tostring(fooddrink_item_id))
    o.recipe_item_id = Provisioning.FOODDRINK_TO_RECIPE_ITEM_ID[fooddrink_item_id]
    Log:Add("recipe_item_id:"..tostring(o.recipe_item_id))
    if not o.recipe_item_id then return nil end
    o.recipe_link = string.format(
              "|H1:item:%d:1:36:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
            , o.recipe_item_id
            )
    o.fooddrink_link = GetItemLinkRecipeResultItemLink(
                                      o.recipe_link
                                    , LINK_STYLE_DEFAULT)
    o.fooddrink_name    = GetItemLinkName(o.fooddrink_link)
    o.is_known = IsItemLinkRecipeKnown(o.recipe_link)

    Log:Add("recipe_link:"..tostring(o.recipe_link))
    Log:Add("fooddrink_link:"..tostring(o.fooddrink_link))
    Log:Add("fooddrink_name:"..tostring(o.fooddrink_name))
    Log:Add("is_known:"..tostring(o.is_known))
    local mat_ct = GetItemLinkRecipeNumIngredients(o.recipe_link)
    local cook_ct = 2 -- Usually need to craft 2x batches for master writs
    for ingr_index = 1,mat_ct do
        local _, _, ingr_ct = GetItemLinkRecipeIngredientInfo(
                              o.recipe_link
                            , ingr_index)
        local ingr_link = GetItemLinkRecipeIngredientItemLink(
                              o.recipe_link
                            , ingr_index
                            , LINK_STYLE_DEFAULT)
        if 0 < ingr_ct and ingr_link and ingr_link ~= "" then
            local mr = MatRow:FromLink(ingr_link, ingr_ct * cook_ct)
            table.insert(o.mat_list, mr)
        end
    end
    return o
end


-- Provisioning --------------------------------------------------------------

-- Find a recipe by fooddrink_item_id
--
-- First time this runs, we decompress a list of all 554 recipe names.
-- Takes 1+ second!
--
-- Second-and-later times this runs, it's O(1) instantaneous.
--
-- returns a Recipe{} instance.
--
function Provisioning.FindRecipe(fooddrink_item_id)
    local recipe = Recipe:FromFoodDrinkItemID(fooddrink_item_id)
    if not recipe then
        return Fail("WritWorthy: recipe not found:"..tostring(fooddrink_item_id))
    end
    return recipe
end

Provisioning.Parser = {
    class = "provisioning"
}
local Parser = Provisioning.Parser

function Parser:New()
    local o = {
        recipe          = nil -- Recipe{}
    }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Parser:ParseItemLink(item_link)
    local fields = Util.ToWritFields(item_link)
    self.recipe = Provisioning.FindRecipe(fields.writ1)
    if not self.recipe then return nil end
    return self
end

function Parser:ToMatList()
    return self.recipe.mat_list
end

function Parser:ToKnowList()
    local Know = WritWorthy.Know
    local k = Know:New({ name = "recipe"
                       , is_known = self.recipe.is_known
                       , lack_msg = "Recipe not known"
                       })
    local chef   = WritWorthy.RequiredSkill.PR_FOOD_4X:ToKnow()
    local brewer = WritWorthy.RequiredSkill.PR_DRINK_4X:ToKnow()
    chef.is_warn = true
    brewer.is_warn = true
    return { k, chef, brewer }
end

function Parser:ToDolRequest(unique_id)
    local mat_list = self:ToMatList()
    local o = {}
    o[1] = self.recipe.recipe_item_id -- recipeId
    o[2] = 2                          -- timesToMake
    o[3] = true                       -- autocraft
    o[4] = unique_id                  -- reference
    return { ["function"       ] = "CraftProvisioningItemByRecipeId"
           , ["args"           ] = o
           }
end
