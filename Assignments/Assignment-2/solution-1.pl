recommend(Abroad, Purpose, _, _, Places):-
    (Abroad == 'yes', Purpose == 'business',
         Places = '1. New York, USA \n2. London, UK \n3. Mexico City, Mexico').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'yes', Purpose \== 'business', Terrain == 'lakes', Weather == 'hot',
         Places = '1. Blue Lagoon, Iceland \n2. Palia Kameni, Greece \n3. Pantelleria, Italy').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'yes', Purpose \== 'business', Terrain == 'lakes', Weather == 'cool',
         Places = '1. Hallstatt, Austria \n2. Interlaken, Switzerland \n3. Barcelona, Spain').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'yes', Purpose \== 'business', Terrain == 'mountains', Weather == 'hot',
         Places = '1. Basque Highlands, Spain \n2. Central Valley, Costa Rica \n3. Morocco, Africa').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'yes', Purpose \== 'business', Terrain == 'mountains', Weather == 'cool',
         Places = '1. Hallstatt, Austria \n2. Wengen, Switzerland \n3. Fairbanks, Alaska').

recommend(Abroad, Purpose, Terrain, _, Places):-
    (Abroad == 'yes', Purpose \== 'business', Terrain == 'beaches',
         Places = '1. Palawan, Philippines \n2. Glass Beach, California \n3. Starfish Beach, Panama').

recommend(Abroad, Purpose, _, _, Places):-
    (Abroad == 'no', Purpose == 'business',
         Places = '1. Bangalore, Karnataka \n2. Mumbai, Maharashtra \n3. Kolkata, West Bengal').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'no', Purpose \== 'business', Terrain == 'lakes', Weather == 'hot',
         Places = '1. Venna Lake, Maharashtra \n2. Chilika, Orissa \n3. Upper Lake, Madhya Pradesh').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'no', Purpose \== 'business', Terrain == 'lakes', Weather == 'cool',
         Places = '1. Dal Lake, J&K \n2. Tsomgo Lake, Sikkim \n3. Lake Pichola, Udaipur').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'no', Purpose \== 'business', Terrain == 'mountains', Weather == 'hot',
         Places = '1. Arma Konda, Andhra Pradesh \n2. Nilgiri Hills, Tamil Nadu \n3. Anamudi, Kerala').

recommend(Abroad, Purpose, Terrain, Weather, Places):-
    (Abroad == 'no', Purpose \== 'business', Terrain == 'mountains', Weather == 'cool',
         Places = '1. Auli, Haryana \n2. Nainital, Uttarakhand \n3. Shimla, Himachal Pradesh').

recommend(Abroad, Purpose, Terrain, _, Places):-
    (Abroad == 'no', Purpose \== 'business', Terrain == 'beaches',
         Places = '1. Butterfly Beach, Goa \n2. Kovalam Beach, Kerala \n3. Om Beach, Karnataka').

main:-
    write('Welcome to Travel Recommendation System!'), nl,

    write('Enter your Name: '),
    read(Name), nl,
    
    write('Hello '), write(Name), write('!'), nl,
    
    write('Enter your Age: '),
    read(Age), nl,

    (
        Age =< 12 ->
            write('You should visit one of the following places:'), nl,
            write('1. DisneyLand, California, Paris, or Hong Kong!'), nl,
            write('2. Any monument!'), nl
        ;

        /* ELSE */
            write('Please answer the following questions:'), nl,

            write('What is your purpose (business / family / couple / friends): '),
            read(Purpose), nl,

            write('Do you want to go Abroad (yes / no): '),
            read(Abroad), nl,

            write('What terrain do you like (lakes / mountains / beaches): '),
            read(Terrain), nl,

            write('What is your preferred weather (hot / cool): '),
            read(Weather), nl,

            write('Please wait while the system searches for the best recommendations for you!'), nl, nl,

            recommend(Abroad, Purpose, Terrain, Weather, Places),

            write('According to the recommendation system, you should visit:'), nl,
            write(Places)
    ).
