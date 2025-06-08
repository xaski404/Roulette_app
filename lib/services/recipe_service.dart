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
- 1 can chickpeas
- 2 tbsp tahini
- 2 cloves garlic
- 1 lemon
- 3 tbsp olive oil
- Salt to taste
- Assorted vegetables (carrots, cucumber, bell peppers)

Preparation:
1. Drain and rinse chickpeas
2. Blend chickpeas, tahini, garlic, and lemon juice
3. Add olive oil gradually
4. Season with salt
5. Serve with fresh vegetables
6. Drizzle with olive oil''',

    'Nut mix': '''
Ingredients:
- Almonds
- Walnuts
- Cashews
- Pumpkin seeds
- Sunflower seeds
- Dried fruits (optional)
- Dark chocolate chips (optional)

Preparation:
1. Mix all nuts and seeds
2. Add dried fruits if desired
3. Add chocolate chips if desired
4. Store in an airtight container
5. Serve in small portions
6. Can be toasted for extra flavor''',

    'Fruit smoothie': '''
Ingredients:
- 1 banana
- 1 cup mixed berries
- 1 cup milk or yogurt
- 1 tbsp honey
- Ice cubes
- Optional: protein powder

Preparation:
1. Add all ingredients to blender
2. Blend until smooth
3. Add more liquid if too thick
4. Taste and adjust sweetness
5. Pour into a glass
6. Serve immediately''',

    'Egg salad sandwich': '''
Ingredients:
- 4 hard-boiled eggs
- 2 tbsp mayonnaise
- 1 tsp mustard
- Salt and pepper
- Fresh herbs
- Bread slices

Preparation:
1. Chop hard-boiled eggs
2. Mix with mayonnaise and mustard
3. Season with salt and pepper
4. Add chopped herbs
5. Spread on bread
6. Cut and serve''',

    'Seasonal fruits': '''
Ingredients:
- Assorted seasonal fruits
- Mint leaves
- Honey (optional)
- Lime juice (optional)

Preparation:
1. Wash and cut fruits
2. Arrange in a bowl
3. Add mint leaves
4. Drizzle with honey if desired
5. Add lime juice if desired
6. Serve chilled''',

    // Date night recipes
    'Steak with fries': '''
Ingredients:
- 2 beef steaks
- 4 large potatoes
- 2 tbsp olive oil
- Salt and pepper
- Fresh herbs
- Garlic butter

Preparation:
1. Season steaks with salt and pepper
2. Cut potatoes into fries
3. Heat oil in a pan
4. Cook steaks to desired doneness
5. Fry potatoes until crispy
6. Serve with garlic butter''',

    'Shrimp risotto': '''
Ingredients:
- 1 cup Arborio rice
- 200g shrimp
- 1 onion
- 2 cloves garlic
- 1/2 cup white wine
- 4 cups chicken stock
- Parmesan cheese
- Fresh herbs

Preparation:
1. Sauté onion and garlic
2. Add rice and toast
3. Pour in wine
4. Add hot stock gradually
5. Cook shrimp separately
6. Finish with cheese and herbs''',

    'Pasta carbonara': '''
Ingredients:
- 400g spaghetti
- 200g pancetta
- 4 egg yolks
- 1 cup Parmesan
- Black pepper
- Fresh parsley

Preparation:
1. Cook pasta
2. Fry pancetta until crispy
3. Mix egg yolks and cheese
4. Combine hot pasta with egg mixture
5. Add pancetta and pepper
6. Garnish with parsley''',

    'Sushi': '''
Ingredients:
- 2 cups sushi rice
- Nori sheets
- Fresh fish
- Cucumber
- Avocado
- Soy sauce
- Wasabi

Preparation:
1. Cook and season rice
2. Prepare fish and vegetables
3. Place nori on bamboo mat
4. Spread rice evenly
5. Add fillings
6. Roll and slice''',

    'Cheese fondue': '''
Ingredients:
- 400g mixed cheeses
- 1 clove garlic
- 1 cup white wine
- 1 tbsp cornstarch
- Bread cubes
- Vegetables

Preparation:
1. Rub pot with garlic
2. Heat wine
3. Add cheese gradually
4. Thicken with cornstarch
5. Keep warm
6. Serve with dippers''',

    'Tapas': '''
Ingredients:
- Olives
- Manchego cheese
- Chorizo
- Patatas bravas
- Garlic shrimp
- Bread

Preparation:
1. Prepare each component
2. Arrange on small plates
3. Serve at room temperature
4. Include bread
5. Add wine pairing
6. Enjoy sharing style''',

    'Duck in orange sauce': '''
Ingredients:
- 2 duck breasts
- 2 oranges
- 1 cup chicken stock
- 2 tbsp honey
- Fresh herbs
- Salt and pepper

Preparation:
1. Score duck skin
2. Cook skin-side down
3. Make orange sauce
4. Rest duck
5. Slice and serve
6. Pour sauce over''',

    'Seafood in wine': '''
Ingredients:
- Mixed seafood
- 1 cup white wine
- 2 cloves garlic
- Fresh herbs
- Butter
- Lemon

Preparation:
1. Clean seafood
2. Sauté garlic
3. Add wine
4. Cook seafood
5. Add butter
6. Finish with herbs''',

    'Truffle ravioli': '''
Ingredients:
- Fresh pasta sheets
- Truffle
- Ricotta cheese
- Egg
- Butter
- Parmesan

Preparation:
1. Make pasta dough
2. Prepare filling
3. Form ravioli
4. Cook in boiling water
5. Toss with butter
6. Garnish with truffle''',

    'Beef tartare': '''
Ingredients:
- 400g beef fillet
- 1 shallot
- Capers
- Dijon mustard
- Egg yolk
- Toast

Preparation:
1. Finely chop beef
2. Mix with seasonings
3. Shape into patties
4. Top with egg yolk
5. Serve with toast
6. Add condiments''',

    'Shrimp tempura': '''
Ingredients:
- 500g shrimp
- Tempura batter
- Vegetable oil
- Dipping sauce
- Green onions
- Sesame seeds

Preparation:
1. Clean shrimp
2. Make batter
3. Heat oil
4. Fry until crispy
5. Drain well
6. Serve with sauce''',

    'Duck breast': '''
Ingredients:
- 2 duck breasts
- Salt and pepper
- Fresh herbs
- 1 cup red wine
- 2 tbsp honey
- Orange

Preparation:
1. Score skin
2. Season well
3. Cook skin-side down
4. Make sauce
5. Rest meat
6. Slice and serve''',

    'Grilled lobster': '''
Ingredients:
- 2 live lobsters
- Butter
- Garlic
- Lemon
- Fresh herbs
- Salt and pepper

Preparation:
1. Clean lobsters
2. Split in half
3. Season well
4. Grill flesh-side down
5. Baste with butter
6. Serve with lemon''',

    'Saffron risotto': '''
Ingredients:
- 1 cup Arborio rice
- Pinch of saffron
- 1 onion
- 4 cups stock
- 1/2 cup white wine
- Parmesan

Preparation:
1. Toast rice
2. Add wine
3. Infuse saffron
4. Add hot stock
5. Finish with cheese
6. Rest before serving''',

    'Beef carpaccio': '''
Ingredients:
- 400g beef fillet
- Olive oil
- Lemon juice
- Parmesan
- Arugula
- Truffle oil

Preparation:
1. Freeze beef
2. Slice very thin
3. Arrange on plate
4. Drizzle with oil
5. Add shaved cheese
6. Garnish with arugula''',

    'Mussels in wine sauce': '''
Ingredients:
- 1kg mussels
- 1 cup white wine
- 2 shallots
- Garlic
- Fresh herbs
- Butter

Preparation:
1. Clean mussels
2. Sauté aromatics
3. Add wine
4. Steam mussels
5. Add butter
6. Serve with bread''',

    'Beef wellington': '''
Ingredients:
- 1 beef fillet
- Puff pastry
- Mushroom duxelles
- Prosciutto
- Egg wash
- Fresh herbs

Preparation:
1. Sear beef
2. Make duxelles
3. Wrap in prosciutto
4. Encase in pastry
5. Egg wash
6. Bake until golden''',

    'Tagliata with arugula': '''
Ingredients:
- 2 beef steaks
- Arugula
- Parmesan
- Balsamic
- Olive oil
- Cherry tomatoes

Preparation:
1. Cook steaks
2. Slice against grain
3. Arrange on arugula
4. Add shaved cheese
5. Drizzle with oil
6. Add balsamic''',

    'Oysters': '''
Ingredients:
- 12 fresh oysters
- Mignonette sauce
- Lemon
- Tabasco
- Fresh herbs
- Ice

Preparation:
1. Clean oysters
2. Prepare sauce
3. Shuck carefully
4. Arrange on ice
5. Add condiments
6. Serve immediately''',

    'Gnocchi with sage': '''
Ingredients:
- 500g gnocchi
- Fresh sage
- Butter
- Parmesan
- Nutmeg
- Salt and pepper

Preparation:
1. Cook gnocchi
2. Brown butter
3. Add sage
4. Toss gnocchi
5. Add cheese
6. Season well''',

    'Grilled octopus': '''
Ingredients:
- 1 octopus
- Olive oil
- Garlic
- Lemon
- Fresh herbs
- Potatoes

Preparation:
1. Tenderize octopus
2. Cook until tender
3. Grill until charred
4. Slice tentacles
5. Serve with potatoes
6. Drizzle with oil''',

    'Tomahawk steak': '''
Ingredients:
- 1 tomahawk steak
- Salt and pepper
- Garlic
- Butter
- Fresh herbs
- Olive oil

Preparation:
1. Season well
2. Bring to room temperature
3. Sear all sides
4. Add aromatics
5. Rest properly
6. Slice and serve''',

    'Seafood linguine': '''
Ingredients:
- 400g linguine
- Mixed seafood
- Garlic
- White wine
- Fresh herbs
- Cherry tomatoes

Preparation:
1. Cook pasta
2. Sauté seafood
3. Add wine
4. Combine with pasta
5. Add herbs
6. Finish with oil''',

    'Tuna tartare': '''
Ingredients:
- 400g tuna
- Avocado
- Soy sauce
- Sesame oil
- Green onions
- Wonton crisps

Preparation:
1. Dice tuna
2. Mix with seasonings
3. Prepare avocado
4. Layer ingredients
5. Add garnishes
6. Serve with crisps''',

    'Foie gras': '''
Ingredients:
- 200g foie gras
- Balsamic reduction
- Fresh figs
- Toast
- Salt and pepper
- Honey

Preparation:
1. Score foie gras
2. Season well
3. Sear quickly
4. Rest briefly
5. Slice and serve
6. Add accompaniments''',

    'Seafood paella': '''
Ingredients:
- 2 cups rice
- Mixed seafood
- Saffron
- Peas
- Bell peppers
- Fish stock

Preparation:
1. Toast rice
2. Add saffron
3. Add hot stock
4. Add seafood
5. Add vegetables
6. Rest before serving''',

    'BBQ ribs': '''
Ingredients:
- 2 racks ribs
- BBQ sauce
- Spice rub
- Apple juice
- Garlic
- Fresh herbs

Preparation:
1. Apply rub
2. Slow cook
3. Baste with sauce
4. Add juice
5. Finish on grill
6. Rest and serve''',

    'Sashimi mix': '''
Ingredients:
- Fresh fish
- Soy sauce
- Wasabi
- Pickled ginger
- Green onions
- Sesame seeds

Preparation:
1. Slice fish
2. Arrange on plate
3. Add garnishes
4. Serve with soy
5. Add wasabi
6. Include ginger''',

    'Beef bourguignon': '''
Ingredients:
- 1kg beef
- Red wine
- Pearl onions
- Mushrooms
- Bacon
- Fresh herbs

Preparation:
1. Brown beef
2. Add wine
3. Slow cook
4. Add vegetables
5. Reduce sauce
6. Serve with potatoes''',

    'Shrimp tempura': '''
Ingredients:
- 500g shrimp
- Tempura batter
- Vegetable oil
- Dipping sauce
- Green onions
- Sesame seeds

Preparation:
1. Clean shrimp
2. Make batter
3. Heat oil
4. Fry until crispy
5. Drain well
6. Serve with sauce''',

    'Vegetable chips': '''
Ingredients:
- Assorted vegetables (carrots, zucchini, sweet potatoes)
- Olive oil
- Salt and pepper
- Herbs (optional)
- Garlic powder (optional)

Preparation:
1. Slice vegetables thinly
2. Toss with olive oil
3. Season with salt and pepper
4. Add herbs if desired
5. Bake until crispy
6. Let cool before serving''',

    'Guacamole with nachos': '''
Ingredients:
- 2 ripe avocados
- 1 lime
- 1 small onion
- 1 tomato
- Fresh cilantro
- Tortilla chips
- Salt and pepper

Preparation:
1. Mash avocados
2. Dice onion and tomato
3. Mix with lime juice
4. Add chopped cilantro
5. Season to taste
6. Serve with nachos''',

    'Yogurt with granola': '''
Ingredients:
- Greek yogurt
- Homemade granola
- Honey
- Fresh fruits
- Nuts (optional)
- Cinnamon (optional)

Preparation:
1. Spoon yogurt into bowl
2. Add granola
3. Drizzle with honey
4. Top with fruits
5. Add nuts if desired
6. Sprinkle with cinnamon''',

    'Dried fruits': '''
Ingredients:
- Assorted dried fruits
- Nuts (optional)
- Dark chocolate (optional)
- Coconut flakes (optional)
- Cinnamon (optional)

Preparation:
1. Mix dried fruits
2. Add nuts if desired
3. Add chocolate if desired
4. Add coconut if desired
5. Sprinkle with cinnamon
6. Store in airtight container''',

    'Avocado sandwich': '''
Ingredients:
- 2 slices bread
- 1 ripe avocado
- Lemon juice
- Salt and pepper
- Microgreens
- Olive oil

Preparation:
1. Toast bread
2. Mash avocado
3. Add lemon juice
4. Season to taste
5. Spread on bread
6. Top with microgreens''',

    'Energy bars': '''
Ingredients:
- Oats
- Nuts and seeds
- Dried fruits
- Honey
- Nut butter
- Dark chocolate

Preparation:
1. Mix dry ingredients
2. Heat honey and nut butter
3. Combine mixtures
4. Press into pan
5. Add chocolate
6. Refrigerate until set''',

    'Fruit salad': '''
Ingredients:
- Seasonal fruits
- Mint leaves
- Honey
- Lime juice
- Fresh berries
- Coconut flakes

Preparation:
1. Cut fruits
2. Mix in bowl
3. Add mint
4. Drizzle with honey
5. Add lime juice
6. Top with berries''',

    'Homemade popcorn': '''
Ingredients:
- Popcorn kernels
- Olive oil
- Salt
- Butter (optional)
- Herbs (optional)
- Nutritional yeast (optional)

Preparation:
1. Heat oil in pan
2. Add kernels
3. Cover and shake
4. Season with salt
5. Add butter if desired
6. Add toppings''',

    'Mini vegetable wraps': '''
Ingredients:
- Tortillas
- Hummus
- Fresh vegetables
- Avocado
- Sprouts
- Lemon juice

Preparation:
1. Spread hummus
2. Add vegetables
3. Add avocado
4. Add sprouts
5. Roll tightly
6. Cut into pieces''',

    'Protein shake': '''
Ingredients:
- Protein powder
- Milk or water
- Banana
- Berries
- Nut butter
- Ice cubes

Preparation:
1. Add liquid to blender
2. Add protein powder
3. Add fruits
4. Add nut butter
5. Add ice
6. Blend until smooth''',

    'Apple chips': '''
Ingredients:
- Apples
- Cinnamon
- Sugar (optional)
- Lemon juice
- Nutmeg (optional)
- Salt

Preparation:
1. Slice apples thinly
2. Toss with lemon juice
3. Add cinnamon
4. Add sugar if desired
5. Bake until crispy
6. Let cool''',

    'Student mix': '''
Ingredients:
- Cereal
- Pretzels
- Nuts
- Dried fruits
- Chocolate chips
- Seeds

Preparation:
1. Mix all ingredients
2. Store in container
3. Portion as needed
4. Can be customized
5. Keep in cool place
6. Enjoy as snack''',

    'Cheese crackers': '''
Ingredients:
- Cheese
- Flour
- Butter
- Herbs
- Salt
- Pepper

Preparation:
1. Mix ingredients
2. Roll out dough
3. Cut into shapes
4. Bake until golden
5. Let cool
6. Store in container''',

    'Smoothie bowl': '''
Ingredients:
- Frozen fruits
- Milk or yogurt
- Toppings
- Honey
- Nuts
- Seeds

Preparation:
1. Blend fruits
2. Add liquid
3. Pour into bowl
4. Add toppings
5. Drizzle honey
6. Add nuts and seeds''',

    'Chickpea spread': '''
Ingredients:
- Chickpeas
- Tahini
- Garlic
- Lemon
- Olive oil
- Herbs

Preparation:
1. Blend chickpeas
2. Add tahini
3. Add garlic
4. Add lemon
5. Add oil
6. Season with herbs''',

    'Honey nuts': '''
Ingredients:
- Mixed nuts
- Honey
- Cinnamon
- Salt
- Vanilla
- Butter

Preparation:
1. Toast nuts
2. Heat honey
3. Add spices
4. Coat nuts
5. Let cool
6. Break into pieces''',

    'Vegetables with dip': '''
Ingredients:
- Assorted vegetables
- Greek yogurt
- Herbs
- Garlic
- Lemon
- Salt and pepper

Preparation:
1. Cut vegetables
2. Mix yogurt
3. Add herbs
4. Add garlic
5. Add lemon
6. Season to taste''',

    'Energy balls': '''
Ingredients:
- Dates
- Nuts
- Oats
- Cocoa powder
- Coconut
- Seeds

Preparation:
1. Process dates
2. Add nuts
3. Add oats
4. Add cocoa
5. Roll into balls
6. Coat with coconut''',

    'Hummus toast': '''
Ingredients:
- Bread
- Hummus
- Vegetables
- Olive oil
- Herbs
- Seeds

Preparation:
1. Toast bread
2. Spread hummus
3. Add vegetables
4. Drizzle oil
5. Add herbs
6. Top with seeds''',

    'Banana chips': '''
Ingredients:
- Bananas
- Lemon juice
- Cinnamon
- Honey
- Salt
- Oil

Preparation:
1. Slice bananas
2. Toss with lemon
3. Add cinnamon
4. Add honey
5. Bake until crispy
6. Let cool''',

    'Quinoa salad': '''
Ingredients:
- Cooked quinoa
- Vegetables
- Herbs
- Lemon
- Olive oil
- Nuts

Preparation:
1. Cook quinoa
2. Add vegetables
3. Add herbs
4. Add lemon
5. Add oil
6. Top with nuts''',

    'Savory muffins': '''
Ingredients:
- Flour
- Cheese
- Vegetables
- Eggs
- Milk
- Herbs

Preparation:
1. Mix dry ingredients
2. Add wet ingredients
3. Add vegetables
4. Add cheese
5. Bake until done
6. Let cool''',

    'Tortilla rolls': '''
Ingredients:
- Tortillas
- Cream cheese
- Vegetables
- Herbs
- Salt
- Pepper

Preparation:
1. Spread cream cheese
2. Add vegetables
3. Add herbs
4. Roll tightly
5. Cut into pieces
6. Serve immediately''',

    'Chocolate-covered dried fruits': '''
Ingredients:
- Dried fruits
- Dark chocolate
- Nuts (optional)
- Sea salt
- Coconut (optional)
- Vanilla

Preparation:
1. Melt chocolate
2. Dip fruits
3. Add toppings
4. Add salt
5. Let set
6. Store properly''',

    'Mini sandwiches': '''
Ingredients:
- Bread
- Various fillings
- Butter
- Herbs
- Vegetables
- Cheese

Preparation:
1. Cut bread
2. Add fillings
3. Add vegetables
4. Add cheese
5. Cut into pieces
6. Arrange on plate''',
  };

  // Get recipe for a specific meal
  static String? getRecipe(String mealName) {
    return recipes[mealName];
  }
} 