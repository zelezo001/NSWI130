### Zapis studentu do predmetu

#### Feature breakdown

1. Student se prihlasi do informacniho systemu  
2. Student otevre modul zapisu
3. Studentovi se zobrazi rozhrani ve kterem vyhleda predmet, ktery si mini zapsat podle kodu, nazvu, atd. 
    - System se pta rozvrhoveho modulu na informace o predmetech
4. Zapisovy modul zobrazi seznam predmetu, ktere odpovidaji popisu
5. Student vybere pozadovany predmet
6. Studentovi se zobrazi konkretni listky pro obdobi zapisu
    - System se opet pta rozvrhoveho modulu na informace pro konkretni predmet
7. Student vybira prednasku (+ optional cviceni) a potvrdi zapis. Pokud je vynuceno u predmetu zapsat prednasku i cviceni, student zaklikne listek prednasky a listek cviceni, teprve potom je mu umozneno potvrdit zapis.
8. Kontroluje se kapacita zvolenych listku
    - Informace zjistujeme z interniho modulu, ktery udrzuje udaje o aktualnich kapacitach
9. Pokud fronty nejsou, student dostane hlaseni o uspesnem zapisu. V opacnem pripade je student zarazen do cekaci fronty.
    - System nabidne alternativni rozvrhove listky (s volnou kapacitou) pro tento predmet - v pripade ze cviceni je nutne s prednaskou, student si z alternativ **musi** vybrat, do te doby neni potvrzen zapis.

#### Responsibilities

##### User info responsibility

- Spravne identifikujeme uzivatele
- Podle role student/ucitel/studijni odlisujeme jake features jsou dostupne
- Potrebujeme pristup k jeho informacim 

##### Data collection responsibility

- Potrebujeme spravne ziskat data o rozvrhu z prislusneho modulu.
- Volani rozvrhoveho API musi byt ze sdileneho bodu
- Adaptace na moznost zmeny v externim API

##### Increased traffic responsibility

- Je ocekavano ze zapisovy modul bude pod extremnim vytizenim v dobe otevreni zapisu
- Naopak v vsech ostatnich obdobich semestru bude bod nizkym tlakem
- Kladen duraz na moznost skalovat na potrebnou dobu

##### Validation responsibility

- Cast systemu, ktera bude mit velky napor v dobe otevreni zapisu, je nutne drzet pevne poradi.
- Udrzeni stavu fronty
- Deterministicke chovani a automaticke prerazovani na cekaci listinu

##### Data management responsibility

- Drzeni udaju o poctu studentu zapsanych na rozvrhovy listek
- Hlidani navrseni kapacit

##### Alert responsibility

- Student musi mit jasne vizualni potvrzeni o tom ze zapis byl uspesny
- Naopak kdyz nebyl umoznen, potrebuje vedet jak postupovat dale

##### User interface responsibility

- Zobrazeni rozvrhovych dat
- Usnadneni pro studenta, aby vedel v jakych casovych slotech ma jeste volno

##### Rule-enforcing responsibility

- Nektere predmety budou mit specialni pravidla
- Adaptovani na vynuceni pozadavku typu: prerekvizity, nutne cviceni s prednaskou

##### Subject sorting responsibility

- Pro navigovani mezi predmety k zapisu
- Nutnost seradit si je podle potreb
- Prehlednost pro studenta

##### Queue responsibility

- Pri naplneni kapacity listku
- Automaticke zarazeni na cekaci listinu


