# -*- coding: utf-8 -*-
import json, os, collections
L10N = os.path.join(os.path.dirname(__file__), "lib", "l10n")
LANG = {
 "ro":("Limbă","Implicit (sistem)"),
 "en":("Language","System default"),
 "es":("Idioma","Predeterminado del sistema"),
 "fr":("Langue","Par défaut du système"),
 "it":("Lingua","Predefinito di sistema"),
 "ja":("言語","システムの既定"),
 "ko":("언어","시스템 기본값"),
 "pt":("Idioma","Predefinição do sistema"),
 "ru":("Язык","Системный по умолчанию"),
 "zh":("语言","系统默认"),
 "de":("Sprache","Systemstandard"),
}
for loc,(lang,sysd) in LANG.items():
    p=os.path.join(L10N,"app_%s.arb"%loc)
    with open(p,encoding="utf-8") as f: d=json.load(f,object_pairs_hook=collections.OrderedDict)
    d["language"]=lang; d["languageSystem"]=sysd
    if loc=="ro":
        d["@language"]={"description":"Language picker title"}
        d["@languageSystem"]={"description":"Follow device language option"}
    with open(p,"w",encoding="utf-8") as f:
        json.dump(d,f,ensure_ascii=False,indent=2); f.write("\n")
    print("ok",loc)
