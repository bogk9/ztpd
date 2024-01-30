
(:for $k in doc('file:///Users/justyna/pp_ztpd/XPath-XSLT//zesp_prac.xml')/ZESPOLY/ROW/PRACOWNICY/ROW:)
(:return $k/NAZWISKO:)

(:for $k in doc('file:///Users/justyna/pp_ztpd/XPath-XSLT//zesp_prac.xml')/ZESPOLY/ROW[NAZWA = 'SYSTEMY EKSPERCKIE']/PRACOWNICY/ROW:)
(:return $k/NAZWISKO:)

(:for $k in count(doc('file:///Users/justyna/pp_ztpd/XPath-XSLT//zesp_prac.xml')/ZESPOLY/ROW[ID_ZESP = 10]/PRACOWNICY/ROW):)
(:return $k:)

(:for $k in doc('file:///Users/justyna/pp_ztpd/XPath-XSLT//zesp_prac.xml')/ZESPOLY/ROW/PRACOWNICY/ROW[ID_SZEFA = 100]:)
(:return $k/NAZWISKO:)

let $path := doc('file:///Users/justyna/pp_ztpd/XPath-XSLT//zesp_prac.xml')/ZESPOLY/ROW/PRACOWNICY/ROW[ID_ZESP = /ZESPOLY/ROW/PRACOWNICY/ROW[NAZWISKO = 'BRZEZINSKI']/ID_ZESP]
return sum($path/PLACA_POD)