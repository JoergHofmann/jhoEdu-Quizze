function MakeInventar(Yaml) -- {**

    InputData = LoadYaml(Yaml)
    local out = ""
    local vorlage = ""

    SummeAV = 0
    SummeUV = 0
    SummeSchulden = 0
    ZahlElemente = 9

    YamlOutputStr = "---\n" .. "AgId: " .. InputData.id .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangSummeAV: " .. InputData.inventar.RangSummeAV .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangHeaderUV: " .. InputData.inventar.RangHeaderUV .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangSummeUV: " .. InputData.inventar.RangSummeUV .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangSummeVermoegen: " .. InputData.inventar.RangSummeVermoegen .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangHeaderSchulden: " .. InputData.inventar.RangHeaderSchulden .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangSummeSchulden: " .. InputData.inventar.RangSummeSchulden .. "\n"
    YamlOutputStr = YamlOutputStr .. "RangReinvermoegen: " .. InputData.inventar.RangReinvermoegen .. "\ninventar:\n"
    
    local z = #InputData.inventar.Vermoegen.Anlagevermoegen
    for i = 1, z, 1 do
        InputData.inventar.Vermoegen.Anlagevermoegen[i].Gesamt = InputData.inventar.Vermoegen.Anlagevermoegen[i].dataMenge * InputData.inventar.Vermoegen.Anlagevermoegen[i].dataWert
        SummeAV = SummeAV + InputData.inventar.Vermoegen.Anlagevermoegen[i].Gesamt
        YamlOutputStr = YamlOutputStr .. '    -\n'
        YamlOutputStr = YamlOutputStr .. '      Bezeichnung: "' .. InputData.inventar.Vermoegen.Anlagevermoegen[i].Bezeichnung .. '"\n'
        YamlOutputStr = YamlOutputStr .. '      Index: ' .. ZahlElemente + i - 1 .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Rang: ' .. InputData.inventar.Vermoegen.Anlagevermoegen[i].Rang .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataMenge: ' .. InputData.inventar.Vermoegen.Anlagevermoegen[i].dataMenge .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Menge: ' .. tausender(InputData.inventar.Vermoegen.Anlagevermoegen[i].dataMenge,1) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataWert: ' .. InputData.inventar.Vermoegen.Anlagevermoegen[i].dataWert .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Wert: ' .. tausender(InputData.inventar.Vermoegen.Anlagevermoegen[i].dataWert,2) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Gesamt: ' .. tausender(InputData.inventar.Vermoegen.Anlagevermoegen[i].Gesamt,2) .. '\n'
    end
    ZahlElemente = ZahlElemente + z
    local z = #InputData.inventar.Vermoegen.Umlaufvermoegen
    for i = 1, z, 1 do
        InputData.inventar.Vermoegen.Umlaufvermoegen[i].Gesamt = InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataMenge * InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataWert
        SummeUV = SummeUV + InputData.inventar.Vermoegen.Umlaufvermoegen[i].Gesamt
        YamlOutputStr = YamlOutputStr .. '    -\n'
        YamlOutputStr = YamlOutputStr .. '      Bezeichnung: "' .. InputData.inventar.Vermoegen.Umlaufvermoegen[i].Bezeichnung .. '"\n'
        YamlOutputStr = YamlOutputStr .. '      Index: ' .. ZahlElemente + i - 1 .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Rang: ' .. InputData.inventar.Vermoegen.Umlaufvermoegen[i].Rang .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataMenge: ' .. InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataMenge .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Menge: ' .. tausender(InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataMenge, 1) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataWert: ' .. InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataWert .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Wert: ' .. tausender(InputData.inventar.Vermoegen.Umlaufvermoegen[i].dataWert,2) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Gesamt: ' .. tausender(InputData.inventar.Vermoegen.Umlaufvermoegen[i].Gesamt,2) .. '\n'
    end
    ZahlElemente = ZahlElemente + z
    local z = #InputData.inventar.Schulden
    for i = 1, z, 1 do
        SummeSchulden = SummeSchulden + InputData.inventar.Schulden[i].dataWert
        YamlOutputStr = YamlOutputStr .. '    -\n'      
        YamlOutputStr = YamlOutputStr .. '      Bezeichnung: "' .. InputData.inventar.Schulden[i].Bezeichnung .. '"\n'
        YamlOutputStr = YamlOutputStr .. '      Index: ' .. ZahlElemente + i - 1 .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Rang: ' .. InputData.inventar.Schulden[i].Rang .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataMenge: ' .. InputData.inventar.Schulden[i].dataMenge .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Menge: ' .. tausender(InputData.inventar.Schulden[i].dataMenge, 1) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      dataWert: ' .. InputData.inventar.Schulden[i].dataWert .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Wert: ' .. tausender(InputData.inventar.Schulden[i].dataWert,2) .. '\n'
        YamlOutputStr = YamlOutputStr .. '      Gesamt: ' .. tausender(InputData.inventar.Schulden[i].dataWert,2) .. '\n'
    end
    ZahlElemente = ZahlElemente + z
    OutputData = lyaml.load(YamlOutputStr)
    mischen(OutputData.inventar,1)
    OutputData.SummeAV = SummeAV
    OutputData.SummeUV = SummeUV
    OutputData.SummeSchulden = SummeSchulden
    OutputData.SummeVermoegen = SummeAV + SummeUV
    OutputData.Reinvermoegen = SummeAV + SummeUV - SummeSchulden

    for line in io.lines("inventar.html") do 
		vorlage = vorlage .. line .. "\n"
    end

    out = lustache:render(vorlage, OutputData)   

    return out 
end
-- **}


