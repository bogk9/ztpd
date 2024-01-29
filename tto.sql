CREATE type samochod AS object ( marka varchar2(20), model varchar2(20), kilometry number, data_produkcji date, cena number(10,2) );DESC samochod;CREATE TABLE samochodytab OF samochod;INSERT INTO samochodytab VALUES
            (
                        new samochod('fiat','brava',60000,date '1999-11-30',25000)
            );INSERT INTO samochodytab VALUES
            (
                        new samochod('ford','mondeo',80000,date '1997-05-10', 40000)
            );INSERT INTO samochodytab VALUES
            (
                        new samochod('mazda','323',12000,date '2000-09-23', 52000)
            );SELECT *
FROM   samochodytab;CREATE TABLE wlasciciele
             (
                          imie     VARCHAR2(100),
                          nazwisko VARCHAR2(100),
                          auto SAMOCHOD
             );INSERT INTO wlasciciele VALUES
            (
                        'Jan',
                        'Kowalski',
                        new samochod('fiat','seicento',30000,date '0010-12-02',19500)
            );INSERT INTO wlasciciele VALUES
            (
                        'Adam',
                        'Nowak',
                        new samochod('opel','astra',34000,date '0009-06-01', 33700)
            );SELECT *
FROM   wlasciciele;ALTER type samochod replace AS object ( marka varchar2(20), model varchar2(20), kilometry number, data_produkcji date, cena number(10,2), member FUNCTION wartoscRETURN                                        number );CREATE
OR
replace type body samochod AS member FUNCTION wartoscRETURN number IS
beginRETURN Round(cena * Power(0.9, Extract(year FROM CURRENT_DATE) - Extract(year FROM data_produ)), 2);END
wartosc;END;SELECT s.marka,
       s.model,
       s.cena,
       s.data_produ,
       s.Wartosc()
FROM   samochodytab s;ALTER type samochod ADD map member FUNCTION odwzorujRETURN number cascade including TABLE data;CREATE
OR
replace type body samochod AS member FUNCTION wartoscRETURN number IS
beginRETURN Round(cena * Power(0.9, Extract(year FROM CURRENT_DATE) - Extract(year FROM data_produ)), 2);END
wartosc;map member FUNCTION odwzorujRETURN number IS
beginRETURN Round(Extract(year FROM CURRENT_DATE) - Extract(year FROM data_produ) + (kilometry / 10000), 2);END
odwzoruj;END;SELECT   *
FROM     samochodytab s
ORDER BY value(s);CREATE type wlasciciel AS object ( imie varchar2(100), nazwisko varchar2(100) );CREATE TABLE wlasciciele OF wlasciciel;INSERT INTO wlasciciele VALUES
            (
                        new wlasciciel('Jan', 'Nowak')
            );CREATE type samochod2 AS object ( marka varchar2(20), model varchar2(20), kilometry number, data_produ date, cena number(10, 2), wlasciciel ref wlasciciel );CREATE TABLE samochody OF samochod2;INSERT INTO samochody VALUES
            (
                        new samochod2('ford', 'mondeo', 10000, date '1997-05-10', 45000, NULL)
            );INSERT INTO samochody VALUES
            (
                        new samochod2('mazda', '323', 10000, date '2000-09-22', 52000, NULL)
            );INSERT INTO samochody VALUES
            (
                        new samochod2('fiat', 'brava', 10000, date '1999-11-30', 25000, NULL)
            );UPDATE samochody s
SET    s.wlasciciel =
       (
              SELECT Ref(w)
              FROM   wlasciciele w
              WHERE  w.imie = 'Jan' );SELECT *
FROM   samochody;

---DECLARE type T_PRZEDMIOTY is varray(10) OF varchar2(20);moje_przedmioty t_przedmioty := t_przedmioty('');BEGIN
  moje_przedmioty(1) := 'MATEMATYKA';
  moje_przedmioty.extend(9);
  for i IN 2..10
  loop moje_przedmioty(i) := 'PRZEDMIOT_' || i;
endLOOP;FOR i IN moje_przedmioty.first()..moje_przedmioty.last()
loop dbms_output.put_line(moje_przedmioty(i));END
loop;moje_przedmioty.trim(2);FOR i IN moje_przedmioty.first()..moje_przedmioty.last()
loop dbms_output.put_line(moje_przedmioty(i));END
loop;DBMS_OUTPUT.put_line('Limit: ' || moje_przedmioty.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moje_przedmioty.count());moje_przedmioty.extend();moje_przedmioty(9) := 9;DBMS_OUTPUT.put_line('Limit: ' || moje_przedmioty.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moje_przedmioty.count());moje_przedmioty.DELETE();DBMS_OUTPUT.put_line('Limit: ' || moje_przedmioty.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moje_przedmioty.count());END;DECLARE type T_KSIAZKI is varray(10) OF varchar2(20);moje_ksiazki t_ksiazki := t_ksiazki('');BEGIN
  moje_ksiazki(1) := 'Chlopi';
  moje_ksiazki.extend(9);
  for i IN 2..10
  loop moje_ksiazki(i) := 'ksiazka_' || i;
endLOOP;FOR i IN moje_ksiazki.first()..moje_ksiazki.last()
loop dbms_output.put_line(moje_ksiazki(i));END
loop;moje_ksiazki.trim(2);FOR i IN moje_ksiazki.first()..moje_ksiazki.last()
loop dbms_output.put_line(moje_ksiazki(i));END
loop;DBMS_OUTPUT.put_line('Limit: ' || moje_ksiazki.limit());DBMS_OUTPUT.put_line('Liczba tytulow ksiazek: ' || moje_ksiazki.count());moje_ksiazki.extend();moje_ksiazki(9) := 9;DBMS_OUTPUT.put_line('Limit: ' || moje_ksiazki.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moje_ksiazki.count());moje_ksiazki.DELETE();DBMS_OUTPUT.put_line('Limit: ' || moje_ksiazki.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moje_ksiazki.count());END;DECLARE type T_WYKLADOWCY is TABLE OF varchar2(20);moi_wykladowcy t_wykladowcy := t_wykladowcy();BEGIN
  moi_wykladowcy.extend(2);
  moi_wykladowcy(1) := 'MORZY';
  moi_wykladowcy(2) := 'WOJCIECHOWSKI';
  moi_wykladowcy.extend(8);
  for i IN 3..10
  loop moi_wykladowcy(i) := 'WYKLADOWCA_' || i;
endLOOP;FOR i IN moi_wykladowcy.first()..moi_wykladowcy.last()
loop dbms_output.put_line(moi_wykladowcy(i));END
loop;moi_wykladowcy.trim(2);FOR i IN moi_wykladowcy.first()..moi_wykladowcy.last()
loop dbms_output.put_line(moi_wykladowcy(i));END
loop;moi_wykladowcy.DELETE(5,7);DBMS_OUTPUT.put_line('Limit: ' || moi_wykladowcy.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moi_wykladowcy.count());FOR i IN moi_wykladowcy.first()..moi_wykladowcy.last()
loopIF moi_wykladowcy.Exists(i) then
dbms_output.put_line(moi_wykladowcy(i));ENDIF;END
loop;moi_wykladowcy(5) := 'ZAKRZEWICZ';moi_wykladowcy(6) := 'KROLIKOWSKI';moi_wykladowcy(7) := 'KOSZLAJDA';FOR i IN moi_wykladowcy.first()..moi_wykladowcy.last()
loopIF moi_wykladowcy.Exists(i) then
dbms_output.put_line(moi_wykladowcy(i));ENDIF;END
loop;DBMS_OUTPUT.put_line('Limit: ' || moi_wykladowcy.limit());DBMS_OUTPUT.put_line('Liczba elementow: ' || moi_wykladowcy.count());END;DECLARE type T_MIESIACE is TABLE OF varchar2(20);moje_miesiace t_miesiace := t_miesiace();BEGIN
  moje_miesiace.extend(12);
  moje_miesiace(1) := 'styczen';
  moje_miesiace(2) := 'luty';
  moje_miesiace(3) := 'marzec';
  moje_miesiace(4) := 'kwiecien';
  moje_miesiace(5) := 'maj';
  moje_miesiace(6) := 'czerwiec';
  for i IN 7..12
  loop moje_miesiace(i) := 'Miesiac_' || i;
endLOOP;FOR i IN moje_miesiace.first()..moje_miesiace.last()
loopIF moje_miesiace.Exists(i) then
dbms_output.put_line(moje_miesiace(i));ENDIF;END
loop;moje_miesiace.DELETE(7, 12);moje_miesiace(7) := 'lipiec';FOR i IN moje_miesiace.first()..moje_miesiace.last()
loopIF moje_miesiace.Exists(i) then
dbms_output.put_line(moje_miesiace(i));ENDIF;END
loop;END;CREATE type jezyki_obce AS varray(10) OF varchar2(20);/CREATE type stypendium AS object ( nazwa varchar2(50), kraj varchar2(30), jezyki jezyki_obce );/CREATE TABLE stypendia OF stypendium;INSERT INTO stypendia VALUES
            (
                        'SOKRATES',
                        'FRANCJA',
                        Jezyki_obce('ANGIELSKI','FRANCUSKI','NIEMIECKI')
            );INSERT INTO stypendia VALUES
            (
                        'ERASMUS',
                        'NIEMCY',
                        Jezyki_obce('ANGIELSKI','NIEMIECKI','HISZPANSKI')
            );SELECT *
FROM   stypendia;SELECT s.jezyki
FROM   stypendia s;UPDATE stypendia
SET    jezyki = Jezyki_obce('ANGIELSKI','NIEMIECKI','HISZPANSKI','FRANCUSKI')
WHERE  nazwa = 'ERASMUS';CREATE type lista_egzaminow AS TABLE of varchar2(20);/CREATE type semestr AS object ( numer number, egzaminy lista_egzaminow );/CREATE TABLE semestry OF semestr nested TABLE egzaminy store AS tab_egzaminy;INSERT INTO semestry VALUES
            (
                        Semestr(1,Lista_egzaminow('MATEMATYKA','LOGIKA','ALGEBRA'))
            );INSERT INTO semestry VALUES
            (
                        Semestr(2,Lista_egzaminow('BAZY DANYCH','SYSTEMY OPERACYJNE'))
            );SELECT s.numer,
       e.*
FROM   semestry s,
       Table(s.egzaminy) e;SELECT e.*
FROM   semestry s,
       Table ( s.egzaminy ) e;SELECT *
FROM   table
       (
              select s.egzaminy
              FROM   semestry s
              WHERE  numer=1 );INSERT INTO table
            (
                   select s.egzaminy
                   FROM   semestry s
                   WHERE  numer=2
            )
            VALUES
            (
                        'METODY NUMERYCZNE'
            );UPDATE table
       (
              select s.egzaminy
              FROM   semestry s
              WHERE  numer=2 ) e
SET    e.column_value = 'SYSTEMY ROZPROSZONE'
WHERE  e.column_value = 'SYSTEMY OPERACYJNE';DELETE
FROM   table
       (
              select s.egzaminy
              FROM   semestry s
              WHERE  numer=2 ) e
WHERE  e.column_value = 'BAZY DANYCH';CREATE type koszyk_produktow AS TABLE of varchar2(30);CREATE type zakup AS object ( osoba varchar2(60), produkty koszyk_produktow );/CREATE TABLE zakupy OF zakup nested TABLE produkty store AS tab_produkty;INSERT INTO zakupy VALUES
            (
                        Zakup('Jan Nowak', Koszyk_produktow('jajka', 'chleb', 'maslo'))
            );INSERT INTO zakupy VALUES
            (
                        Zakup('Justyna F', Koszyk_produktow('awokado', 'banan', 'jogurt'))
            );INSERT INTO zakupy VALUES
            (
                        Zakup('Bogumil K', Koszyk_produktow('mleko', 'szampon'))
            );SELECT *
FROM   zakupy;DELETE
FROM   zakupy
WHERE  osoba IN
       (
              SELECT osoba
              FROM   zakupy z,
                     Table(z.produkty) p
              WHERE  p.column_value = 'szampon' );

---CREATE type instrument AS object ( nazwa varchar2(20), dzwiek varchar2(20), member FUNCTION grajRETURN                                   varchar2 ) NOT final;CREATE type body instrument AS member FUNCTION grajRETURN varchar2 IS
beginRETURN dzwiek;END;END;/CREATE type instrument_dety under instrument ( material varchar2(20), overriding member FUNCTION grajRETURN                                                    varchar2, member FUNCTION graj(glosnosc varchar2)RETURN                                                    varchar2 );CREATE
OR
replace type body instrument_dety AS overriding member FUNCTION grajRETURN varchar2 IS
beginRETURN 'dmucham: '||dzwiek;END;MEMBER FUNCTION graj(glosnosc varchar2)RETURN varchar2 IS
beginRETURN glosnosc||':'||dzwiek;END;END;/CREATE type instrument_klawiszowy under instrument ( producent varchar2(20), overriding member FUNCTION grajRETURN                                                           varchar2 );CREATE
OR
replace type body instrument_klawiszowy AS overriding member FUNCTION grajRETURN varchar2 IS
beginRETURN 'stukam w klawisze: '||dzwiek;END;END;/DECLARE tamburyn instrument := instrument('tamburyn','brzdek-brzdek');trabka instrument_dety := instrument_dety('trabka','tra-ta-ta','metalowa');fortepian instrument_klawiszowy := instrument_klawiszowy('fortepian','ping-ping','steinway');BEGIN
  dbms_output.put_line(tamburyn.graj);
  dbms_output.put_line(trabka.graj);
  dbms_output.put_line(trabka.graj('glosno'));
  dbms_output.put_line(fortepian.graj);
end;CREATE type istota AS object ( nazwa      varchar2(20), NOT instantiable member FUNCTION poluj(ofiara char)RETURN                                    char ) NOT instantiable NOT final;CREATE type lew under istota ( liczba_nog number, overriding member FUNCTION poluj(ofiara char)RETURN                                    char );CREATE
OR
replace type body lew AS overriding member FUNCTION poluj(ofiara char)RETURN char IS
beginRETURN 'upolowana ofiara: '||ofiara;END;END;DECLARE krollew lew := lew('LEW',4);InnaIstota istota := istota('JAKIES ZWIERZE');BEGIN
  dbms_output.put_line( krollew.poluj('antylopa') );
end;DECLARE tamburyn INSTRUMENT;cymbalki instrument;trabka instrument_dety;saksofon instrument_dety;BEGIN
  tamburyn := instrument('tamburyn','brzdek-brzdek');
  cymbalki := instrument_dety('cymbalki','ding-ding','metalowe');
  trabka := instrument_dety('trabka','tra-ta-ta','metalowa');
  --    saksofon := instrument('saksofon','tra-taaaa');
  --    saksofon := TREAT( instrument('saksofon','tra-taaaa') AS instrument_dety);
end;CREATE TABLE instrumenty OF instrument;INSERT INTO instrumenty VALUES
            (
                        Instrument('tamburyn','brzdek-brzdek')
            );INSERT INTO instrumenty VALUES
            (
                        Instrument_dety('trabka','tra-ta-ta','metalowa')
            );INSERT INTO instrumenty VALUES
            (
                        Instrument_klawiszowy('fortepian','ping-ping','steinway')
            );SELECT i.nazwa,
       i.Graj()
FROM   instrumenty i;CREATE TABLE przedmioty
             (
                          nazwa      VARCHAR2(50),
                          nauczyciel NUMBER REFERENCES pracownicy(id_prac)
             );INSERT INTO przedmioty VALUES
            (
                        'BAZY DANYCH',
                        100
            );INSERT INTO przedmioty VALUES
            (
                        'SYSTEMY OPERACYJNE',
                        100
            );INSERT INTO przedmioty VALUES
            (
                        'PROGRAMOWANIE',
                        110
            );INSERT INTO przedmioty VALUES
            (
                        'SIECI KOMPUTEROWE',
                        110
            );INSERT INTO przedmioty VALUES
            (
                        'BADANIA OPERACYJNE',
                        120
            );INSERT INTO przedmioty VALUES
            (
                        'GRAFIKA KOMPUTEROWA',
                        120
            );INSERT INTO przedmioty VALUES
            (
                        'BAZY DANYCH',
                        130
            );INSERT INTO przedmioty VALUES
            (
                        'SYSTEMY OPERACYJNE',
                        140
            );INSERT INTO przedmioty VALUES
            (
                        'PROGRAMOWANIE',
                        140
            );INSERT INTO przedmioty VALUES
            (
                        'SIECI KOMPUTEROWE',
                        140
            );INSERT INTO przedmioty VALUES
            (
                        'BADANIA OPERACYJNE',
                        150
            );INSERT INTO przedmioty VALUES
            (
                        'GRAFIKA KOMPUTEROWA',
                        150
            );INSERT INTO przedmioty VALUES
            (
                        'BAZY DANYCH',
                        160
            );INSERT INTO przedmioty VALUES
            (
                        'SYSTEMY OPERACYJNE',
                        160
            );INSERT INTO przedmioty VALUES
            (
                        'PROGRAMOWANIE',
                        170
            );INSERT INTO przedmioty VALUES
            (
                        'SIECI KOMPUTEROWE',
                        180
            );INSERT INTO przedmioty VALUES
            (
                        'BADANIA OPERACYJNE',
                        180
            );INSERT INTO przedmioty VALUES
            (
                        'GRAFIKA KOMPUTEROWA',
                        190
            );INSERT INTO przedmioty VALUES
            (
                        'GRAFIKA KOMPUTEROWA',
                        200
            );INSERT INTO przedmioty VALUES
            (
                        'GRAFIKA KOMPUTEROWA',
                        210
            );INSERT INTO przedmioty VALUES
            (
                        'PROGRAMOWANIE',
                        220
            );INSERT INTO przedmioty VALUES
            (
                        'SIECI KOMPUTEROWE',
                        220
            );INSERT INTO przedmioty VALUES
            (
                        'BADANIA OPERACYJNE',
                        230
            );CREATE type zespol AS object ( id_zesp number, nazwa varchar2(50), adres varchar2(100) );/
CREATE OR replace VIEW zespoly_v OF zespol WITH object identifier
                       (
                                              id_zesp
                       )
                       ASSELECT id_zesp,
       nazwa,
       adres
FROM   zespoly;CREATE type przedmioty_tab AS TABLE of varchar2(100);/CREATE type pracownik AS object ( id_prac number, nazwisko varchar2(30), etat varchar2(20), zatrudniony date, placa_pod number(10,2), miejsce_pracy ref zespol, przedmioty przedmioty_tab, member FUNCTION ile_przedmiotowRETURN                                      number );/ CREATE
OR
replace type body pracownik AS member FUNCTION ile_przedmiotowRETURN number IS
beginRETURN przedmioty.Count();END
ile_przedmiotow;END;CREATE OR replace VIEW pracownicy_v OF pracownik WITH object identifier
                       (
                                              id_prac
                       )
                       ASSELECT id_prac,
       nazwisko,
       etat,
       zatrudniony,
       placa_pod,
       Make_ref(zespoly_v,id_zesp),
       cast(multiset
       (
              select nazwa
              FROM   przedmioty
              WHERE  nauczyciel=p.id_prac ) AS przedmioty_tab )
FROM   pracownicy p;SELECT *
FROM   pracownicy_v;SELECT P.nazwisko,
       P.etat,
       P.miejsce_pracy.nazwa
FROM   pracownicy_v P;SELECT P.nazwisko,
       p.Ile_przedmiotow()
FROM   pracownicy_v P;SELECT *
FROM   table
       (
              select przedmioty
              FROM   pracownicy_v
              WHERE  nazwisko='WEGLARZ' );SELECT nazwisko,
       CURSOR
              (
              SELECT przedmioty
              FROM   pracownicy_v
              WHERE  id_prac=P.id_prac)
FROM   pracownicy_v P;CREATE TABLE pisarze
             (
                          id_pisarza NUMBER PRIMARY KEY,
                          nazwisko   VARCHAR2(20),
                          data_ur    DATE
             );CREATE TABLE ksiazki
             (
                          id_ksiazki   NUMBER PRIMARY KEY,
                          id_pisarza   NUMBER NOT NULL REFERENCES pisarze,
                          tytul        VARCHAR2(50),
                          data_wydanie DATE
             );INSERT INTO pisarze VALUES
            (
                        10,
                        'SIENKIEWICZ',
                        date '1880-01-01'
            );INSERT INTO pisarze VALUES
            (
                        20,
                        'PRUS',
                        date '1890-04-12'
            );INSERT INTO pisarze VALUES
            (
                        30,
                        'ZEROMSKI',
                        date '1899-09-11'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        10,10,
                        'OGNIEM I MIECZEM',
                        date '1990-01-05'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        20,10,
                        'POTOP',
                        date '1975-12-09'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        30,10,
                        'PAN WOLODYJOWSKI',
                        date '1987-02-15'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        40,20,
                        'FARAON',
                        date '1948-01-21'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        50,20,
                        'LALKA',
                        date '1994-08-01'
            );INSERT INTO ksiazki
            (
                        id_ksiazki,
                        id_pisarza,
                        tytul,
                        data_wydanie
            )
            VALUES
            (
                        60,30,
                        'PRZEDWIOSNIE',
                        date '1938-02-02'
            );CREATE type ksiazki_tab AS TABLE of varchar2(50);CREATE
OR
replace type pisarz AS object ( id_pisarza number, nazwisko varchar2(20), data_ur date, ksiazki ksiazki_tab, member FUNCTION liczba_ksiazekRETURN                                     number );CREATE
OR
replace type body pisarz AS member FUNCTION liczba_ksiazekRETURN number IS
beginRETURN ksiazki.Count();END;END;CREATE
OR
replace type ksiazka AS object ( id_ksiazki number, autor ref pisarz, tytul varchar2(50), data_wydanie date, member FUNCTION wiekRETURN                                      number );CREATE
OR
replace type body ksiazka AS member FUNCTION wiekRETURN number IS
beginRETURN Extract(year FROM CURRENT_DATE) - Extract(year FROM data_wydanie);END;END;CREATE OR replace VIEW pisarze_widok OF pisarz WITH object identifier
                       (
                                              id_pisarza
                       )
                       ASSELECT id_pisarza,
       nazwisko,
       data_ur cast(multiset
       (
              SELECT tytul
              FROM   ksiazki
              WHERE  id_pisarza = p.id_pisarza ) AS ksiazki_tab)
FROM   pisarze p;CREATE OR replace VIEW ksiazki_widok OF ksiazka WITH object identifier
                       (
                                              id_ksiazki
                       )
                       ASSELECT id_ksiazki,
       Make_ref(pisarze_widok, id_pisarza),
       tytul,
       data_wydanie
FROM   ksiazki;SELECT k.tytul,
       k.data_wydanie,
       k.autor,
       k.Wiek()
FROM   ksiazki_widok k;SELECT *
FROM   pisarze_widok p;CREATE type auto AS object ( marka varchar2(20), model varchar2(20), kilometry number, data_produkcji date, cena number(10,2), member FUNCTION wartoscRETURN                             number ) NOT final;CREATE
OR
replace type body auto AS member FUNCTION wartoscRETURN  number IS wiek number;WARTOSC number;BEGIN
  wiek := round(months_between(sysdate,data_produkcji)/12);
  wartosc := cena - (wiek * 0.1 * cena);
  if (wartosc < 0) THEN
  wartosc := 0;
endIF;RETURN wartosc;END
wartosc;END;CREATE TABLE auta OF auto;INSERT INTO auta VALUES
            (
                        auto('FIAT','BRAVA',60000,date '1999-11-30',25000)
            );INSERT INTO auta VALUES
            (
                        auto('FORD','MONDEO',80000,date '1997-05-10',45000)
            );INSERT INTO auta VALUES
            (
                        auto('MAZDA','323',12000,date '2000-09-22',52000)
            );CREATE
OR
replace type auto_osobowe under auto ( liczba_miejsc number, klimatyzacja number(1), overriding member FUNCTION wartoscRETURN                                               number );CREATE
OR
replace type body auto_osobowe AS overriding member FUNCTION wartoscRETURN number IS wartosc number;BEGIN
  wartosc := (self AS auto).wartosc();
  if (klimatyzacja > 0) THEN
  wartosc := wartosc * 1.5;
endIF;RETURN wartosc;END;END;CREATE
OR
replace type auto_ciezarowe under auto ( max_ladownosc number, overriding member FUNCTION wartoscRETURN                                                 number );CREATE
OR
replace type body auto_ciezarowe AS overriding member FUNCTION wartoscRETURN number IS wartosc number;BEGIN
  wartosc := (self AS auto).wartosc();
  if (max_ladownosc > 10000) THEN
  wartosc := wartosc * 2;
endIF;RETURN wartosc;END;END;INSERT INTO auta VALUES
            (
                        auto_osobowe('marka1', 'model1', 1000, date '2023-11-01', 2000, 4, 1)
            );INSERT INTO auta VALUES
            (
                        auto_osobowe('marka2', 'model2', 1000, date '2023-11-01', 2000, 4, 0)
            );INSERT INTO auta VALUES
            (
                        auto_ciezarowe('marka3', 'model3', 1000, date '2023-11-01', 2000, 8000)
            );INSERT INTO auta VALUES
            (
                        auto_ciezarowe('marka4', 'model4', 1000, date '2023-11-01', 2000, 12000)
            );SELECT a.marka,
       a.Wartosc()
FROM   auta a;