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

    'Kanapki z awokado': '''
Składniki:
- 1 dojrzałe awokado
- 2-3 kromki chleba
- Sok z cytryny
- Sól i pieprz
- Kiełki lub rukola (opcjonalnie)
- Pomidor (opcjonalnie)

Przygotowanie:
1. Przekrój i obierz awokado
2. Rozgnieć miąższ widelcem
3. Skrop sokiem z cytryny
4. Dopraw solą i pieprzem
5. Opiecz chleb
6. Nałóż pastę i dodatki''',

    'Jogurt z granolą': '''
Składniki:
- Jogurt naturalny
- Granola domowa lub kupna
- Miód
- Owoce sezonowe
- Orzechy (opcjonalnie)

Przygotowanie:
1. Przełóż jogurt do miski
2. Posyp granolą
3. Dodaj pokrojone owoce
4. Polej miodem
5. Posyp orzechami
6. Podawaj od razu''',

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

    'Wrap z hummusem i warzywami': '''
Składniki:
- Tortille pszenne
- Hummus
- Sałata
- Pomidor
- Ogórek
- Papryka
- Czerwona cebula

Przygotowanie:
1. Podgrzej tortillę
2. Posmaruj hummusem
3. Pokrój warzywa w paski
4. Ułóż warzywa na tortilli
5. Zwiń ciasno wrap
6. Przekrój po skosie''',

    'Bowl z quinoa i warzywami': '''
Składniki:
- Quinoa
- Ciecierzyca
- Brokuł
- Marchewka
- Szpinak
- Awokado
- Sos tahini

Przygotowanie:
1. Ugotuj quinoa
2. Upiecz warzywa w piekarniku
3. Podgrzej ciecierzycę
4. Przygotuj sos tahini
5. Ułóż składniki w misce
6. Polej sosem''',

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

    'Curry z ciecierzycą': '''
Składniki:
- Ciecierzyca
- Mleko kokosowe
- Cebula
- Czosnek
- Przyprawy curry
- Pomidory
- Ryż do podania

Przygotowanie:
1. Podsmaż cebulę i czosnek
2. Dodaj przyprawy curry
3. Wlej mleko kokosowe
4. Dodaj ciecierzycę i pomidory
5. Gotuj 15-20 minut
6. Podawaj z ryżem''',

    'Pizza domowa': '''
Składniki:
- Ciasto do pizzy
- Sos pomidorowy
- Ser mozzarella
- Ulubione dodatki
- Oliwa
- Oregano

Przygotowanie:
1. Rozwałkuj ciasto
2. Posmaruj sosem
3. Dodaj ser i dodatki
4. Skrop oliwą
5. Piecz w 220°C przez 12-15 minut
6. Posyp oregano przed podaniem''',

    // Sweet treats
    'Brownie': '''
Składniki:
- Czekolada gorzka
- Masło
- Jajka
- Cukier
- Mąka
- Proszek do pieczenia

Przygotowanie:
1. Rozpuść czekoladę z masłem
2. Ubij jajka z cukrem
3. Połącz składniki
4. Przełóż do formy
5. Piecz w 180°C przez 25 minut
6. Studź przed krojeniem''',

    'Szarlotka': '''
Składniki:
- Mąka
- Masło
- Jajka
- Jabłka
- Cynamon
- Cukier

Przygotowanie:
1. Zagnieć ciasto
2. Przygotuj jabłka z cynamonem
3. Wyłóż ciasto do formy
4. Dodaj jabłka
5. Przykryj kratką z ciasta
6. Piecz w 180°C przez 45 minut''',
  };

  // Get recipe for a specific meal
  static String? getRecipe(String mealName) {
    return recipes[mealName];
  }
} 