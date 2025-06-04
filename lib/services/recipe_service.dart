import 'package:flutter/material.dart';

class RecipeService {
  // Static map of meal names to their recipes
  static final Map<String, String> recipes = {
    // Breakfast recipes
    'Owsianka z owocami': '''
Składniki:
- 1 szklanka płatków owsianych
- 2 szklanki mleka lub wody
- Owoce sezonowe
- Miód do smaku
- Cynamon (opcjonalnie)

Przygotowanie:
1. Zagotuj mleko lub wodę w garnku
2. Dodaj płatki owsiane, zmniejsz ogień
3. Gotuj przez 3-5 minut, mieszając
4. Przełóż do miski
5. Dodaj pokrojone owoce
6. Posłódź miodem i posyp cynamonem''',

    'Jajecznica na maśle': '''
Składniki:
- 3 jajka
- 2 łyżki masła
- Sól i pieprz do smaku
- Szczypiorek (opcjonalnie)

Przygotowanie:
1. Roztop masło na patelni
2. Rozbij jajka do miski, lekko roztrzep
3. Wlej na patelnię
4. Mieszaj na małym ogniu do ścięcia
5. Dopraw solą i pieprzem
6. Posyp posiekanym szczypiorkiem''',

    // Lunch recipes
    'Sałatka z grillowanym kurczakiem': '''
Składniki:
- Pierś z kurczaka
- Mix sałat
- Pomidorki koktajlowe
- Ogórek
- Czerwona cebula
- Oliwa z oliwek
- Przyprawy do kurczaka

Przygotowanie:
1. Zamarynuj kurczaka w przyprawach
2. Grilluj pierś z obu stron
3. Pokrój warzywa
4. Połącz wszystkie składniki
5. Skrop oliwą
6. Dopraw do smaku''',

    'Makaron z sosem pomidorowym': '''
Składniki:
- Makaron spaghetti
- Puszka pomidorów
- Czosnek
- Cebula
- Bazylia
- Oliwa z oliwek

Przygotowanie:
1. Ugotuj makaron al dente
2. Zeszklij cebulę i czosnek
3. Dodaj pomidory
4. Gotuj sos 15-20 minut
5. Dopraw bazylią i przyprawami
6. Połącz z makaronem''',

    // Dinner recipes
    'Łosoś z pieczonymi warzywami': '''
Składniki:
- Filet z łososia
- Brokuł
- Marchewka
- Ziemniaki
- Oliwa
- Przyprawy

Przygotowanie:
1. Rozgrzej piekarnik do 200°C
2. Pokrój warzywa
3. Ułóż warzywa na blasze
4. Połóż łososia na warzywach
5. Piecz 20-25 minut
6. Podawaj z cytryną''',

    'Kotlet schabowy': '''
Składniki:
- Schab
- Bułka tarta
- Jajka
- Mąka
- Sól i pieprz
- Olej do smażenia

Przygotowanie:
1. Rozbij mięso
2. Panieruj w kolejności: mąka, jajko, bułka
3. Rozgrzej olej na patelni
4. Smaż z obu stron na złoty kolor
5. Odsącz na ręczniku papierowym
6. Podawaj z ziemniakami i surówką''',
  };

  // Get recipe for a specific meal
  static String? getRecipe(String mealName) {
    return recipes[mealName];
  }
} 