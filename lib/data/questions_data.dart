import '../models/question.dart';

class QuestionsData {
  static List<Question> _cultureGenerale = [
    Question(id: 'cg1', category: '1', question: 'Quelle est la capitale de la France ?', answers: ['Lyon', 'Paris', 'Marseille', 'Toulouse'], correctAnswerIndex: 1),
    Question(id: 'cg2', category: '1', question: 'Combien de continents y a-t-il sur Terre ?', answers: ['5', '6', '7', '8'], correctAnswerIndex: 2),
    Question(id: 'cg3', category: '1', question: 'Quel est le plus grand océan du monde ?', answers: ['Atlantique', 'Pacifique', 'Indien', 'Arctique'], correctAnswerIndex: 1),
    Question(id: 'cg4', category: '1', question: 'Quelle est la planète la plus proche du Soleil ?', answers: ['Vénus', 'Mercure', 'Terre', 'Mars'], correctAnswerIndex: 1),
    Question(id: 'cg5', category: '1', question: 'Combien de jours y a-t-il dans une année bissextile ?', answers: ['364', '365', '366', '367'], correctAnswerIndex: 2),
    Question(id: 'cg6', category: '1', question: 'Quel est le symbole chimique de l\'or ?', answers: ['Au', 'Ag', 'Fe', 'Cu'], correctAnswerIndex: 0),
    Question(id: 'cg7', category: '1', question: 'Quelle est la langue la plus parlée au monde ?', answers: ['Anglais', 'Espagnol', 'Mandarin', 'Français'], correctAnswerIndex: 2),
    Question(id: 'cg8', category: '1', question: 'Quel est le plus grand désert du monde ?', answers: ['Sahara', 'Gobi', 'Antarctique', 'Arctique'], correctAnswerIndex: 2),
    Question(id: 'cg9', category: '1', question: 'Combien de côtés a un hexagone ?', answers: ['4', '5', '6', '7'], correctAnswerIndex: 2),
    Question(id: 'cg10', category: '1', question: 'Quel est le plus grand mammifère du monde ?', answers: ['Éléphant', 'Girafe', 'Baleine bleue', 'Rhinocéros'], correctAnswerIndex: 2),
    Question(id: 'cg11', category: '1', question: 'Quelle est la vitesse de la lumière ?', answers: ['300 000 km/s', '150 000 km/s', '450 000 km/s', '200 000 km/s'], correctAnswerIndex: 0),
    Question(id: 'cg12', category: '1', question: 'Quel est le plus grand pays du monde ?', answers: ['Canada', 'Chine', 'Russie', 'États-Unis'], correctAnswerIndex: 2),
    Question(id: 'cg13', category: '1', question: 'Combien de lettres compte l\'alphabet français ?', answers: ['24', '25', '26', '27'], correctAnswerIndex: 2),
    Question(id: 'cg14', category: '1', question: 'Quel est le plus haut sommet du monde ?', answers: ['K2', 'Mont Everest', 'Kilimandjaro', 'Mont Blanc'], correctAnswerIndex: 1),
    Question(id: 'cg15', category: '1', question: 'Quelle est la monnaie du Japon ?', answers: ['Yuan', 'Yen', 'Won', 'Ringgit'], correctAnswerIndex: 1),
    Question(id: 'cg16', category: '1', question: 'Combien de minutes y a-t-il dans une heure ?', answers: ['50', '60', '70', '100'], correctAnswerIndex: 1),
    Question(id: 'cg17', category: '1', question: 'Quel est le plus grand lac du monde ?', answers: ['Caspienne', 'Supérieur', 'Victoria', 'Baïkal'], correctAnswerIndex: 0),
    Question(id: 'cg18', category: '1', question: 'Quelle est la capitale de l\'Australie ?', answers: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'], correctAnswerIndex: 2),
    Question(id: 'cg19', category: '1', question: 'Combien de doigts a une main ?', answers: ['4', '5', '6', '7'], correctAnswerIndex: 1),
    Question(id: 'cg20', category: '1', question: 'Quel est le symbole chimique de l\'eau ?', answers: ['H2O', 'CO2', 'O2', 'NaCl'], correctAnswerIndex: 0),
    Question(id: 'cg21', category: '1', question: 'Quelle est la plus grande île du monde ?', answers: ['Madagascar', 'Groenland', 'Borneo', 'Nouvelle-Guinée'], correctAnswerIndex: 1),
    Question(id: 'cg22', category: '1', question: 'Combien de saisons y a-t-il dans une année ?', answers: ['2', '3', '4', '5'], correctAnswerIndex: 2),
    Question(id: 'cg23', category: '1', question: 'Quel est le plus petit pays du monde ?', answers: ['Monaco', 'Vatican', 'Nauru', 'San Marino'], correctAnswerIndex: 1),
    Question(id: 'cg24', category: '1', question: 'Quelle est la capitale du Brésil ?', answers: ['São Paulo', 'Rio de Janeiro', 'Brasília', 'Salvador'], correctAnswerIndex: 2),
    Question(id: 'cg25', category: '1', question: 'Combien de planètes y a-t-il dans notre système solaire ?', answers: ['7', '8', '9', '10'], correctAnswerIndex: 1),
  ];

  static List<Question> _jeuxVideo = [
    Question(id: 'jv1', category: '2', question: 'Quel jeu vidéo a vendu le plus d\'exemplaires ?', answers: ['GTA V', 'Minecraft', 'Tetris', 'Fortnite'], correctAnswerIndex: 1),
    Question(id: 'jv2', category: '2', question: 'Quelle est la première console de jeu vidéo ?', answers: ['Atari 2600', 'Magnavox Odyssey', 'NES', 'PlayStation'], correctAnswerIndex: 1),
    Question(id: 'jv3', category: '2', question: 'Dans quel jeu trouve-t-on le personnage Link ?', answers: ['Final Fantasy', 'The Legend of Zelda', 'Super Mario', 'Pokémon'], correctAnswerIndex: 1),
    Question(id: 'jv4', category: '2', question: 'Quel est le créateur de Minecraft ?', answers: ['Markus Persson', 'Shigeru Miyamoto', 'Hideo Kojima', 'Gabe Newell'], correctAnswerIndex: 0),
    Question(id: 'jv5', category: '2', question: 'Quelle entreprise a créé "The Elder Scrolls" ?', answers: ['Blizzard', 'Bethesda', 'Ubisoft', 'EA'], correctAnswerIndex: 1),
    Question(id: 'jv6', category: '2', question: 'Dans quel jeu peut-on trouver Master Chief ?', answers: ['Call of Duty', 'Halo', 'Gears of War', 'Destiny'], correctAnswerIndex: 1),
    Question(id: 'jv7', category: '2', question: 'Quel est le nom du protagoniste de "The Witcher 3" ?', answers: ['Geralt de Riv', 'Ciri', 'Yennefer', 'Triss'], correctAnswerIndex: 0),
    Question(id: 'jv8', category: '2', question: 'Quelle est la première console portable de Nintendo ?', answers: ['Game Boy', 'Nintendo DS', 'Game & Watch', 'Switch'], correctAnswerIndex: 2),
    Question(id: 'jv9', category: '2', question: 'Quel studio a développé "The Last of Us" ?', answers: ['Naughty Dog', 'Rockstar', 'CD Projekt Red', 'Insomniac'], correctAnswerIndex: 0),
    Question(id: 'jv10', category: '2', question: 'Quel est le personnage principal de "Assassin\'s Creed" ?', answers: ['Ezio', 'Altair', 'Connor', 'Edward'], correctAnswerIndex: 1),
    Question(id: 'jv11', category: '2', question: 'Dans quel jeu peut-on construire des villes ?', answers: ['SimCity', 'Cities: Skylines', 'Tropico', 'Tous les précédents'], correctAnswerIndex: 3),
    Question(id: 'jv12', category: '2', question: 'Quel est le nom du héros de "Final Fantasy VII" ?', answers: ['Cloud', 'Squall', 'Tidus', 'Noctis'], correctAnswerIndex: 0),
    Question(id: 'jv13', category: '2', question: 'Quelle console a été créée par Sega ?', answers: ['PlayStation', 'Xbox', 'Nintendo', 'Dreamcast'], correctAnswerIndex: 3),
    Question(id: 'jv14', category: '2', question: 'Quel est le jeu le plus vendu sur PlayStation 4 ?', answers: ['God of War', 'Spider-Man', 'The Last of Us Part II', 'Horizon Zero Dawn'], correctAnswerIndex: 2),
    Question(id: 'jv15', category: '2', question: 'Dans quel jeu peut-on capturer des Pokémon ?', answers: ['Digimon', 'Pokémon', 'Yu-Gi-Oh!', 'Beyblade'], correctAnswerIndex: 1),
    Question(id: 'jv16', category: '2', question: 'Quel est le créateur de "Super Mario" ?', answers: ['Hideo Kojima', 'Shigeru Miyamoto', 'Sid Meier', 'Will Wright'], correctAnswerIndex: 1),
    Question(id: 'jv17', category: '2', question: 'Quel est le nom du protagoniste de "Tomb Raider" ?', answers: ['Lara Croft', 'Nathan Drake', 'Indiana Jones', 'Elena Fisher'], correctAnswerIndex: 0),
    Question(id: 'jv18', category: '2', question: 'Quelle est la première version de "FIFA" ?', answers: ['FIFA 94', 'FIFA 95', 'FIFA 96', 'FIFA 97'], correctAnswerIndex: 0),
    Question(id: 'jv19', category: '2', question: 'Dans quel jeu peut-on construire avec des blocs ?', answers: ['Roblox', 'Minecraft', 'Terraria', 'Tous les précédents'], correctAnswerIndex: 3),
    Question(id: 'jv20', category: '2', question: 'Quel est le nom du héros de "Uncharted" ?', answers: ['Lara Croft', 'Nathan Drake', 'Joel', 'Kratos'], correctAnswerIndex: 1),
    Question(id: 'jv21', category: '2', question: 'Quelle entreprise a créé "Call of Duty" ?', answers: ['EA', 'Ubisoft', 'Activision', 'Bethesda'], correctAnswerIndex: 2),
    Question(id: 'jv22', category: '2', question: 'Quel est le jeu le plus joué au monde en 2023 ?', answers: ['Minecraft', 'Fortnite', 'League of Legends', 'PUBG'], correctAnswerIndex: 0),
    Question(id: 'jv23', category: '2', question: 'Dans quel jeu peut-on trouver Pikachu ?', answers: ['Digimon', 'Pokémon', 'Yu-Gi-Oh!', 'Beyblade'], correctAnswerIndex: 1),
    Question(id: 'jv24', category: '2', question: 'Quel est le nom du protagoniste de "Red Dead Redemption" ?', answers: ['John Marston', 'Arthur Morgan', 'Dutch', 'Micah'], correctAnswerIndex: 1),
    Question(id: 'jv25', category: '2', question: 'Quelle console a été créée par Microsoft ?', answers: ['PlayStation', 'Xbox', 'Nintendo', 'Sega'], correctAnswerIndex: 1),
  ];

  static List<Question> _cinemaSeries = [
    Question(id: 'cs1', category: '3', question: 'Quel film a remporté l\'Oscar du meilleur film en 2020 ?', answers: ['1917', 'Parasite', 'Joker', 'Once Upon a Time'], correctAnswerIndex: 1),
    Question(id: 'cs2', category: '3', question: 'Qui a réalisé "Inception" ?', answers: ['Christopher Nolan', 'Steven Spielberg', 'Quentin Tarantino', 'Martin Scorsese'], correctAnswerIndex: 0),
    Question(id: 'cs3', category: '3', question: 'Quel est le nom du héros de "Matrix" ?', answers: ['Neo', 'Morpheus', 'Trinity', 'Agent Smith'], correctAnswerIndex: 0),
    Question(id: 'cs4', category: '3', question: 'Quelle série suit les aventures de Jon Snow ?', answers: ['Breaking Bad', 'Game of Thrones', 'The Walking Dead', 'Stranger Things'], correctAnswerIndex: 1),
    Question(id: 'cs5', category: '3', question: 'Quel acteur joue Iron Man dans le MCU ?', answers: ['Chris Evans', 'Robert Downey Jr.', 'Chris Hemsworth', 'Mark Ruffalo'], correctAnswerIndex: 1),
    Question(id: 'cs6', category: '3', question: 'Quel film a le plus gros box-office de l\'histoire ?', answers: ['Avatar', 'Avengers: Endgame', 'Titanic', 'Star Wars'], correctAnswerIndex: 0),
    Question(id: 'cs7', category: '3', question: 'Qui a réalisé "Pulp Fiction" ?', answers: ['Martin Scorsese', 'Quentin Tarantino', 'David Fincher', 'Coen Brothers'], correctAnswerIndex: 1),
    Question(id: 'cs8', category: '3', question: 'Quelle série se déroule à Hawkins ?', answers: ['Breaking Bad', 'Stranger Things', 'The Office', 'Friends'], correctAnswerIndex: 1),
    Question(id: 'cs9', category: '3', question: 'Quel est le nom du vaisseau dans "Star Wars" ?', answers: ['Enterprise', 'Millennium Falcon', 'Nostromo', 'Serenity'], correctAnswerIndex: 1),
    Question(id: 'cs10', category: '3', question: 'Qui joue le Joker dans "The Dark Knight" ?', answers: ['Jack Nicholson', 'Heath Ledger', 'Joaquin Phoenix', 'Jared Leto'], correctAnswerIndex: 1),
    Question(id: 'cs11', category: '3', question: 'Quel film raconte l\'histoire de Forrest Gump ?', answers: ['Forrest Gump', 'The Shawshank Redemption', 'The Green Mile', 'Cast Away'], correctAnswerIndex: 0),
    Question(id: 'cs12', category: '3', question: 'Quelle série suit Walter White ?', answers: ['Better Call Saul', 'Breaking Bad', 'The Wire', 'The Sopranos'], correctAnswerIndex: 1),
    Question(id: 'cs13', category: '3', question: 'Qui a réalisé "The Godfather" ?', answers: ['Martin Scorsese', 'Francis Ford Coppola', 'Steven Spielberg', 'Alfred Hitchcock'], correctAnswerIndex: 1),
    Question(id: 'cs14', category: '3', question: 'Quel est le nom du héros de "Indiana Jones" ?', answers: ['Indiana Jones', 'Harrison Ford', 'Sean Connery', 'Tom Cruise'], correctAnswerIndex: 0),
    Question(id: 'cs15', category: '3', question: 'Quelle série se déroule à Westeros ?', answers: ['The Witcher', 'Game of Thrones', 'Vikings', 'The Last Kingdom'], correctAnswerIndex: 1),
    Question(id: 'cs16', category: '3', question: 'Quel acteur joue James Bond dans "Casino Royale" ?', answers: ['Pierce Brosnan', 'Daniel Craig', 'Sean Connery', 'Roger Moore'], correctAnswerIndex: 1),
    Question(id: 'cs17', category: '3', question: 'Quel film raconte l\'histoire de Andy Dufresne ?', answers: ['The Green Mile', 'The Shawshank Redemption', 'Forrest Gump', 'Cast Away'], correctAnswerIndex: 1),
    Question(id: 'cs18', category: '3', question: 'Quelle série suit les aventures de Rick Grimes ?', answers: ['Breaking Bad', 'The Walking Dead', 'Fear the Walking Dead', 'Z Nation'], correctAnswerIndex: 1),
    Question(id: 'cs19', category: '3', question: 'Qui a réalisé "Interstellar" ?', answers: ['Denis Villeneuve', 'Christopher Nolan', 'Ridley Scott', 'James Cameron'], correctAnswerIndex: 1),
    Question(id: 'cs20', category: '3', question: 'Quel est le nom du héros de "Blade Runner" ?', answers: ['Rick Deckard', 'Roy Batty', 'Pris', 'Gaff'], correctAnswerIndex: 0),
    Question(id: 'cs21', category: '3', question: 'Quelle série suit les aventures de Eleven ?', answers: ['The OA', 'Stranger Things', 'Dark', 'The Umbrella Academy'], correctAnswerIndex: 1),
    Question(id: 'cs22', category: '3', question: 'Quel acteur joue le rôle de Tony Stark ?', answers: ['Chris Evans', 'Robert Downey Jr.', 'Chris Hemsworth', 'Mark Ruffalo'], correctAnswerIndex: 1),
    Question(id: 'cs23', category: '3', question: 'Quel film a remporté l\'Oscar du meilleur film en 2023 ?', answers: ['Everything Everywhere', 'The Fabelmans', 'Top Gun: Maverick', 'Elvis'], correctAnswerIndex: 0),
    Question(id: 'cs24', category: '3', question: 'Qui a réalisé "Fight Club" ?', answers: ['David Fincher', 'Quentin Tarantino', 'Christopher Nolan', 'Darren Aronofsky'], correctAnswerIndex: 0),
    Question(id: 'cs25', category: '3', question: 'Quelle série suit les aventures de Daenerys Targaryen ?', answers: ['The Witcher', 'Game of Thrones', 'House of the Dragon', 'The Last Kingdom'], correctAnswerIndex: 1),
  ];

  static List<Question> _musique = [
    Question(id: 'mu1', category: '4', question: 'Quel groupe a chanté "Bohemian Rhapsody" ?', answers: ['The Beatles', 'Queen', 'Led Zeppelin', 'Pink Floyd'], correctAnswerIndex: 1),
    Question(id: 'mu2', category: '4', question: 'Quel artiste est surnommé "The King of Pop" ?', answers: ['Elvis Presley', 'Michael Jackson', 'Prince', 'Madonna'], correctAnswerIndex: 1),
    Question(id: 'mu3', category: '4', question: 'Quel groupe a sorti "Stairway to Heaven" ?', answers: ['The Beatles', 'Led Zeppelin', 'Pink Floyd', 'The Rolling Stones'], correctAnswerIndex: 1),
    Question(id: 'mu4', category: '4', question: 'Quel artiste a chanté "Billie Jean" ?', answers: ['Prince', 'Michael Jackson', 'Stevie Wonder', 'Marvin Gaye'], correctAnswerIndex: 1),
    Question(id: 'mu5', category: '4', question: 'Quel groupe a sorti "Hotel California" ?', answers: ['The Eagles', 'Fleetwood Mac', 'The Doors', 'Creedence'], correctAnswerIndex: 0),
    Question(id: 'mu6', category: '4', question: 'Quel artiste est surnommé "The Boss" ?', answers: ['Bob Dylan', 'Bruce Springsteen', 'Tom Petty', 'Neil Young'], correctAnswerIndex: 1),
    Question(id: 'mu7', category: '4', question: 'Quel groupe a sorti "Smells Like Teen Spirit" ?', answers: ['Pearl Jam', 'Nirvana', 'Soundgarden', 'Alice in Chains'], correctAnswerIndex: 1),
    Question(id: 'mu8', category: '4', question: 'Quel artiste a chanté "Like a Virgin" ?', answers: ['Cyndi Lauper', 'Madonna', 'Whitney Houston', 'Janet Jackson'], correctAnswerIndex: 1),
    Question(id: 'mu9', category: '4', question: 'Quel groupe a sorti "Comfortably Numb" ?', answers: ['The Beatles', 'Pink Floyd', 'Led Zeppelin', 'The Who'], correctAnswerIndex: 1),
    Question(id: 'mu10', category: '4', question: 'Quel artiste a chanté "Purple Rain" ?', answers: ['Michael Jackson', 'Prince', 'David Bowie', 'George Michael'], correctAnswerIndex: 1),
    Question(id: 'mu11', category: '4', question: 'Quel groupe a sorti "Sweet Child O\' Mine" ?', answers: ['Aerosmith', 'Guns N\' Roses', 'AC/DC', 'Van Halen'], correctAnswerIndex: 1),
    Question(id: 'mu12', category: '4', question: 'Quel artiste est surnommé "The Material Girl" ?', answers: ['Madonna', 'Britney Spears', 'Lady Gaga', 'Taylor Swift'], correctAnswerIndex: 0),
    Question(id: 'mu13', category: '4', question: 'Quel groupe a sorti "Another Brick in the Wall" ?', answers: ['The Beatles', 'Pink Floyd', 'Led Zeppelin', 'The Who'], correctAnswerIndex: 1),
    Question(id: 'mu14', category: '4', question: 'Quel artiste a chanté "Thriller" ?', answers: ['Prince', 'Michael Jackson', 'Stevie Wonder', 'Marvin Gaye'], correctAnswerIndex: 1),
    Question(id: 'mu15', category: '4', question: 'Quel groupe a sorti "Don\'t Stop Believin\'" ?', answers: ['Journey', 'Foreigner', 'REO Speedwagon', 'Styx'], correctAnswerIndex: 0),
    Question(id: 'mu16', category: '4', question: 'Quel artiste est surnommé "The Queen of Pop" ?', answers: ['Madonna', 'Britney Spears', 'Lady Gaga', 'Taylor Swift'], correctAnswerIndex: 0),
    Question(id: 'mu17', category: '4', question: 'Quel groupe a sorti "We Will Rock You" ?', answers: ['The Beatles', 'Queen', 'Led Zeppelin', 'Pink Floyd'], correctAnswerIndex: 1),
    Question(id: 'mu18', category: '4', question: 'Quel artiste a chanté "Imagine" ?', answers: ['Paul McCartney', 'John Lennon', 'George Harrison', 'Ringo Starr'], correctAnswerIndex: 1),
    Question(id: 'mu19', category: '4', question: 'Quel groupe a sorti "Back in Black" ?', answers: ['Aerosmith', 'AC/DC', 'Guns N\' Roses', 'Van Halen'], correctAnswerIndex: 1),
    Question(id: 'mu20', category: '4', question: 'Quel artiste est surnommé "The King" ?', answers: ['Michael Jackson', 'Elvis Presley', 'Prince', 'Frank Sinatra'], correctAnswerIndex: 1),
    Question(id: 'mu21', category: '4', question: 'Quel groupe a sorti "Strawberry Fields Forever" ?', answers: ['The Rolling Stones', 'The Beatles', 'The Who', 'The Kinks'], correctAnswerIndex: 1),
    Question(id: 'mu22', category: '4', question: 'Quel artiste a chanté "I Will Always Love You" ?', answers: ['Mariah Carey', 'Whitney Houston', 'Celine Dion', 'Adele'], correctAnswerIndex: 1),
    Question(id: 'mu23', category: '4', question: 'Quel groupe a sorti "Paint It Black" ?', answers: ['The Beatles', 'The Rolling Stones', 'The Who', 'The Kinks'], correctAnswerIndex: 1),
    Question(id: 'mu24', category: '4', question: 'Quel artiste est surnommé "The Voice" ?', answers: ['Frank Sinatra', 'Tony Bennett', 'Dean Martin', 'Sammy Davis Jr.'], correctAnswerIndex: 0),
    Question(id: 'mu25', category: '4', question: 'Quel groupe a sorti "Hey Jude" ?', answers: ['The Rolling Stones', 'The Beatles', 'The Who', 'The Kinks'], correctAnswerIndex: 1),
  ];

  static List<Question> _geographie = [
    Question(id: 'geo1', category: '5', question: 'Quelle est la capitale du Canada ?', answers: ['Toronto', 'Montréal', 'Ottawa', 'Vancouver'], correctAnswerIndex: 2),
    Question(id: 'geo2', category: '5', question: 'Quel est le plus grand pays d\'Afrique ?', answers: ['Nigeria', 'Algérie', 'Congo', 'Soudan'], correctAnswerIndex: 1),
    Question(id: 'geo3', category: '5', question: 'Quelle est la capitale de l\'Espagne ?', answers: ['Barcelone', 'Madrid', 'Séville', 'Valence'], correctAnswerIndex: 1),
    Question(id: 'geo4', category: '5', question: 'Quel est le plus long fleuve du monde ?', answers: ['Nil', 'Amazone', 'Mississippi', 'Yangtsé'], correctAnswerIndex: 0),
    Question(id: 'geo5', category: '5', question: 'Quelle est la capitale de l\'Italie ?', answers: ['Milan', 'Rome', 'Naples', 'Turin'], correctAnswerIndex: 1),
    Question(id: 'geo6', category: '5', question: 'Quel est le plus grand pays d\'Amérique du Sud ?', answers: ['Argentine', 'Brésil', 'Colombie', 'Pérou'], correctAnswerIndex: 1),
    Question(id: 'geo7', category: '5', question: 'Quelle est la capitale de l\'Allemagne ?', answers: ['Munich', 'Berlin', 'Hambourg', 'Francfort'], correctAnswerIndex: 1),
    Question(id: 'geo8', category: '5', question: 'Quel est le plus grand océan ?', answers: ['Atlantique', 'Pacifique', 'Indien', 'Arctique'], correctAnswerIndex: 1),
    Question(id: 'geo9', category: '5', question: 'Quelle est la capitale de l\'Égypte ?', answers: ['Alexandrie', 'Le Caire', 'Louxor', 'Assouan'], correctAnswerIndex: 1),
    Question(id: 'geo10', category: '5', question: 'Quel est le plus haut sommet d\'Europe ?', answers: ['Mont Blanc', 'Elbrouz', 'Matterhorn', 'Mont Rose'], correctAnswerIndex: 1),
    Question(id: 'geo11', category: '5', question: 'Quelle est la capitale de la Grèce ?', answers: ['Thessalonique', 'Athènes', 'Patras', 'Héraklion'], correctAnswerIndex: 1),
    Question(id: 'geo12', category: '5', question: 'Quel est le plus grand désert chaud du monde ?', answers: ['Gobi', 'Sahara', 'Kalahari', 'Arabie'], correctAnswerIndex: 1),
    Question(id: 'geo13', category: '5', question: 'Quelle est la capitale de la Turquie ?', answers: ['Istanbul', 'Ankara', 'Izmir', 'Antalya'], correctAnswerIndex: 1),
    Question(id: 'geo14', category: '5', question: 'Quel est le plus grand lac d\'Afrique ?', answers: ['Victoria', 'Tanganyika', 'Malawi', 'Chad'], correctAnswerIndex: 0),
    Question(id: 'geo15', category: '5', question: 'Quelle est la capitale de la Pologne ?', answers: ['Cracovie', 'Varsovie', 'Gdansk', 'Wroclaw'], correctAnswerIndex: 1),
    Question(id: 'geo16', category: '5', question: 'Quel est le plus grand pays d\'Asie ?', answers: ['Chine', 'Inde', 'Russie', 'Kazakhstan'], correctAnswerIndex: 2),
    Question(id: 'geo17', category: '5', question: 'Quelle est la capitale de la Suède ?', answers: ['Göteborg', 'Stockholm', 'Malmö', 'Uppsala'], correctAnswerIndex: 1),
    Question(id: 'geo18', category: '5', question: 'Quel est le plus long fleuve d\'Europe ?', answers: ['Danube', 'Rhin', 'Volga', 'Seine'], correctAnswerIndex: 2),
    Question(id: 'geo19', category: '5', question: 'Quelle est la capitale de la Norvège ?', answers: ['Bergen', 'Oslo', 'Trondheim', 'Stavanger'], correctAnswerIndex: 1),
    Question(id: 'geo20', category: '5', question: 'Quel est le plus grand archipel du monde ?', answers: ['Japon', 'Philippines', 'Indonésie', 'Maldives'], correctAnswerIndex: 2),
    Question(id: 'geo21', category: '5', question: 'Quelle est la capitale de la Thaïlande ?', answers: ['Chiang Mai', 'Bangkok', 'Phuket', 'Pattaya'], correctAnswerIndex: 1),
    Question(id: 'geo22', category: '5', question: 'Quel est le plus grand pays d\'Océanie ?', answers: ['Nouvelle-Zélande', 'Australie', 'Papouasie', 'Fidji'], correctAnswerIndex: 1),
    Question(id: 'geo23', category: '5', question: 'Quelle est la capitale de l\'Inde ?', answers: ['Mumbai', 'New Delhi', 'Bangalore', 'Calcutta'], correctAnswerIndex: 1),
    Question(id: 'geo24', category: '5', question: 'Quel est le plus grand pays d\'Amérique du Nord ?', answers: ['États-Unis', 'Canada', 'Mexique', 'Groenland'], correctAnswerIndex: 1),
    Question(id: 'geo25', category: '5', question: 'Quelle est la capitale de l\'Argentine ?', answers: ['Córdoba', 'Buenos Aires', 'Rosario', 'Mendoza'], correctAnswerIndex: 1),
  ];

  static List<Question> _litterature = [
    Question(id: 'lit1', category: '6', question: 'Qui a écrit "Les Misérables" ?', answers: ['Victor Hugo', 'Émile Zola', 'Gustave Flaubert', 'Honoré de Balzac'], correctAnswerIndex: 0),
    Question(id: 'lit2', category: '6', question: 'Qui a écrit "1984" ?', answers: ['George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'H.G. Wells'], correctAnswerIndex: 0),
    Question(id: 'lit3', category: '6', question: 'Qui a écrit "Le Petit Prince" ?', answers: ['Antoine de Saint-Exupéry', 'Jules Verne', 'Marcel Proust', 'Albert Camus'], correctAnswerIndex: 0),
    Question(id: 'lit4', category: '6', question: 'Qui a écrit "L\'Étranger" ?', answers: ['Jean-Paul Sartre', 'Albert Camus', 'Simone de Beauvoir', 'André Malraux'], correctAnswerIndex: 1),
    Question(id: 'lit5', category: '6', question: 'Qui a écrit "Harry Potter" ?', answers: ['J.K. Rowling', 'Stephen King', 'George R.R. Martin', 'J.R.R. Tolkien'], correctAnswerIndex: 0),
    Question(id: 'lit6', category: '6', question: 'Qui a écrit "Le Seigneur des Anneaux" ?', answers: ['George R.R. Martin', 'J.R.R. Tolkien', 'C.S. Lewis', 'Terry Pratchett'], correctAnswerIndex: 1),
    Question(id: 'lit7', category: '6', question: 'Qui a écrit "Don Quichotte" ?', answers: ['Miguel de Cervantes', 'Gabriel García Márquez', 'Jorge Luis Borges', 'Pablo Neruda'], correctAnswerIndex: 0),
    Question(id: 'lit8', category: '6', question: 'Qui a écrit "Madame Bovary" ?', answers: ['Émile Zola', 'Gustave Flaubert', 'Victor Hugo', 'Honoré de Balzac'], correctAnswerIndex: 1),
    Question(id: 'lit9', category: '6', question: 'Qui a écrit "Le Comte de Monte-Cristo" ?', answers: ['Victor Hugo', 'Alexandre Dumas', 'Jules Verne', 'Honoré de Balzac'], correctAnswerIndex: 1),
    Question(id: 'lit10', category: '6', question: 'Qui a écrit "Orgueil et Préjugés" ?', answers: ['Charlotte Brontë', 'Jane Austen', 'Emily Brontë', 'Virginia Woolf'], correctAnswerIndex: 1),
    Question(id: 'lit11', category: '6', question: 'Qui a écrit "L\'Iliade" et "L\'Odyssée" ?', answers: ['Virgile', 'Homère', 'Ovide', 'Sophocle'], correctAnswerIndex: 1),
    Question(id: 'lit12', category: '6', question: 'Qui a écrit "Roméo et Juliette" ?', answers: ['William Shakespeare', 'Christopher Marlowe', 'Ben Jonson', 'John Donne'], correctAnswerIndex: 0),
    Question(id: 'lit13', category: '6', question: 'Qui a écrit "Les Trois Mousquetaires" ?', answers: ['Victor Hugo', 'Alexandre Dumas', 'Jules Verne', 'Honoré de Balzac'], correctAnswerIndex: 1),
    Question(id: 'lit14', category: '6', question: 'Qui a écrit "Vingt Mille Lieues sous les mers" ?', answers: ['Alexandre Dumas', 'Jules Verne', 'Victor Hugo', 'Honoré de Balzac'], correctAnswerIndex: 1),
    Question(id: 'lit15', category: '6', question: 'Qui a écrit "Le Nom de la rose" ?', answers: ['Umberto Eco', 'Italo Calvino', 'Primo Levi', 'Dino Buzzati'], correctAnswerIndex: 0),
    Question(id: 'lit16', category: '6', question: 'Qui a écrit "Crime et Châtiment" ?', answers: ['Léon Tolstoï', 'Fiodor Dostoïevski', 'Anton Tchekhov', 'Ivan Tourgueniev'], correctAnswerIndex: 1),
    Question(id: 'lit17', category: '6', question: 'Qui a écrit "Guerre et Paix" ?', answers: ['Fiodor Dostoïevski', 'Léon Tolstoï', 'Anton Tchekhov', 'Ivan Tourgueniev'], correctAnswerIndex: 1),
    Question(id: 'lit18', category: '6', question: 'Qui a écrit "Le Rouge et le Noir" ?', answers: ['Honoré de Balzac', 'Stendhal', 'Gustave Flaubert', 'Émile Zola'], correctAnswerIndex: 1),
    Question(id: 'lit19', category: '6', question: 'Qui a écrit "Moby Dick" ?', answers: ['Edgar Allan Poe', 'Herman Melville', 'Mark Twain', 'Nathaniel Hawthorne'], correctAnswerIndex: 1),
    Question(id: 'lit20', category: '6', question: 'Qui a écrit "Les Fleurs du mal" ?', answers: ['Paul Verlaine', 'Charles Baudelaire', 'Arthur Rimbaud', 'Stéphane Mallarmé'], correctAnswerIndex: 1),
    Question(id: 'lit21', category: '6', question: 'Qui a écrit "Le Portrait de Dorian Gray" ?', answers: ['Oscar Wilde', 'George Bernard Shaw', 'James Joyce', 'Virginia Woolf'], correctAnswerIndex: 0),
    Question(id: 'lit22', category: '6', question: 'Qui a écrit "À la recherche du temps perdu" ?', answers: ['André Gide', 'Marcel Proust', 'Paul Valéry', 'André Malraux'], correctAnswerIndex: 1),
    Question(id: 'lit23', category: '6', question: 'Qui a écrit "L\'Assommoir" ?', answers: ['Gustave Flaubert', 'Émile Zola', 'Victor Hugo', 'Honoré de Balzac'], correctAnswerIndex: 1),
    Question(id: 'lit24', category: '6', question: 'Qui a écrit "Les Fables" ?', answers: ['Jean de La Fontaine', 'Molière', 'Racine', 'Corneille'], correctAnswerIndex: 0),
    Question(id: 'lit25', category: '6', question: 'Qui a écrit "Le Meilleur des mondes" ?', answers: ['George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'H.G. Wells'], correctAnswerIndex: 1),
  ];

  static List<Question> _sciences = [
    Question(id: 'sci1', category: '7', question: 'Quel est le symbole chimique de l\'oxygène ?', answers: ['O', 'Ox', 'Og', 'Oy'], correctAnswerIndex: 0),
    Question(id: 'sci2', category: '7', question: 'Combien de chromosomes a l\'être humain ?', answers: ['44', '46', '48', '50'], correctAnswerIndex: 1),
    Question(id: 'sci3', category: '7', question: 'Quelle est la vitesse de la lumière ?', answers: ['300 000 km/s', '150 000 km/s', '450 000 km/s', '200 000 km/s'], correctAnswerIndex: 0),
    Question(id: 'sci4', category: '7', question: 'Quel est le symbole chimique du fer ?', answers: ['Fe', 'Ir', 'Fr', 'Fm'], correctAnswerIndex: 0),
    Question(id: 'sci5', category: '7', question: 'Quelle est la formule chimique de l\'eau ?', answers: ['H2O', 'CO2', 'O2', 'NaCl'], correctAnswerIndex: 0),
    Question(id: 'sci6', category: '7', question: 'Quel est le plus grand organe du corps humain ?', answers: ['Foie', 'Poumon', 'Peau', 'Intestin'], correctAnswerIndex: 2),
    Question(id: 'sci7', category: '7', question: 'Combien de planètes y a-t-il dans notre système solaire ?', answers: ['7', '8', '9', '10'], correctAnswerIndex: 1),
    Question(id: 'sci8', category: '7', question: 'Quel est le symbole chimique de l\'hydrogène ?', answers: ['H', 'Hy', 'He', 'Ho'], correctAnswerIndex: 0),
    Question(id: 'sci9', category: '7', question: 'Quelle est la température d\'ébullition de l\'eau ?', answers: ['90°C', '100°C', '110°C', '120°C'], correctAnswerIndex: 1),
    Question(id: 'sci10', category: '7', question: 'Quel est le plus petit os du corps humain ?', answers: ['Marteau', 'Étrier', 'Enclume', 'Stapès'], correctAnswerIndex: 1),
    Question(id: 'sci11', category: '7', question: 'Quel est le symbole chimique du carbone ?', answers: ['C', 'Ca', 'Co', 'Cr'], correctAnswerIndex: 0),
    Question(id: 'sci12', category: '7', question: 'Combien de cœurs a une pieuvre ?', answers: ['1', '2', '3', '4'], correctAnswerIndex: 2),
    Question(id: 'sci13', category: '7', question: 'Quelle est la planète la plus proche du Soleil ?', answers: ['Vénus', 'Mercure', 'Terre', 'Mars'], correctAnswerIndex: 1),
    Question(id: 'sci14', category: '7', question: 'Quel est le symbole chimique de l\'azote ?', answers: ['A', 'Az', 'N', 'Ni'], correctAnswerIndex: 2),
    Question(id: 'sci15', category: '7', question: 'Combien de dents a un adulte ?', answers: ['28', '30', '32', '34'], correctAnswerIndex: 2),
    Question(id: 'sci16', category: '7', question: 'Quelle est la vitesse du son ?', answers: ['300 m/s', '330 m/s', '350 m/s', '400 m/s'], correctAnswerIndex: 1),
    Question(id: 'sci17', category: '7', question: 'Quel est le symbole chimique du sodium ?', answers: ['So', 'Na', 'No', 'Sa'], correctAnswerIndex: 1),
    Question(id: 'sci18', category: '7', question: 'Combien de muscles a le corps humain ?', answers: ['400', '500', '600', '700'], correctAnswerIndex: 2),
    Question(id: 'sci19', category: '7', question: 'Quelle est la planète la plus chaude ?', answers: ['Mercure', 'Vénus', 'Terre', 'Mars'], correctAnswerIndex: 1),
    Question(id: 'sci20', category: '7', question: 'Quel est le symbole chimique du calcium ?', answers: ['Ca', 'C', 'Cl', 'Co'], correctAnswerIndex: 0),
    Question(id: 'sci21', category: '7', question: 'Combien de temps la lumière du Soleil met-elle pour atteindre la Terre ?', answers: ['6 minutes', '8 minutes', '10 minutes', '12 minutes'], correctAnswerIndex: 1),
    Question(id: 'sci22', category: '7', question: 'Quel est le plus grand os du corps humain ?', answers: ['Fémur', 'Tibia', 'Humérus', 'Radius'], correctAnswerIndex: 0),
    Question(id: 'sci23', category: '7', question: 'Quelle est la formule chimique du dioxyde de carbone ?', answers: ['CO', 'CO2', 'C2O', 'CO3'], correctAnswerIndex: 1),
    Question(id: 'sci24', category: '7', question: 'Combien de planètes ont des anneaux ?', answers: ['1', '2', '3', '4'], correctAnswerIndex: 3),
    Question(id: 'sci25', category: '7', question: 'Quel est le symbole chimique de l\'or ?', answers: ['Au', 'Ag', 'Or', 'Go'], correctAnswerIndex: 0),
  ];

  static List<Question> _histoire = [
    Question(id: 'his1', category: '8', question: 'En quelle année a eu lieu la Révolution française ?', answers: ['1787', '1789', '1791', '1793'], correctAnswerIndex: 1),
    Question(id: 'his2', category: '8', question: 'Qui a été le premier empereur de Rome ?', answers: ['Jules César', 'Auguste', 'Néron', 'Caligula'], correctAnswerIndex: 1),
    Question(id: 'his3', category: '8', question: 'En quelle année a eu lieu la Première Guerre mondiale ?', answers: ['1912', '1914', '1916', '1918'], correctAnswerIndex: 1),
    Question(id: 'his4', category: '8', question: 'Qui a découvert l\'Amérique ?', answers: ['Vasco de Gama', 'Christophe Colomb', 'Magellan', 'Marco Polo'], correctAnswerIndex: 1),
    Question(id: 'his5', category: '8', question: 'En quelle année a eu lieu la chute du mur de Berlin ?', answers: ['1987', '1989', '1991', '1993'], correctAnswerIndex: 1),
    Question(id: 'his6', category: '8', question: 'Qui a été le premier président des États-Unis ?', answers: ['Thomas Jefferson', 'George Washington', 'John Adams', 'Benjamin Franklin'], correctAnswerIndex: 1),
    Question(id: 'his7', category: '8', question: 'En quelle année a eu lieu la Seconde Guerre mondiale ?', answers: ['1937', '1939', '1941', '1943'], correctAnswerIndex: 1),
    Question(id: 'his8', category: '8', question: 'Qui a été le pharaon le plus célèbre de l\'Égypte antique ?', answers: ['Ramsès II', 'Toutânkhamon', 'Cléopâtre', 'Akhenaton'], correctAnswerIndex: 0),
    Question(id: 'his9', category: '8', question: 'En quelle année a eu lieu la bataille de Waterloo ?', answers: ['1813', '1815', '1817', '1819'], correctAnswerIndex: 1),
    Question(id: 'his10', category: '8', question: 'Qui a été le premier empereur de France ?', answers: ['Louis XVI', 'Napoléon Bonaparte', 'Louis-Philippe', 'Charles X'], correctAnswerIndex: 1),
    Question(id: 'his11', category: '8', question: 'En quelle année a eu lieu la Révolution russe ?', answers: ['1915', '1917', '1919', '1921'], correctAnswerIndex: 1),
    Question(id: 'his12', category: '8', question: 'Qui a été le premier roi de France ?', answers: ['Clovis', 'Charlemagne', 'Hugues Capet', 'Philippe Auguste'], correctAnswerIndex: 0),
    Question(id: 'his13', category: '8', question: 'En quelle année a eu lieu la bataille de Marignan ?', answers: ['1513', '1515', '1517', '1519'], correctAnswerIndex: 1),
    Question(id: 'his14', category: '8', question: 'Qui a été le dernier tsar de Russie ?', answers: ['Alexandre II', 'Alexandre III', 'Nicolas II', 'Pierre le Grand'], correctAnswerIndex: 2),
    Question(id: 'his15', category: '8', question: 'En quelle année a eu lieu la prise de la Bastille ?', answers: ['1787', '1789', '1791', '1793'], correctAnswerIndex: 1),
    Question(id: 'his16', category: '8', question: 'Qui a été le premier homme à marcher sur la Lune ?', answers: ['Buzz Aldrin', 'Neil Armstrong', 'Michael Collins', 'John Glenn'], correctAnswerIndex: 1),
    Question(id: 'his17', category: '8', question: 'En quelle année a eu lieu la bataille d\'Alésia ?', answers: ['50 av. J.-C.', '52 av. J.-C.', '54 av. J.-C.', '56 av. J.-C.'], correctAnswerIndex: 1),
    Question(id: 'his18', category: '8', question: 'Qui a été le premier président de la Ve République ?', answers: ['Vincent Auriol', 'René Coty', 'Charles de Gaulle', 'Georges Pompidou'], correctAnswerIndex: 2),
    Question(id: 'his19', category: '8', question: 'En quelle année a eu lieu la fin de l\'Apartheid ?', answers: ['1991', '1993', '1994', '1995'], correctAnswerIndex: 2),
    Question(id: 'his20', category: '8', question: 'Qui a été le premier empereur de Chine ?', answers: ['Qin Shi Huang', 'Han Wudi', 'Tang Taizong', 'Kangxi'], correctAnswerIndex: 0),
    Question(id: 'his21', category: '8', question: 'En quelle année a eu lieu la bataille de Stalingrad ?', answers: ['1941', '1942', '1943', '1944'], correctAnswerIndex: 1),
    Question(id: 'his22', category: '8', question: 'Qui a été le premier roi d\'Angleterre ?', answers: ['Alfred le Grand', 'Édouard le Confesseur', 'Guillaume le Conquérant', 'Henri Ier'], correctAnswerIndex: 2),
    Question(id: 'his23', category: '8', question: 'En quelle année a eu lieu la bataille de Verdun ?', answers: ['1914', '1915', '1916', '1917'], correctAnswerIndex: 2),
    Question(id: 'his24', category: '8', question: 'Qui a été le premier président de la République française ?', answers: ['Adolphe Thiers', 'Patrice de Mac-Mahon', 'Jules Grévy', 'Sadi Carnot'], correctAnswerIndex: 0),
    Question(id: 'his25', category: '8', question: 'En quelle année a eu lieu la chute de l\'Empire romain d\'Occident ?', answers: ['473', '475', '476', '478'], correctAnswerIndex: 2),
  ];

  /// Récupère toutes les questions d'une catégorie
  static List<Question> getQuestionsByCategory(String categoryId) {
    switch (categoryId) {
      case '1': // Culture Générale
        return List.from(_cultureGenerale);
      case '2': // Jeux Vidéo
        return List.from(_jeuxVideo);
      case '3': // Cinéma & Séries
        return List.from(_cinemaSeries);
      case '4': // Musique
        return List.from(_musique);
      case '5': // Géographie
        return List.from(_geographie);
      case '6': // Littérature
        return List.from(_litterature);
      case '7': // Sciences
        return List.from(_sciences);
      case '8': // Histoire
        return List.from(_histoire);
      default:
        return [];
    }
  }
}
