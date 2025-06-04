import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Food categories
  static const List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Sweet treat',
    'Snack',
    'Date night'
  ];

  // Default meals for each category
  final Map<String, List<String>> defaultMeals = {
    'Breakfast': [
      'Owsianka z owocami',
      'Jajecznica na maśle',
      'Kanapki z awokado',
      'Jogurt z granolą',
      'Naleśniki',
      'Smoothie bowl',
      'Tosty francuskie',
      'Szakszuka',
      'Omlet z warzywami',
      'Kanapki z hummusem',
      'Placki z jabłkami',
      'Muesli z jogurtem',
      'Jajka po benedyktyńsku',
      'Kasza jaglana na mleku',
      'Pancakes z syropem klonowym',
      'Kanapki z łososiem wędzonym',
      'Pudding chia',
      'Gofry z owocami',
      'Twarożek ze szczypiorkiem',
      'Bułeczki cynamonowe',
      'Racuchy z jabłkami',
      'Pasta jajeczna na toście',
      'Koktajl proteinowy',
      'Ryż na mleku',
      'Croissanty z dżemem',
      'Kanapki z pastą z tuńczyka',
      'Jaglanka z bananem',
      'Omlet z serem',
      'Jogurt grecki z miodem',
      'Płatki kukurydziane z mlekiem',
    ],
    'Lunch': [
      'Sałatka z grillowanym kurczakiem',
      'Wrap z hummusem i warzywami',
      'Makaron z sosem pomidorowym',
      'Bowl z quinoa i warzywami',
      'Zupa krem z dyni',
      'Risotto z grzybami',
      'Kotlet z indyka z kaszą',
      'Sałatka grecka',
      'Penne arrabiata',
      'Buddha bowl',
      'Zupa minestrone',
      'Tortilla z fasolą',
      'Łosoś z warzywami na parze',
      'Sałatka z komosą ryżową',
      'Curry z ciecierzycą',
      'Makaron pesto',
      'Zupa tajska',
      'Kanapka z grillowanym serem',
      'Bowl meksykański',
      'Zupa krem z brokułów',
      'Kotlet z kalafiora',
      'Sałatka z tuńczykiem',
      'Makaron z cukinią',
      'Wrap z falafelem',
      'Zupa pomidorowa',
      'Sałatka z awokado',
      'Kuskus z warzywami',
      'Frittata z warzywami',
      'Bowl azjatycki',
      'Zupa krem z soczewicy',
    ],
    'Dinner': [
      'Łosoś z pieczonymi warzywami',
      'Kotlet schabowy z ziemniakami',
      'Curry z ciecierzycą',
      'Pizza domowa',
      'Spaghetti bolognese',
      'Pierogi ruskie',
      'Kurczak w sosie śmietanowym',
      'Gulasz wołowy',
      'Ryba po grecku',
      'Lasagne',
      'Kotlet mielony z purée',
      'Kaczka z jabłkami',
      'Paella z owocami morza',
      'Gołąbki w sosie pomidorowym',
      'Indyk pieczony',
      'Makaron carbonara',
      'Dorsz w panierce',
      'Polędwiczki w sosie grzybowym',
      'Zapiekanka makaronowa',
      'Karkówka z grilla',
      'Łosoś w sosie koperkowym',
      'Kotlety mielone',
      'Kurczak curry',
      'Żeberka BBQ',
      'Dorada pieczona',
      'Schab w sosie własnym',
      'Pulpety w sosie pomidorowym',
      'Filet z kurczaka w ziołach',
      'Ryba w sosie cytrynowym',
      'Pieczeń rzymska',
    ],
    'Sweet treat': [
      'Brownie',
      'Szarlotka',
      'Sernik',
      'Muffiny czekoladowe',
      'Lody z owocami',
      'Budyń waniliowy',
      'Tiramisu',
      'Crème brûlée',
      'Panna cotta',
      'Ciasto czekoladowe',
      'Makaroniki',
      'Tarta z owocami',
      'Lody domowe',
      'Babeczki z kremem',
      'Mus czekoladowy',
      'Ciasto marchewkowe',
      'Trufle czekoladowe',
      'Jabłka w cieście',
      'Pudding ryżowy',
      'Gofry z bitą śmietaną',
      'Naleśniki z nutellą',
      'Ciasto jogurtowe',
      'Beza z owocami',
      'Fondant czekoladowy',
      'Rurki z kremem',
      'Sernik na zimno',
      'Ciasteczka owsiane',
      'Tarta cytrynowa',
      'Rafaello domowe',
      'Ciasto z galaretką',
    ],
    'Snack': [
      'Hummus z warzywami',
      'Mix orzechów',
      'Smoothie owocowe',
      'Kanapka z pastą jajeczną',
      'Owoce sezonowe',
      'Chipsy z warzyw',
      'Guacamole z nachosami',
      'Jogurt z granolą',
      'Suszone owoce',
      'Kanapka z awokado',
      'Batony energetyczne',
      'Sałatka owocowa',
      'Popcorn domowy',
      'Wrapy mini z warzywami',
      'Koktajl proteinowy',
      'Chipsy jabłkowe',
      'Mix studencki',
      'Krakersy z serem',
      'Smoothie bowl',
      'Pasta z ciecierzycy',
      'Orzechy w miodzie',
      'Warzywa z dipem',
      'Kulki mocy',
      'Tosty z humusem',
      'Chipsy bananowe',
      'Sałatka z quinoa',
      'Babeczki wytrawne',
      'Roladki z tortilli',
      'Owoce suszone w czekoladzie',
      'Mini kanapeczki',
    ],
    'Date night': [
      'Stek z frytkami',
      'Risotto z krewetkami',
      'Makaron carbonara',
      'Sushi',
      'Fondue serowe',
      'Tapas',
      'Kaczka w pomarańczach',
      'Owoce morza na winie',
      'Ravioli z truflami',
      'Tatar wołowy',
      'Krewetki w białym winie',
      'Pierś z kaczki',
      'Homary z grilla',
      'Risotto z szafranem',
      'Carpaccio wołowe',
      'Małże w sosie winnym',
      'Polędwica wellington',
      'Tagliata z rukolą',
      'Ostrygi',
      'Gnocchi z szałwią',
      'Ośmiornica z grilla',
      'Stek tomahawk',
      'Linguine z owocami morza',
      'Tatar z tuńczyka',
      'Foie gras',
      'Paella z owocami morza',
      'Żeberka BBQ',
      'Sashimi mix',
      'Wołowina po burgundzku',
      'Tempura z krewetek',
    ],
  };

  // Initialize default meals for a user
  Future<void> initializeDefaultMeals() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userMealsRef = _firestore.collection('users').doc(userId).collection('meals');
    
    // Check if user already has meals initialized
    final snapshot = await userMealsRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Initialize default meals for each category
    for (var category in categories) {
      await userMealsRef.doc(category.toLowerCase().replaceAll(' ', '_')).set({
        'meals': defaultMeals[category],
        'category': category,
      });
    }
  }

  // Get meals for a specific category
  Future<List<String>> getMealsForCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('meals')
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return List<String>.from(data?['meals'] ?? []);
      }
      return defaultMeals[category] ?? [];
    } catch (e) {
      print('Error getting meals: $e');
      return [];
    }
  }

  // Add a new meal to a category
  Future<void> addMealToCategory(String category, String meal) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('meals')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentMeals = List<String>.from(docSnapshot.data()?['meals'] ?? []);
        if (!currentMeals.contains(meal)) {
          currentMeals.add(meal);
          transaction.update(docRef, {'meals': currentMeals});
        }
      } else {
        transaction.set(docRef, {
          'meals': [meal],
          'category': category,
        });
      }
    });
  }

  // Remove a meal from a category
  Future<void> removeMealFromCategory(String category, String meal) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('meals')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentMeals = List<String>.from(docSnapshot.data()?['meals'] ?? []);
        currentMeals.remove(meal);
        transaction.update(docRef, {'meals': currentMeals});
      }
    });
  }
} 