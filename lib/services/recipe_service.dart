import 'package:flutter/material.dart';

class RecipeService {
  // Static map of meal names to their recipes
  static final Map<String, String> recipes = {
    // Breakfast recipes
    'Oatmeal with fruits': '''
Ingredients:
- 1 cup of oatmeal
- 2 cups of milk or water
- Seasonal fruits
- Honey to taste
- Cinnamon (optional)

Preparation:
1. Boil milk or water in a pot
2. Add oatmeal, reduce heat
3. Cook for 3-5 minutes, stirring
4. Transfer to a bowl
5. Add chopped fruits
6. Sweeten with honey and sprinkle with cinnamon''',

    'Scrambled eggs with butter': '''
Ingredients:
- 3 eggs
- 2 tablespoons of butter
- Salt and pepper to taste
- Chives (optional)

Preparation:
1. Melt butter in a pan
2. Break eggs into a bowl, lightly whisk
3. Pour into the pan
4. Stir on low heat until set
5. Season with salt and pepper
6. Sprinkle with chopped chives''',

    'Avocado toast': '''
Ingredients:
- 1 ripe avocado
- 2-3 slices of bread
- Lemon juice
- Salt and pepper
- Sprouts or arugula (optional)
- Tomato (optional)

Preparation:
1. Cut and peel the avocado
2. Mash the flesh with a fork
3. Drizzle with lemon juice
4. Season with salt and pepper
5. Toast the bread
6. Spread the paste and add toppings''',

    'Yogurt with granola': '''
Ingredients:
- Natural yogurt
- Homemade or store-bought granola
- Honey
- Seasonal fruits
- Nuts (optional)

Preparation:
1. Transfer yogurt to a bowl
2. Sprinkle with granola
3. Add chopped fruits
4. Drizzle with honey
5. Sprinkle with nuts
6. Serve immediately''',

    'Pancakes': '''
Ingredients:
- 1 1/2 cups flour
- 3 1/2 tsp baking powder
- 1 tsp salt
- 1 tbsp sugar
- 1 1/4 cups milk
- 1 egg
- 3 tbsp butter, melted
- 1 tsp vanilla extract

Preparation:
1. Mix dry ingredients in a bowl
2. Whisk wet ingredients in another bowl
3. Combine mixtures until smooth
4. Heat a griddle or pan
5. Pour batter to form pancakes
6. Flip when bubbles form on top''',

    'Smoothie bowl': '''
Ingredients:
- 2 frozen bananas
- 1 cup frozen berries
- 1/2 cup milk or yogurt
- Toppings: granola, fresh fruits, nuts, seeds
- Honey or maple syrup (optional)

Preparation:
1. Blend frozen fruits with milk/yogurt
2. Pour into a bowl
3. Add granola
4. Arrange fresh fruits
5. Sprinkle with nuts and seeds
6. Drizzle with honey if desired''',

    'French toast': '''
Ingredients:
- 8 slices of bread
- 4 eggs
- 1 cup milk
- 2 tbsp sugar
- 1 tsp cinnamon
- 1 tsp vanilla extract
- Butter for frying

Preparation:
1. Whisk eggs, milk, sugar, cinnamon, and vanilla
2. Soak bread slices in mixture
3. Heat butter in a pan
4. Fry each side until golden
5. Serve with maple syrup
6. Add fresh fruits if desired''',

    'Shakshuka': '''
Ingredients:
- 6 eggs
- 2 cans diced tomatoes
- 1 onion
- 2 bell peppers
- 3 cloves garlic
- Spices: cumin, paprika, chili
- Fresh herbs
- Feta cheese (optional)

Preparation:
1. Sauté onion and peppers
2. Add garlic and spices
3. Pour in tomatoes
4. Simmer for 10 minutes
5. Create wells and crack eggs
6. Cover and cook until eggs set''',

    'Vegetable omelette': '''
Ingredients:
- 3 eggs
- 1/4 cup diced vegetables
- 1/4 cup cheese
- Salt and pepper
- Herbs
- Butter for cooking

Preparation:
1. Whisk eggs with seasonings
2. Sauté vegetables
3. Pour egg mixture
4. Add cheese
5. Fold when set
6. Serve immediately''',

    'Hummus sandwich': '''
Ingredients:
- 2 slices bread
- Hummus
- Cucumber
- Tomato
- Lettuce
- Red onion
- Sprouts (optional)

Preparation:
1. Toast bread if desired
2. Spread hummus on both slices
3. Layer vegetables
4. Add sprouts if using
5. Close sandwich
6. Cut diagonally''',

    'Apple pancakes': '''
Ingredients:
- 1 cup flour
- 1 apple, grated
- 1 egg
- 1/2 cup milk
- 1 tbsp sugar
- 1 tsp cinnamon
- Butter for cooking

Preparation:
1. Mix dry ingredients
2. Add grated apple
3. Whisk in wet ingredients
4. Heat pan with butter
5. Cook until golden
6. Serve with maple syrup''',

    'Muesli with yogurt': '''
Ingredients:
- 1 cup muesli
- 1 cup yogurt
- Fresh fruits
- Honey
- Nuts (optional)
- Seeds (optional)

Preparation:
1. Combine muesli and yogurt
2. Let sit for 5 minutes
3. Add fresh fruits
4. Drizzle with honey
5. Top with nuts and seeds
6. Serve immediately''',

    'Eggs benedict': '''
Ingredients:
- 4 English muffins
- 8 slices ham
- 8 eggs
- Hollandaise sauce
- Fresh herbs
- Butter

Preparation:
1. Toast English muffins
2. Poach eggs
3. Prepare hollandaise sauce
4. Layer ham on muffins
5. Top with poached eggs
6. Pour sauce and garnish''',

    'Millet porridge with milk': '''
Ingredients:
- 1 cup millet
- 2 cups milk
- 1 tbsp honey
- Cinnamon
- Fresh fruits
- Nuts (optional)

Preparation:
1. Rinse millet
2. Cook with milk
3. Stir until creamy
4. Sweeten with honey
5. Add cinnamon
6. Top with fruits and nuts''',

    'Pancakes with maple syrup': '''
Ingredients:
- 1 1/2 cups flour
- 3 1/2 tsp baking powder
- 1 tsp salt
- 1 tbsp sugar
- 1 1/4 cups milk
- 1 egg
- 3 tbsp butter
- Maple syrup

Preparation:
1. Mix dry ingredients
2. Combine wet ingredients
3. Cook on griddle
4. Flip when bubbly
5. Stack pancakes
6. Drizzle with syrup''',

    'Smoked salmon sandwich': '''
Ingredients:
- 2 slices bread
- Smoked salmon
- Cream cheese
- Red onion
- Capers
- Dill
- Lemon

Preparation:
1. Toast bread
2. Spread cream cheese
3. Layer salmon
4. Add onion and capers
5. Garnish with dill
6. Squeeze lemon juice''',

    'Chia pudding': '''
Ingredients:
- 1/4 cup chia seeds
- 1 cup milk
- 1 tbsp honey
- Vanilla extract
- Fresh fruits
- Nuts (optional)

Preparation:
1. Mix chia and milk
2. Add honey and vanilla
3. Refrigerate overnight
4. Stir before serving
5. Top with fruits
6. Add nuts if desired''',

    'Waffles with fruits': '''
Ingredients:
- 2 cups flour
- 2 tbsp sugar
- 1 tbsp baking powder
- 2 eggs
- 1 3/4 cups milk
- 1/2 cup oil
- Fresh fruits
- Maple syrup

Preparation:
1. Mix dry ingredients
2. Whisk wet ingredients
3. Combine until smooth
4. Cook in waffle iron
5. Top with fruits
6. Serve with syrup''',

    'Cottage cheese with chives': '''
Ingredients:
- 1 cup cottage cheese
- Fresh chives
- Salt and pepper
- Olive oil
- Toast or crackers
- Cherry tomatoes

Preparation:
1. Chop chives
2. Mix with cottage cheese
3. Season to taste
4. Drizzle with oil
5. Serve with toast
6. Garnish with tomatoes''',

    'Cinnamon rolls': '''
Ingredients:
- 2 1/4 cups flour
- 1/4 cup sugar
- 1 tsp yeast
- 1/2 cup milk
- 2 tbsp butter
- Cinnamon sugar
- Icing

Preparation:
1. Make dough
2. Roll out and fill
3. Cut into rolls
4. Let rise
5. Bake until golden
6. Top with icing''',

    'Apple fritters': '''
Ingredients:
- 2 apples
- 1 cup flour
- 1 egg
- 1/2 cup milk
- 1 tbsp sugar
- Cinnamon
- Oil for frying

Preparation:
1. Slice apples
2. Make batter
3. Dip apple slices
4. Heat oil
5. Fry until golden
6. Dust with sugar''',

    'Egg salad on toast': '''
Ingredients:
- 4 hard-boiled eggs
- 2 tbsp mayonnaise
- 1 tbsp mustard
- Salt and pepper
- Bread
- Fresh herbs

Preparation:
1. Chop eggs
2. Mix with mayo
3. Add seasonings
4. Toast bread
5. Spread mixture
6. Garnish with herbs''',

    'Protein shake': '''
Ingredients:
- 1 scoop protein powder
- 1 banana
- 1 cup milk
- 1 tbsp peanut butter
- Ice cubes
- Honey (optional)

Preparation:
1. Add all ingredients
2. Blend until smooth
3. Adjust consistency
4. Taste and adjust
5. Pour into glass
6. Serve immediately''',

    'Rice pudding': '''
Ingredients:
- 1 cup rice
- 2 cups milk
- 1/4 cup sugar
- 1 tsp vanilla
- Cinnamon
- Raisins (optional)

Preparation:
1. Cook rice in milk
2. Add sugar
3. Stir until creamy
4. Add vanilla
5. Top with cinnamon
6. Add raisins if desired''',

    'Croissants with jam': '''
Ingredients:
- Croissants
- Assorted jams
- Butter
- Fresh fruits
- Powdered sugar
- Whipped cream (optional)

Preparation:
1. Warm croissants
2. Slice in half
3. Spread butter
4. Add jam
5. Top with fruits
6. Dust with sugar''',

    'Tuna sandwich': '''
Ingredients:
- 2 slices bread
- Canned tuna
- Mayonnaise
- Celery
- Onion
- Lettuce
- Salt and pepper

Preparation:
1. Drain tuna
2. Mix with mayo
3. Add vegetables
4. Season to taste
5. Spread on bread
6. Add lettuce''',

    'Millet porridge with banana': '''
Ingredients:
- 1 cup millet
- 2 cups milk
- 1 banana
- Honey
- Cinnamon
- Nuts (optional)

Preparation:
1. Cook millet in milk
2. Slice banana
3. Add to porridge
4. Sweeten with honey
5. Add cinnamon
6. Top with nuts''',

    'Cheese omelette': '''
Ingredients:
- 3 eggs
- 1/4 cup cheese
- 1 tbsp butter
- Salt and pepper
- Herbs
- Toast (optional)

Preparation:
1. Whisk eggs
2. Heat butter
3. Pour egg mixture
4. Add cheese
5. Fold when set
6. Serve with toast''',

    'Greek yogurt with honey': '''
Ingredients:
- 1 cup Greek yogurt
- 2 tbsp honey
- Fresh fruits
- Nuts
- Granola
- Mint leaves

Preparation:
1. Spoon yogurt into bowl
2. Drizzle with honey
3. Add fresh fruits
4. Sprinkle with nuts
5. Add granola
6. Garnish with mint''',

    'Cornflakes with milk': '''
Ingredients:
- 2 cups cornflakes
- 1 cup milk
- Fresh fruits
- Honey
- Nuts (optional)
- Cinnamon (optional)

Preparation:
1. Pour cornflakes
2. Add milk
3. Top with fruits
4. Drizzle honey
5. Add nuts if desired
6. Sprinkle cinnamon''',

    // Lunch recipes
    'Grilled chicken salad': '''
Ingredients:
- Chicken breast
- Mixed salad greens
- Cherry tomatoes
- Cucumber
- Red onion
- Olive oil
- Chicken seasonings

Preparation:
1. Marinate chicken in seasonings
2. Grill the breast on both sides
3. Chop vegetables
4. Combine all ingredients
5. Drizzle with olive oil
6. Season to taste''',

    'Pasta with tomato sauce': '''
Ingredients:
- Spaghetti pasta
- Can of tomatoes
- Garlic
- Onion
- Basil
- Olive oil

Preparation:
1. Cook pasta al dente
2. Sauté onion and garlic
3. Add tomatoes
4. Cook sauce for 15-20 minutes
5. Season with basil and spices
6. Combine with pasta''',

    'Hummus and vegetable wrap': '''
Ingredients:
- Wheat tortillas
- Hummus
- Lettuce
- Tomato
- Cucumber
- Bell pepper
- Red onion

Preparation:
1. Warm the tortilla
2. Spread with hummus
3. Cut vegetables into strips
4. Arrange vegetables on tortilla
5. Roll up tightly
6. Cut diagonally''',

    'Quinoa and vegetable bowl': '''
Ingredients:
- Quinoa
- Chickpeas
- Broccoli
- Carrot
- Spinach
- Avocado
- Tahini sauce

Preparation:
1. Cook quinoa
2. Roast vegetables in the oven
3. Heat chickpeas
4. Prepare tahini sauce
5. Arrange ingredients in a bowl
6. Drizzle with sauce''',

    'Pumpkin cream soup': '''
Ingredients:
- 1 small pumpkin
- 1 onion
- 2 cloves garlic
- 2 cups vegetable broth
- 1 cup cream
- Nutmeg
- Salt and pepper

Preparation:
1. Roast pumpkin
2. Sauté onion and garlic
3. Add pumpkin and broth
4. Simmer until soft
5. Blend until smooth
6. Add cream and season''',

    'Mushroom risotto': '''
Ingredients:
- 1 cup Arborio rice
- 2 cups mushrooms
- 1 onion
- 1/2 cup white wine
- 4 cups broth
- Parmesan cheese
- Butter

Preparation:
1. Sauté mushrooms
2. Cook onion
3. Add rice and wine
4. Gradually add broth
5. Stir until creamy
6. Add cheese and butter''',

    'Turkey cutlet with buckwheat': '''
Ingredients:
- 2 turkey cutlets
- 1 cup buckwheat
- 2 cups broth
- Herbs
- Butter
- Salt and pepper

Preparation:
1. Cook buckwheat
2. Season cutlets
3. Pan-fry turkey
4. Rest meat
5. Combine with buckwheat
6. Garnish with herbs''',

    'Greek salad': '''
Ingredients:
- Cucumber
- Tomatoes
- Red onion
- Feta cheese
- Olives
- Olive oil
- Oregano

Preparation:
1. Chop vegetables
2. Cube feta
3. Combine ingredients
4. Add olives
5. Drizzle with oil
6. Sprinkle oregano''',

    'Penne arrabiata': '''
Ingredients:
- Penne pasta
- 2 cans tomatoes
- 4 cloves garlic
- Red chili
- Olive oil
- Basil
- Parmesan

Preparation:
1. Cook pasta
2. Sauté garlic and chili
3. Add tomatoes
4. Simmer sauce
5. Combine with pasta
6. Top with cheese''',

    'Buddha bowl': '''
Ingredients:
- Quinoa
- Roasted vegetables
- Avocado
- Chickpeas
- Tahini dressing
- Seeds
- Greens

Preparation:
1. Cook quinoa
2. Roast vegetables
3. Prepare dressing
4. Arrange in bowl
5. Add toppings
6. Drizzle with sauce''',

    'Minestrone soup': '''
Ingredients:
- 2 cups vegetables
- 1 cup pasta
- 1 can beans
- 1 can tomatoes
- Herbs
- Parmesan
- Olive oil

Preparation:
1. Sauté vegetables
2. Add tomatoes
3. Pour in broth
4. Add pasta
5. Include beans
6. Garnish with cheese''',

    'Bean tortilla': '''
Ingredients:
- 2 tortillas
- 1 can beans
- 1 bell pepper
- 1 onion
- Cheese
- Spices
- Salsa

Preparation:
1. Heat beans
2. Sauté vegetables
3. Warm tortillas
4. Fill with mixture
5. Add cheese
6. Serve with salsa''',

    'Salmon with steamed vegetables': '''
Ingredients:
- 2 salmon fillets
- Mixed vegetables
- Lemon
- Herbs
- Olive oil
- Salt and pepper

Preparation:
1. Season salmon
2. Steam vegetables
3. Pan-sear fish
4. Add lemon
5. Plate vegetables
6. Top with salmon''',

    'Quinoa salad': '''
Ingredients:
- 1 cup quinoa
- Vegetables
- Feta cheese
- Nuts
- Olive oil
- Lemon juice
- Herbs

Preparation:
1. Cook quinoa
2. Chop vegetables
3. Combine ingredients
4. Add cheese
5. Make dressing
6. Toss and serve''',

    'Pesto pasta': '''
Ingredients:
- Pasta
- 2 cups basil
- Pine nuts
- Parmesan
- Garlic
- Olive oil
- Salt

Preparation:
1. Cook pasta
2. Make pesto
3. Blend ingredients
4. Combine with pasta
5. Add cheese
6. Garnish with nuts''',

    'Thai soup': '''
Ingredients:
- Coconut milk
- Lemongrass
- Ginger
- Mushrooms
- Tofu
- Lime
- Thai basil

Preparation:
1. Simmer broth
2. Add vegetables
3. Include tofu
4. Pour coconut milk
5. Add herbs
6. Squeeze lime''',

    'Grilled cheese sandwich': '''
Ingredients:
- 4 slices bread
- Cheese
- Butter
- Herbs
- Tomato (optional)
- Mustard (optional)

Preparation:
1. Butter bread
2. Add cheese
3. Include extras
4. Grill both sides
5. Press lightly
6. Cut and serve''',

    'Mexican bowl': '''
Ingredients:
- Rice
- Black beans
- Corn
- Avocado
- Salsa
- Cheese
- Lime

Preparation:
1. Cook rice
2. Heat beans
3. Prepare toppings
4. Arrange in bowl
5. Add salsa
6. Squeeze lime''',

    'Broccoli cream soup': '''
Ingredients:
- 1 head broccoli
- 1 onion
- 2 cups broth
- 1 cup cream
- Nutmeg
- Salt and pepper
- Croutons

Preparation:
1. Chop vegetables
2. Sauté onion
3. Add broccoli
4. Simmer in broth
5. Blend until smooth
6. Add cream and season''',

    'Cauliflower cutlet': '''
Ingredients:
- 1 head cauliflower
- Breadcrumbs
- Eggs
- Spices
- Oil for frying
- Herbs
- Lemon

Preparation:
1. Steam cauliflower
2. Make mixture
3. Form cutlets
4. Bread them
5. Fry until golden
6. Serve with lemon''',

    'Tuna salad': '''
Ingredients:
- Canned tuna
- Mayonnaise
- Celery
- Onion
- Lemon juice
- Herbs
- Salt and pepper

Preparation:
1. Drain tuna
2. Chop vegetables
3. Mix ingredients
4. Add mayo
5. Season to taste
6. Chill before serving''',

    'Zucchini pasta': '''
Ingredients:
- 2 zucchinis
- Pasta sauce
- Garlic
- Olive oil
- Parmesan
- Herbs
- Pine nuts

Preparation:
1. Spiralize zucchini
2. Sauté garlic
3. Add zucchini
4. Heat sauce
5. Combine
6. Top with cheese''',

    'Falafel wrap': '''
Ingredients:
- Falafel balls
- Pita bread
- Hummus
- Vegetables
- Tahini sauce
- Herbs
- Lemon

Preparation:
1. Warm pita
2. Spread hummus
3. Add falafel
4. Include vegetables
5. Drizzle sauce
6. Roll and serve''',

    'Tomato soup': '''
Ingredients:
- 6 tomatoes
- 1 onion
- 2 cloves garlic
- Basil
- Cream
- Croutons
- Olive oil

Preparation:
1. Roast tomatoes
2. Sauté aromatics
3. Add tomatoes
4. Simmer
5. Blend until smooth
6. Add cream and garnish''',

    'Avocado salad': '''
Ingredients:
- 2 avocados
- Cherry tomatoes
- Red onion
- Lime
- Olive oil
- Herbs
- Salt and pepper

Preparation:
1. Cube avocado
2. Halve tomatoes
3. Slice onion
4. Combine ingredients
5. Make dressing
6. Toss and serve''',

    'Couscous with vegetables': '''
Ingredients:
- 1 cup couscous
- Mixed vegetables
- Herbs
- Lemon
- Olive oil
- Nuts
- Feta cheese

Preparation:
1. Prepare couscous
2. Roast vegetables
3. Combine
4. Add herbs
5. Drizzle with oil
6. Top with cheese''',

    'Vegetable frittata': '''
Ingredients:
- 6 eggs
- Mixed vegetables
- Cheese
- Herbs
- Olive oil
- Salt and pepper
- Milk

Preparation:
1. Sauté vegetables
2. Whisk eggs
3. Add to pan
4. Cook until set
5. Add cheese
6. Finish under broiler''',

    'Asian bowl': '''
Ingredients:
- Rice
- Vegetables
- Protein
- Soy sauce
- Sesame oil
- Green onions
- Sesame seeds

Preparation:
1. Cook rice
2. Prepare vegetables
3. Cook protein
4. Make sauce
5. Arrange in bowl
6. Garnish and serve''',

    'Lentil cream soup': '''
Ingredients:
- 1 cup lentils
- 1 onion
- 2 carrots
- 2 cloves garlic
- Herbs
- Cream
- Croutons

Preparation:
1. Cook lentils
2. Sauté vegetables
3. Combine
4. Simmer
5. Blend until smooth
6. Add cream and garnish''',

    // Dinner recipes
    'Salmon with roasted vegetables': '''
Ingredients:
- Salmon fillet
- Broccoli
- Carrot
- Potatoes
- Olive oil
- Seasonings

Preparation:
1. Preheat oven to 200°C
2. Chop vegetables
3. Arrange vegetables on a baking sheet
4. Place salmon on vegetables
5. Bake for 20-25 minutes
6. Serve with lemon''',

    'Pork cutlet': '''
Ingredients:
- Pork
- Breadcrumbs
- Eggs
- Flour
- Salt and pepper
- Oil for frying

Preparation:
1. Pound the meat
2. Bread in order: flour, egg, breadcrumbs
3. Heat oil in a pan
4. Fry on both sides until golden
5. Drain on paper towels
6. Serve with potatoes and salad''',

    'Chickpea curry': '''
Ingredients:
- Chickpeas
- Coconut milk
- Onion
- Garlic
- Curry spices
- Tomatoes
- Rice for serving

Preparation:
1. Sauté onion and garlic
2. Add curry spices
3. Pour in coconut milk
4. Add chickpeas and tomatoes
5. Cook for 15-20 minutes
6. Serve with rice''',

    'Homemade pizza': '''
Ingredients:
- Pizza dough
- Tomato sauce
- Mozzarella cheese
- Favorite toppings
- Olive oil
- Oregano

Preparation:
1. Roll out the dough
2. Spread with sauce
3. Add cheese and toppings
4. Drizzle with olive oil
5. Bake at 220°C for 12-15 minutes
6. Sprinkle with oregano before serving''',

    'Spaghetti bolognese': '''
Ingredients:
- Spaghetti pasta
- Ground beef
- 2 cans tomatoes
- 1 onion
- 2 cloves garlic
- Herbs
- Parmesan

Preparation:
1. Cook pasta
2. Brown meat
3. Sauté vegetables
4. Simmer sauce
5. Combine
6. Top with cheese''',

    'Russian pierogi': '''
Ingredients:
- 2 cups flour
- 1 egg
- Water
- Filling of choice
- Butter
- Sour cream
- Herbs

Preparation:
1. Make dough
2. Prepare filling
3. Form pierogi
4. Boil
5. Pan-fry
6. Serve with toppings''',

    'Chicken in cream sauce': '''
Ingredients:
- 4 chicken breasts
- 1 cup cream
- Mushrooms
- Herbs
- White wine
- Butter
- Garlic

Preparation:
1. Season chicken
2. Brown meat
3. Sauté mushrooms
4. Add wine
5. Pour cream
6. Simmer until done''',

    'Beef goulash': '''
Ingredients:
- 1 lb beef
- 2 onions
- 2 bell peppers
- Paprika
- Tomato paste
- Caraway seeds
- Sour cream

Preparation:
1. Brown beef
2. Sauté vegetables
3. Add spices
4. Simmer
5. Add paste
6. Serve with cream''',

    'Fish in Greek style': '''
Ingredients:
- 4 fish fillets
- Tomatoes
- Onion
- Herbs
- Olive oil
- Lemon
- Feta cheese

Preparation:
1. Season fish
2. Sauté vegetables
3. Add tomatoes
4. Place fish
5. Bake
6. Add cheese''',

    'Lasagna': '''
Ingredients:
- Lasagna sheets
- Ground meat
- Tomato sauce
- Béchamel
- Cheese
- Herbs
- Garlic

Preparation:
1. Make sauces
2. Cook meat
3. Layer ingredients
4. Add cheese
5. Bake
6. Rest before serving''',

    'Meat patty with mashed potatoes': '''
Ingredients:
- Ground meat
- 4 potatoes
- Onion
- Breadcrumbs
- Milk
- Butter
- Herbs

Preparation:
1. Make patties
2. Cook potatoes
3. Mash with milk
4. Fry patties
5. Season
6. Serve together''',

    'Duck with apples': '''
Ingredients:
- Duck breast
- 2 apples
- Honey
- Herbs
- Wine
- Butter
- Spices

Preparation:
1. Score duck
2. Cook apples
3. Pan-sear duck
4. Make sauce
5. Rest meat
6. Serve together''',

    'Seafood paella': '''
Ingredients:
- 2 cups rice
- Mixed seafood
- Saffron
- Peas
- Bell pepper
- White wine
- Herbs

Preparation:
1. Toast rice
2. Add wine
3. Add seafood
4. Add vegetables
5. Cook until done
6. Rest before serving''',

    'Cabbage rolls in tomato sauce': '''
Ingredients:
- Cabbage leaves
- Ground meat
- Rice
- Tomato sauce
- Herbs
- Onion
- Garlic

Preparation:
1. Blanch leaves
2. Make filling
3. Roll up
4. Place in pan
5. Add sauce
6. Simmer until done''',

    'Roasted turkey': '''
Ingredients:
- Turkey breast
- Herbs
- Butter
- Garlic
- Vegetables
- Wine
- Stock

Preparation:
1. Season turkey
2. Prepare vegetables
3. Roast
4. Baste
5. Rest
6. Make gravy''',

    'Pasta carbonara': '''
Ingredients:
- Spaghetti
- Pancetta
- Eggs
- Parmesan
- Black pepper
- Garlic
- Olive oil

Preparation:
1. Cook pasta
2. Fry pancetta
3. Mix eggs
4. Combine
5. Add cheese
6. Season with pepper''',

    'Breaded cod': '''
Ingredients:
- 4 cod fillets
- Breadcrumbs
- Eggs
- Flour
- Lemon
- Herbs
- Oil for frying

Preparation:
1. Season fish
2. Bread in order
3. Heat oil
4. Fry until golden
5. Drain
6. Serve with lemon''',

    'Pork tenderloin in mushroom sauce': '''
Ingredients:
- Pork tenderloin
- Mushrooms
- Cream
- Wine
- Herbs
- Garlic
- Butter

Preparation:
1. Season meat
2. Brown tenderloin
3. Sauté mushrooms
4. Add wine
5. Add cream
6. Simmer until done''',

    'Pasta casserole': '''
Ingredients:
- Pasta
- Ground meat
- Tomato sauce
- Cheese
- Herbs
- Breadcrumbs
- Garlic

Preparation:
1. Cook pasta
2. Make sauce
3. Layer ingredients
4. Add cheese
5. Top with crumbs
6. Bake until golden''',

    'Grilled pork neck': '''
Ingredients:
- Pork neck
- Marinade
- Herbs
- Garlic
- Oil
- Spices
- Lemon

Preparation:
1. Marinate meat
2. Heat grill
3. Cook meat
4. Rest
5. Slice
6. Serve with sides''',

    'Salmon in dill sauce': '''
Ingredients:
- 4 salmon fillets
- Fresh dill
- Cream
- White wine
- Butter
- Lemon
- Herbs

Preparation:
1. Season fish
2. Make sauce
3. Poach salmon
4. Add dill
5. Reduce sauce
6. Serve together''',

    'Meat patties': '''
Ingredients:
- Ground meat
- Onion
- Breadcrumbs
- Eggs
- Herbs
- Spices
- Oil for frying

Preparation:
1. Mix ingredients
2. Form patties
3. Heat oil
4. Fry both sides
5. Drain
6. Serve hot''',

    'Chicken curry': '''
Ingredients:
- Chicken pieces
- Curry paste
- Coconut milk
- Vegetables
- Herbs
- Rice
- Lime

Preparation:
1. Brown chicken
2. Add paste
3. Pour milk
4. Add vegetables
5. Simmer
6. Serve with rice''',

    'BBQ ribs': '''
Ingredients:
- Pork ribs
- BBQ sauce
- Spices
- Garlic
- Honey
- Herbs
- Apple juice

Preparation:
1. Season ribs
2. Make sauce
3. Slow cook
4. Baste
5. Grill
6. Rest before serving''',

    'Baked sea bream': '''
Ingredients:
- Whole sea bream
- Herbs
- Lemon
- Olive oil
- Garlic
- Vegetables
- White wine

Preparation:
1. Clean fish
2. Stuff cavity
3. Season
4. Add vegetables
5. Bake
6. Serve with lemon''',

    'Pork in its own sauce': '''
Ingredients:
- Pork shoulder
- Onion
- Garlic
- Herbs
- Wine
- Stock
- Vegetables

Preparation:
1. Brown meat
2. Add vegetables
3. Pour liquids
4. Slow cook
5. Reduce sauce
6. Serve with sides''',

    'Meatballs in tomato sauce': '''
Ingredients:
- Ground meat
- Breadcrumbs
- Eggs
- Tomato sauce
- Herbs
- Parmesan
- Garlic

Preparation:
1. Mix ingredients
2. Form balls
3. Brown
4. Add sauce
5. Simmer
6. Serve with pasta''',

    'Chicken fillet with herbs': '''
Ingredients:
- 4 chicken breasts
- Fresh herbs
- Butter
- Garlic
- White wine
- Lemon
- Olive oil

Preparation:
1. Season chicken
2. Pan-sear
3. Add herbs
4. Add wine
5. Finish cooking
6. Rest before serving''',

    'Fish in lemon sauce': '''
Ingredients:
- 4 fish fillets
- Lemon
- Butter
- Herbs
- White wine
- Capers
- Garlic

Preparation:
1. Season fish
2. Make sauce
3. Poach fish
4. Add lemon
5. Reduce sauce
6. Serve with capers''',

    'Roman roast': '''
Ingredients:
- Beef roast
- Herbs
- Garlic
- Wine
- Stock
- Vegetables
- Butter

Preparation:
1. Season meat
2. Brown roast
3. Add liquids
4. Add vegetables
5. Slow cook
6. Rest before serving''',

    // Sweet treats
    'Brownie': '''
Ingredients:
- Dark chocolate
- Butter
- Eggs
- Sugar
- Flour
- Baking powder

Preparation:
1. Melt chocolate with butter
2. Beat eggs with sugar
3. Combine ingredients
4. Transfer to a pan
5. Bake at 180°C for 25 minutes
6. Cool before cutting''',

    'Apple pie': '''
Ingredients:
- Flour
- Butter
- Eggs
- Apples
- Cinnamon
- Sugar

Preparation:
1. Knead the dough
2. Prepare apples with cinnamon
3. Line the pan with dough
4. Add apples
5. Cover with lattice dough
6. Bake at 180°C for 45 minutes''',

    'Cheesecake': '''
Ingredients:
- 2 cups graham crackers
- 1/2 cup butter
- 3 packages cream cheese
- 1 cup sugar
- 3 eggs
- 1 tsp vanilla
- Sour cream topping

Preparation:
1. Make crust
2. Mix filling
3. Bake base
4. Add topping
5. Chill overnight
6. Serve chilled''',

    'Chocolate muffins': '''
Ingredients:
- 2 cups flour
- 1 cup cocoa
- 1 1/2 cups sugar
- 2 eggs
- 1 cup milk
- 1/2 cup oil
- Chocolate chips

Preparation:
1. Mix dry ingredients
2. Combine wet ingredients
3. Fold together
4. Add chocolate chips
5. Fill muffin tins
6. Bake until done''',

    'Ice cream with fruits': '''
Ingredients:
- Vanilla ice cream
- Mixed berries
- Whipped cream
- Chocolate sauce
- Nuts
- Mint leaves
- Waffle cone

Preparation:
1. Scoop ice cream
2. Add fruits
3. Drizzle sauce
4. Add whipped cream
5. Sprinkle nuts
6. Garnish with mint''',

    'Vanilla pudding': '''
Ingredients:
- 2 cups milk
- 1/4 cup sugar
- 2 tbsp cornstarch
- 1 egg
- Vanilla extract
- Whipped cream
- Berries

Preparation:
1. Heat milk
2. Mix dry ingredients
3. Add to milk
4. Cook until thick
5. Add vanilla
6. Chill and serve''',

    'Tiramisu': '''
Ingredients:
- Ladyfingers
- Mascarpone
- Coffee
- Eggs
- Sugar
- Cocoa powder
- Marsala wine

Preparation:
1. Make coffee
2. Beat eggs and sugar
3. Mix mascarpone
4. Layer ingredients
5. Dust with cocoa
6. Chill overnight''',

    'Crème brûlée': '''
Ingredients:
- 2 cups cream
- 4 egg yolks
- 1/4 cup sugar
- Vanilla
- Extra sugar for top
- Berries
- Mint

Preparation:
1. Heat cream
2. Mix eggs and sugar
3. Combine
4. Bake in water bath
5. Chill
6. Caramelize top''',

    'Panna cotta': '''
Ingredients:
- 2 cups cream
- 1/4 cup sugar
- Gelatin
- Vanilla
- Berries
- Mint
- Caramel sauce

Preparation:
1. Heat cream
2. Add gelatin
3. Pour into molds
4. Chill
5. Unmold
6. Add toppings''',

    'Chocolate cake': '''
Ingredients:
- 2 cups flour
- 2 cups sugar
- 3/4 cup cocoa
- 2 eggs
- 1 cup milk
- 1/2 cup oil
- Frosting

Preparation:
1. Mix dry ingredients
2. Combine wet ingredients
3. Bake layers
4. Make frosting
5. Assemble
6. Decorate''',

    'Macarons': '''
Ingredients:
- Almond flour
- Powdered sugar
- Egg whites
- Sugar
- Food coloring
- Filling
- Vanilla

Preparation:
1. Make meringue
2. Fold in dry ingredients
3. Pipe circles
4. Rest
5. Bake
6. Fill and mature''',

    'Fruit tart': '''
Ingredients:
- Pastry dough
- Pastry cream
- Fresh fruits
- Apricot glaze
- Whipped cream
- Mint
- Powdered sugar

Preparation:
1. Bake shell
2. Make cream
3. Fill shell
4. Arrange fruits
5. Glaze
6. Garnish''',

    'Homemade ice cream': '''
Ingredients:
- 2 cups cream
- 1 cup milk
- 3/4 cup sugar
- 4 egg yolks
- Vanilla
- Mix-ins
- Salt

Preparation:
1. Heat dairy
2. Temper eggs
3. Cook custard
4. Chill
5. Churn
6. Add mix-ins''',

    'Cream cupcakes': '''
Ingredients:
- 2 cups flour
- 1 1/2 cups sugar
- 2 eggs
- 1 cup milk
- 1/2 cup butter
- Frosting
- Sprinkles

Preparation:
1. Mix ingredients
2. Fill cupcake tins
3. Bake
4. Cool
5. Frost
6. Decorate''',

    'Chocolate mousse': '''
Ingredients:
- Dark chocolate
- 4 eggs
- 1/4 cup sugar
- Butter
- Whipped cream
- Berries
- Cocoa powder

Preparation:
1. Melt chocolate
2. Separate eggs
3. Fold in whites
4. Add cream
5. Chill
6. Serve with berries''',

    'Carrot cake': '''
Ingredients:
- 2 cups flour
- 2 cups carrots
- 1 cup oil
- 3 eggs
- Spices
- Cream cheese frosting
- Nuts

Preparation:
1. Mix ingredients
2. Bake layers
3. Make frosting
4. Assemble
5. Frost
6. Decorate''',

    'Chocolate truffles': '''
Ingredients:
- Dark chocolate
- Heavy cream
- Butter
- Cocoa powder
- Nuts
- Sea salt
- Vanilla

Preparation:
1. Heat cream
2. Melt chocolate
3. Combine
4. Chill
5. Form balls
6. Coat and decorate''',

    'Apples in batter': '''
Ingredients:
- 4 apples
- 1 cup flour
- 1 egg
- Milk
- Sugar
- Cinnamon
- Oil for frying

Preparation:
1. Slice apples
2. Make batter
3. Heat oil
4. Dip and fry
5. Drain
6. Dust with sugar''',

    'Rice pudding': '''
Ingredients:
- 1 cup rice
- 2 cups milk
- 1/4 cup sugar
- Vanilla
- Cinnamon
- Raisins
- Nutmeg

Preparation:
1. Cook rice
2. Add milk
3. Sweeten
4. Add flavorings
5. Simmer
6. Serve warm''',

    'Waffles with whipped cream': '''
Ingredients:
- 2 cups flour
- 2 eggs
- 1 3/4 cups milk
- 1/2 cup oil
- Whipped cream
- Berries
- Maple syrup

Preparation:
1. Mix batter
2. Heat waffle iron
3. Cook waffles
4. Make whipped cream
5. Add toppings
6. Serve immediately''',

    'Pancakes with Nutella': '''
Ingredients:
- 2 cups flour
- 2 eggs
- 1 1/2 cups milk
- Nutella
- Bananas
- Whipped cream
- Powdered sugar

Preparation:
1. Make batter
2. Cook pancakes
3. Spread Nutella
4. Add bananas
5. Add cream
6. Dust with sugar''',

    'Yogurt cake': '''
Ingredients:
- 2 cups flour
- 1 cup yogurt
- 3 eggs
- 1 cup sugar
- Oil
- Vanilla
- Lemon zest

Preparation:
1. Mix ingredients
2. Pour into pan
3. Bake
4. Cool
5. Glaze
6. Serve''',

    'Meringue with fruits': '''
Ingredients:
- 4 egg whites
- 1 cup sugar
- Vanilla
- Mixed berries
- Whipped cream
- Mint
- Powdered sugar

Preparation:
1. Beat whites
2. Add sugar
3. Pipe shapes
4. Bake
5. Cool
6. Add toppings''',

    'Chocolate fondant': '''
Ingredients:
- Dark chocolate
- Butter
- Eggs
- Sugar
- Flour
- Cocoa powder
- Vanilla

Preparation:
1. Melt chocolate
2. Mix ingredients
3. Fill ramekins
4. Bake
5. Rest
6. Serve warm''',

    'Cream puffs': '''
Ingredients:
- 1 cup water
- 1/2 cup butter
- 1 cup flour
- 4 eggs
- Whipped cream
- Chocolate sauce
- Powdered sugar

Preparation:
1. Make choux
2. Pipe puffs
3. Bake
4. Cool
5. Fill
6. Decorate''',

    'No-bake cheesecake': '''
Ingredients:
- Graham crackers
- Cream cheese
- Whipped cream
- Sugar
- Vanilla
- Berries
- Butter

Preparation:
1. Make crust
2. Mix filling
3. Layer
4. Chill
5. Add toppings
6. Serve cold''',

    'Oatmeal cookies': '''
Ingredients:
- 2 cups oats
- 1 cup flour
- 1 cup butter
- 1 cup sugar
- 2 eggs
- Vanilla
- Chocolate chips

Preparation:
1. Cream butter
2. Add ingredients
3. Form cookies
4. Bake
5. Cool
6. Store''',

    'Lemon tart': '''
Ingredients:
- Pastry dough
- Lemon curd
- Eggs
- Sugar
- Butter
- Whipped cream
- Berries

Preparation:
1. Bake shell
2. Make curd
3. Fill shell
4. Chill
5. Add cream
6. Garnish''',

    'Homemade Raffaello': '''
Ingredients:
- Coconut
- Condensed milk
- Almonds
- White chocolate
- Vanilla
- Powdered sugar
- Coconut oil

Preparation:
1. Mix ingredients
2. Form balls
3. Insert almonds
4. Coat
5. Chill
6. Serve''',

    'Cake with jelly': '''
Ingredients:
- Cake layers
- Jelly powder
- Whipped cream
- Fresh fruits
- Sugar
- Vanilla
- Mint

Preparation:
1. Bake cake
2. Make jelly
3. Layer cake
4. Add jelly
5. Chill
6. Decorate''',

    'Hummus with vegetables': '''
Ingredients:
- 2 cups chickpeas
- 1/4 cup tahini
- 2 cloves garlic
- Lemon juice
- Olive oil
- Fresh vegetables
- Pita bread

Preparation:
1. Blend chickpeas
2. Add tahini
3. Season
4. Drizzle oil
5. Cut vegetables
6. Serve with pita''',

    'Mix of nuts': '''
Ingredients:
- Almonds
- Walnuts
- Cashews
- Pecans
- Hazelnuts
- Dried fruits
- Dark chocolate

Preparation:
1. Roast nuts
2. Cool
3. Mix varieties
4. Add fruits
5. Add chocolate
6. Store airtight''',

    'Smoothie bowl': '''
Ingredients:
- Frozen fruits
- Banana
- Yogurt
- Honey
- Granola
- Berries
- Coconut flakes

Preparation:
1. Blend fruits
2. Add yogurt
3. Sweeten
4. Pour in bowl
5. Add toppings
6. Serve immediately''',

    'Avocado toast': '''
Ingredients:
- Sourdough bread
- Ripe avocado
- Eggs
- Salt
- Pepper
- Red pepper flakes
- Lemon juice

Preparation:
1. Toast bread
2. Mash avocado
3. Season
4. Spread on toast
5. Add eggs
6. Garnish''',

    'Energy balls': '''
Ingredients:
- Dates
- Oats
- Nuts
- Cocoa
- Coconut
- Honey
- Vanilla

Preparation:
1. Process dates
2. Mix ingredients
3. Form balls
4. Roll in coconut
5. Chill
6. Store''',

    'Greek yogurt with honey': '''
Ingredients:
- Greek yogurt
- Honey
- Nuts
- Berries
- Cinnamon
- Granola
- Mint

Preparation:
1. Spoon yogurt
2. Drizzle honey
3. Add nuts
4. Add berries
5. Sprinkle cinnamon
6. Garnish''',

    'Vegetable chips': '''
Ingredients:
- Sweet potatoes
- Beets
- Zucchini
- Olive oil
- Salt
- Herbs
- Pepper

Preparation:
1. Slice vegetables
2. Season
3. Arrange on tray
4. Bake
5. Cool
6. Store airtight''',

    'Fruit salad': '''
Ingredients:
- Mixed fruits
- Honey
- Mint
- Lime juice
- Coconut
- Nuts
- Yogurt

Preparation:
1. Cut fruits
2. Mix in bowl
3. Add honey
4. Add lime
5. Top with nuts
6. Serve chilled''',

    'Popcorn with spices': '''
Ingredients:
- Popcorn kernels
- Butter
- Salt
- Paprika
- Garlic powder
- Cayenne
- Herbs

Preparation:
1. Pop corn
2. Melt butter
3. Add spices
4. Toss
5. Season
6. Serve warm''',

    'Rice cakes with toppings': '''
Ingredients:
- Rice cakes
- Avocado
- Hummus
- Nut butter
- Bananas
- Berries
- Honey

Preparation:
1. Choose base
2. Add spread
3. Add toppings
4. Drizzle honey
5. Stack
6. Serve''',

    'Trail mix': '''
Ingredients:
- Nuts
- Seeds
- Dried fruits
- Dark chocolate
- Coconut
- Granola
- Spices

Preparation:
1. Mix nuts
2. Add seeds
3. Add fruits
4. Add chocolate
5. Season
6. Store''',

    'Cucumber rolls': '''
Ingredients:
- Cucumber
- Cream cheese
- Smoked salmon
- Dill
- Lemon
- Salt
- Pepper

Preparation:
1. Slice cucumber
2. Spread cheese
3. Add salmon
4. Roll
5. Season
6. Serve chilled''',

    'Apple with peanut butter': '''
Ingredients:
- Apple
- Peanut butter
- Honey
- Cinnamon
- Nuts
- Raisins
- Granola

Preparation:
1. Slice apple
2. Spread butter
3. Drizzle honey
4. Add toppings
5. Sprinkle cinnamon
6. Serve''',

    'Carrot sticks with dip': '''
Ingredients:
- Carrots
- Greek yogurt
- Herbs
- Garlic
- Lemon
- Salt
- Pepper

Preparation:
1. Cut carrots
2. Mix dip
3. Season
4. Chill
5. Arrange
6. Serve''',

    'Dark chocolate with nuts': '''
Ingredients:
- Dark chocolate
- Mixed nuts
- Sea salt
- Dried fruits
- Coconut
- Vanilla
- Cinnamon

Preparation:
1. Melt chocolate
2. Add nuts
3. Add fruits
4. Season
5. Pour
6. Chill''',

    'Banana with cinnamon': '''
Ingredients:
- Banana
- Cinnamon
- Honey
- Nuts
- Yogurt
- Berries
- Granola

Preparation:
1. Slice banana
2. Sprinkle cinnamon
3. Drizzle honey
4. Add nuts
5. Add yogurt
6. Top with berries''',

    'Cottage cheese with fruits': '''
Ingredients:
- Cottage cheese
- Mixed berries
- Honey
- Nuts
- Cinnamon
- Mint
- Granola

Preparation:
1. Spoon cheese
2. Add fruits
3. Drizzle honey
4. Add nuts
5. Season
6. Garnish''',

    'Celery with cream cheese': '''
Ingredients:
- Celery stalks
- Cream cheese
- Raisins
- Nuts
- Salt
- Pepper
- Herbs

Preparation:
1. Cut celery
2. Fill with cheese
3. Add raisins
4. Add nuts
5. Season
6. Serve''',

    'Rice paper rolls': '''
Ingredients:
- Rice paper
- Vegetables
- Rice noodles
- Herbs
- Peanut sauce
- Mint
- Lime

Preparation:
1. Soak paper
2. Fill with ingredients
3. Roll
4. Cut
5. Make sauce
6. Serve''',

    'Baked chickpeas': '''
Ingredients:
- Chickpeas
- Olive oil
- Spices
- Salt
- Garlic
- Herbs
- Lemon

Preparation:
1. Drain chickpeas
2. Season
3. Bake
4. Toss
5. Cool
6. Store''',

    'Fruit kebabs': '''
Ingredients:
- Mixed fruits
- Honey
- Yogurt
- Mint
- Coconut
- Nuts
- Cinnamon

Preparation:
1. Cut fruits
2. Thread on skewers
3. Drizzle honey
4. Add yogurt
5. Garnish
6. Serve''',

    'Avocado dip': '''
Ingredients:
- Avocado
- Greek yogurt
- Lime
- Garlic
- Herbs
- Salt
- Pepper

Preparation:
1. Mash avocado
2. Mix yogurt
3. Add lime
4. Season
5. Chill
6. Serve''',

    'Nut butter on crackers': '''
Ingredients:
- Crackers
- Nut butter
- Honey
- Bananas
- Berries
- Cinnamon
- Nuts

Preparation:
1. Spread butter
2. Add fruit
3. Drizzle honey
4. Add nuts
5. Season
6. Serve''',

    'Vegetable sticks with hummus': '''
Ingredients:
- Mixed vegetables
- Hummus
- Olive oil
- Herbs
- Salt
- Pepper
- Lemon

Preparation:
1. Cut vegetables
2. Make hummus
3. Season
4. Arrange
5. Drizzle oil
6. Serve''',

    'Fruit and nut bars': '''
Ingredients:
- Dates
- Nuts
- Seeds
- Dried fruits
- Honey
- Vanilla
- Cinnamon

Preparation:
1. Process dates
2. Mix ingredients
3. Press in pan
4. Chill
5. Cut
6. Store''',

    'Cucumber sandwiches': '''
Ingredients:
- Cucumber
- Bread
- Cream cheese
- Dill
- Salt
- Pepper
- Lemon

Preparation:
1. Slice cucumber
2. Spread cheese
3. Layer
4. Season
5. Cut
6. Serve''',

    'Apple chips': '''
Ingredients:
- Apples
- Cinnamon
- Sugar
- Lemon
- Salt
- Nutmeg
- Vanilla

Preparation:
1. Slice apples
2. Season
3. Arrange
4. Bake
5. Cool
6. Store''',

    'Steak with fries': '''
Ingredients:
- Ribeye steak
- Potatoes
- Butter
- Garlic
- Herbs
- Salt
- Pepper

Preparation:
1. Season steak
2. Cut potatoes
3. Heat pan
4. Cook steak
5. Make fries
6. Rest and serve''',

    'Shrimp risotto': '''
Ingredients:
- Arborio rice
- Shrimp
- White wine
- Onion
- Parmesan
- Butter
- Herbs

Preparation:
1. Sauté onion
2. Toast rice
3. Add wine
4. Add stock
5. Add shrimp
6. Finish with cheese''',

    'Chocolate fondue': '''
Ingredients:
- Dark chocolate
- Heavy cream
- Butter
- Vanilla
- Fruits
- Marshmallows
- Cookies

Preparation:
1. Heat cream
2. Melt chocolate
3. Add butter
4. Add vanilla
5. Prepare dippers
6. Serve warm''',

    'Wine and cheese board': '''
Ingredients:
- Assorted cheeses
- Red wine
- Crackers
- Fruits
- Nuts
- Honey
- Herbs

Preparation:
1. Select cheeses
2. Choose wine
3. Arrange board
4. Add accompaniments
5. Garnish
6. Serve at room temperature''',

    'Candlelit dinner': '''
Ingredients:
- Main course
- Side dishes
- Wine
- Candles
- Flowers
- Music
- Dessert

Preparation:
1. Set table
2. Light candles
3. Prepare food
4. Pour wine
5. Add music
6. Enjoy together''',

    'Romantic picnic': '''
Ingredients:
- Sandwiches
- Wine
- Cheese
- Fruits
- Chocolate
- Blanket
- Flowers

Preparation:
1. Pack food
2. Choose location
3. Set blanket
4. Arrange food
5. Add flowers
6. Enjoy outdoors''',

    'Homemade pizza': '''
Ingredients:
- Pizza dough
- Tomato sauce
- Mozzarella
- Toppings
- Herbs
- Olive oil
- Garlic

Preparation:
1. Make dough
2. Prepare sauce
3. Add toppings
4. Bake
5. Garnish
6. Serve hot''',

    'Sushi night': '''
Ingredients:
- Sushi rice
- Nori
- Fish
- Vegetables
- Soy sauce
- Wasabi
- Ginger

Preparation:
1. Cook rice
2. Prepare fillings
3. Roll sushi
4. Cut pieces
5. Arrange
6. Serve with condiments''',

    'Tapas evening': '''
Ingredients:
- Olives
- Cheese
- Ham
- Bread
- Wine
- Nuts
- Fruits

Preparation:
1. Select tapas
2. Arrange plates
3. Pour wine
4. Set table
5. Add music
6. Enjoy together''',

    'Cooking together': '''
Ingredients:
- Recipe ingredients
- Wine
- Music
- Candles
- Flowers
- Dessert
- Love

Preparation:
1. Choose recipe
2. Set mood
3. Cook together
4. Share wine
5. Enjoy meal
6. Clean up together''',

    'Wine tasting': '''
Ingredients:
- Red wines
- White wines
- Cheese
- Bread
- Chocolate
- Fruits
- Notes

Preparation:
1. Select wines
2. Prepare food
3. Set glasses
4. Take notes
5. Discuss
6. Enjoy together''',

    'Chocolate tasting': '''
Ingredients:
- Dark chocolate
- Milk chocolate
- White chocolate
- Wine
- Coffee
- Nuts
- Fruits

Preparation:
1. Select chocolates
2. Prepare pairings
3. Set plates
4. Take notes
5. Discuss
6. Enjoy together''',

    'Movie night': '''
Ingredients:
- Popcorn
- Wine
- Chocolate
- Blanket
- Movie
- Snacks
- Candles

Preparation:
1. Choose movie
2. Make popcorn
3. Pour wine
4. Set mood
5. Get cozy
6. Enjoy together''',

    'Game night': '''
Ingredients:
- Board games
- Wine
- Snacks
- Music
- Candles
- Dessert
- Fun

Preparation:
1. Select games
2. Prepare snacks
3. Pour wine
4. Set mood
5. Play games
6. Enjoy together''',

    'Dance night': '''
Ingredients:
- Music
- Wine
- Snacks
- Candles
- Flowers
- Dessert
- Love

Preparation:
1. Choose music
2. Set mood
3. Pour wine
4. Light candles
5. Dance
6. Enjoy together''',

    'Stargazing': '''
Ingredients:
- Blanket
- Wine
- Snacks
- Telescope
- Music
- Chocolate
- Love

Preparation:
1. Find location
2. Set blanket
3. Pour wine
4. Set telescope
5. Add music
6. Enjoy together''',

    'Beach date': '''
Ingredients:
- Picnic basket
- Wine
- Sandwiches
- Fruits
- Blanket
- Music
- Love

Preparation:
1. Pack basket
2. Choose spot
3. Set blanket
4. Pour wine
5. Add music
6. Enjoy together''',

    'Hiking date': '''
Ingredients:
- Trail mix
- Water
- Sandwiches
- Fruits
- Camera
- Map
- Love

Preparation:
1. Choose trail
2. Pack food
3. Check weather
4. Start hike
5. Take photos
6. Enjoy together''',

    'Museum date': '''
Ingredients:
- Tickets
- Guide
- Camera
- Snacks
- Water
- Map
- Love

Preparation:
1. Choose museum
2. Buy tickets
3. Get guide
4. Take photos
5. Discuss art
6. Enjoy together''',

    'Concert date': '''
Ingredients:
- Tickets
- Wine
- Snacks
- Camera
- Program
- Flowers
- Love

Preparation:
1. Choose concert
2. Buy tickets
3. Dress up
4. Arrive early
5. Enjoy music
6. Celebrate together''',

    'Theater date': '''
Ingredients:
- Tickets
- Wine
- Snacks
- Program
- Flowers
- Camera
- Love

Preparation:
1. Choose show
2. Buy tickets
3. Dress up
4. Arrive early
5. Enjoy show
6. Discuss together''',

    'Cooking class': '''
Ingredients:
- Recipe
- Ingredients
- Wine
- Aprons
- Music
- Camera
- Love

Preparation:
1. Choose class
2. Book spots
3. Dress up
4. Learn together
5. Cook together
6. Enjoy meal''',

    'Wine tour': '''
Ingredients:
- Tour tickets
- Camera
- Snacks
- Water
- Map
- Notes
- Love

Preparation:
1. Choose winery
2. Book tour
3. Dress up
4. Take photos
5. Taste wine
6. Enjoy together''',

    'Boat ride': '''
Ingredients:
- Tickets
- Wine
- Snacks
- Camera
- Map
- Sunscreen
- Love

Preparation:
1. Choose route
2. Buy tickets
3. Pack food
4. Take photos
5. Enjoy ride
6. Celebrate together''',

    'Hot air balloon': '''
Ingredients:
- Tickets
- Camera
- Snacks
- Water
- Map
- Jacket
- Love

Preparation:
1. Book flight
2. Dress warmly
3. Take photos
4. Enjoy view
5. Celebrate
6. Toast together''',

    'Spa day': '''
Ingredients:
- Spa package
- Robes
- Wine
- Snacks
- Music
- Candles
- Love

Preparation:
1. Book spa
2. Dress comfortably
3. Relax together
4. Enjoy treatments
5. Share wine
6. Celebrate together''',

    'Sunset dinner': '''
Ingredients:
- Main course
- Wine
- Candles
- Flowers
- Music
- Dessert
- Love

Preparation:
1. Choose location
2. Set table
3. Prepare food
4. Pour wine
5. Watch sunset
6. Enjoy together''',
  };

  // Get recipe for a specific meal
  static String? getRecipe(String mealName) {
    return recipes[mealName];
  }
} 