# Rozvrhy

Cílem našeho projektu bylo navrhout část SISu starající se o správu předmětů a rozvrhů.

## Rozdělení zodpovědností

## Architektonické rozhodnutí

- Rozdělení BE na admin/public:
  - Do budoucna lze admin skrýt do privátní sítě.
  - Public část je read-only a lze ji do budoucna škálovat bez potřeby škálovat admin.
    - Nyní by to mělo jít bez zásahu do architektury.
  - Public část nepotřebuje autorizovat uživatele.
  - Na public část lze použít read oriented protokoly (graphQL).
- Rozdělení databází:
  - Rozvrhové sloty nejsou v gestci naší části a může ji do ní zapisovat někdo jiný (např. správa budov UK).
  - Ne všechny předměty budou pocházet z UK (meziuniverzitní dohody) a proto je potřeba separatovat 
  rozvrhy do vlastní DB.