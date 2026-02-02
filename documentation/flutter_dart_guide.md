# Guide Complet Flutter & Dart

## Table des Matières

1. [Introduction à Dart](#introduction-à-dart)
2. [Introduction à Flutter](#introduction-à-flutter)
3. [Les Widgets](#les-widgets)
4. [StatelessWidget vs StatefulWidget](#statelesswidget-vs-statefulwidget)
5. [Material Design](#material-design)
6. [Gestion de l'État](#gestion-de-létat)
7. [Navigation](#navigation)
8. [Layouts et Conteneurs](#layouts-et-conteneurs)
9. [Gestion des Données](#gestion-des-données)
10. [Asynchrone et Futures](#asynchrone-et-futures)
11. [Packages et Dépendances](#packages-et-dépendances)
12. [Bonnes Pratiques](#bonnes-pratiques)
13. [Architecture et Patterns](#architecture-et-patterns)

---

## Introduction à Dart

### Qu'est-ce que Dart ?

Dart est un langage de programmation orienté objet développé par Google. Il est utilisé pour créer des applications Flutter et peut également être compilé en JavaScript pour le web.

### Caractéristiques Principales

- **Typage statique** : Dart est un langage typé statiquement avec inférence de type
- **Null Safety** : Gestion explicite des valeurs nulles
- **Asynchrone** : Support natif pour la programmation asynchrone
- **Orienté objet** : Classes, héritage, interfaces, mixins

### Syntaxe de Base

```dart
// Variables
String nom = "Flutter";
int age = 5;
double prix = 19.99;
bool estActif = true;

// Variables dynamiques
var variable = "peut changer de type";
dynamic variableDynamique = "peut être n'importe quoi";

// Constantes
const String constante = "ne change jamais";
final String finale = "initialisée une fois";

// Listes
List<String> fruits = ['pomme', 'banane', 'orange'];
List<int> nombres = [1, 2, 3, 4, 5];

// Maps
Map<String, int> scores = {
  'Alice': 100,
  'Bob': 85,
  'Charlie': 90,
};

// Sets
Set<String> uniques = {'a', 'b', 'c'};
```

### Null Safety

```dart
// Variables non-nullables par défaut
String nom = "Flutter"; // ne peut pas être null

// Variables nullable avec ?
String? nomNullable = null; // peut être null

// Vérification null
if (nomNullable != null) {
  print(nomNullable.length);
}

// Null-aware operators
String? nom;
String resultat = nom ?? "Par défaut"; // utilise "Par défaut" si nom est null
String longueur = nom?.length.toString() ?? "0";
```

### Fonctions

```dart
// Fonction simple
void direBonjour() {
  print("Bonjour");
}

// Fonction avec paramètres
String saluer(String nom) {
  return "Bonjour $nom";
}

// Fonction avec paramètres nommés
void creerUtilisateur({required String nom, int age = 18}) {
  print("$nom a $age ans");
}

// Fonction avec paramètres optionnels positionnels
void afficher(String message, [String? prefixe]) {
  print("${prefixe ?? ''}$message");
}

// Fonction fléchée
int additionner(int a, int b) => a + b;

// Fonction anonyme
var multiplier = (int a, int b) => a * b;
```

### Classes et Objets

```dart
// Classe simple
class Personne {
  String nom;
  int age;
  
  // Constructeur
  Personne(this.nom, this.age);
  
  // Constructeur nommé
  Personne.anonyme() : nom = "Anonyme", age = 0;
  
  // Méthode
  void sePresenter() {
    print("Je suis $nom, j'ai $age ans");
  }
  
  // Getter
  String get description => "$nom ($age ans)";
  
  // Setter
  set nouveauNom(String nom) {
    this.nom = nom;
  }
}

// Classe avec héritage
class Etudiant extends Personne {
  String ecole;
  
  Etudiant(String nom, int age, this.ecole) : super(nom, age);
  
  @override
  void sePresenter() {
    super.sePresenter();
    print("Je vais à $ecole");
  }
}

// Classe abstraite
abstract class Animal {
  void faireDuBruit();
}

class Chien extends Animal {
  @override
  void faireDuBruit() {
    print("Wouf!");
  }
}

// Mixins
mixin Voler {
  void voler() {
    print("Je vole!");
  }
}

class Oiseau extends Animal with Voler {
  @override
  void faireDuBruit() {
    print("Cui cui!");
  }
}
```

### Enums

```dart
enum Status {
  enAttente,
  enCours,
  termine,
  annule
}

void traiterStatus(Status status) {
  switch (status) {
    case Status.enAttente:
      print("En attente");
      break;
    case Status.enCours:
      print("En cours");
      break;
    case Status.termine:
      print("Terminé");
      break;
    case Status.annule:
      print("Annulé");
      break;
  }
}
```

### Générics

```dart
// Classe générique
class Boite<T> {
  T contenu;
  
  Boite(this.contenu);
  
  T obtenirContenu() => contenu;
}

// Utilisation
var boiteString = Boite<String>("Hello");
var boiteInt = Boite<int>(42);
```

---

## Introduction à Flutter

### Qu'est-ce que Flutter ?

Flutter est un framework open-source développé par Google pour créer des applications natives pour mobile, web et desktop à partir d'une seule base de code.

### Avantages de Flutter

- **Performance** : Compilation native, 60 FPS
- **Développement rapide** : Hot Reload et Hot Restart
- **Une seule base de code** : iOS, Android, Web, Desktop
- **UI riche** : Widgets personnalisables et Material Design
- **Écosystème** : Packages nombreux sur pub.dev

### Structure d'une Application Flutter

```
mon_app/
├── lib/
│   └── main.dart          # Point d'entrée
├── test/                  # Tests
├── android/               # Configuration Android
├── ios/                   # Configuration iOS
├── web/                   # Configuration Web
├── pubspec.yaml           # Dépendances et métadonnées
└── README.md
```

### Point d'Entrée

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App',
      home: HomePage(),
    );
  }
}
```

---

## Les Widgets

### Concept de Widget

En Flutter, **tout est un widget**. Les widgets sont les éléments de base de l'interface utilisateur. Ils peuvent être :
- Des éléments visuels (Text, Image, Button)
- Des layouts (Row, Column, Stack)
- Des conteneurs (Container, Padding)
- Des widgets fonctionnels (GestureDetector, Navigator)

### Arbre de Widgets

Flutter construit l'UI comme un arbre de widgets :
```
MaterialApp
  └── Scaffold
      ├── AppBar
      ├── Body
      │   └── Column
      │       ├── Text
      │       └── Button
      └── FloatingActionButton
```

### Widgets de Base

#### Text

```dart
Text(
  'Hello Flutter',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

#### Image

```dart
// Image depuis assets
Image.asset('assets/images/logo.png')

// Image depuis réseau
Image.network('https://example.com/image.jpg')

// Image depuis fichier
Image.file(File('path/to/image.jpg'))
```

#### Icon

```dart
Icon(
  Icons.favorite,
  color: Colors.red,
  size: 48,
)
```

#### Button

```dart
// ElevatedButton
ElevatedButton(
  onPressed: () {
    print('Bouton pressé');
  },
  child: Text('Cliquez-moi'),
)

// TextButton
TextButton(
  onPressed: () {},
  child: Text('Texte'),
)

// IconButton
IconButton(
  onPressed: () {},
  icon: Icon(Icons.add),
)
```

### Widgets de Layout

#### Container

```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 5,
      ),
    ],
  ),
  child: Text('Contenu'),
)
```

#### Padding

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Texte avec padding'),
)
```

#### SizedBox

```dart
SizedBox(
  width: 100,
  height: 50,
  child: Text('Espace fixe'),
)

// Espaceur
SizedBox(height: 20)
```

#### Row et Column

```dart
// Row (horizontal)
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Icon(Icons.star),
    Text('Étoile'),
  ],
)

// Column (vertical)
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Premier'),
    Text('Deuxième'),
    Text('Troisième'),
  ],
)
```

#### Stack

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.blue,
    ),
    Positioned(
      top: 10,
      left: 10,
      child: Text('Positionné'),
    ),
  ],
)
```

#### Expanded et Flexible

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

### Widgets Conditionnels

```dart
// Condition simple
condition ? widget1 : widget2

// Avec if
if (condition)
  widget1
else
  widget2

// Liste conditionnelle
Column(
  children: [
    Text('Toujours visible'),
    if (condition) Text('Conditionnel'),
    ...listeWidgets,
  ],
)
```

---

## StatelessWidget vs StatefulWidget

### StatelessWidget

Un **StatelessWidget** est un widget qui ne change jamais. Une fois construit, il reste identique.

```dart
class MonWidget extends StatelessWidget {
  final String titre;
  
  const MonWidget({super.key, required this.titre});
  
  @override
  Widget build(BuildContext context) {
    return Text(titre);
  }
}
```

**Caractéristiques :**
- Immutable (immuable)
- Pas d'état interne
- Reconstruit uniquement si les paramètres changent
- Plus performant
- Utilisé pour l'affichage statique

**Quand l'utiliser :**
- Affichage de données statiques
- Widgets de présentation
- Composants réutilisables sans état

### StatefulWidget

Un **StatefulWidget** est un widget qui peut changer au cours du temps. Il maintient un état qui peut être modifié.

```dart
class Compteur extends StatefulWidget {
  const Compteur({super.key});
  
  @override
  State<Compteur> createState() => _CompteurState();
}

class _CompteurState extends State<Compteur> {
  int _compteur = 0;
  
  void _incrementer() {
    setState(() {
      _compteur++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Compteur: $_compteur'),
        ElevatedButton(
          onPressed: _incrementer,
          child: Text('Incrémenter'),
        ),
      ],
    );
  }
}
```

**Caractéristiques :**
- Maintient un état mutable
- Peut être reconstruit avec `setState()`
- Plus complexe que StatelessWidget
- Utilisé pour l'interactivité

**Quand l'utiliser :**
- Formulaires
- Animations
- Données qui changent
- Interactions utilisateur

### setState()

`setState()` est la méthode utilisée pour notifier Flutter qu'un changement d'état a eu lieu et que le widget doit être reconstruit.

```dart
setState(() {
  // Modifications de l'état
  _valeur = nouvelleValeur;
});
```

**Important :**
- Toujours appeler `setState()` pour modifier l'état
- Ne pas appeler `setState()` dans `build()`
- `setState()` déclenche une reconstruction du widget

---

## Material Design

### Qu'est-ce que Material Design ?

Material Design est un système de design développé par Google. Flutter fournit une implémentation complète de Material Design.

### MaterialApp

`MaterialApp` est le widget racine qui fournit les fonctionnalités Material Design.

```dart
MaterialApp(
  title: 'Mon App',
  theme: ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  ),
  themeMode: ThemeMode.system,
  home: HomePage(),
  routes: {
    '/': (context) => HomePage(),
    '/details': (context) => DetailsPage(),
  },
)
```

### Scaffold

`Scaffold` fournit la structure de base d'une page Material Design.

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Titre'),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  ),
  body: Center(
    child: Text('Corps de la page'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  drawer: Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text('Item 1'),
          onTap: () {},
        ),
      ],
    ),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Accueil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Paramètres',
      ),
    ],
  ),
)
```

### AppBar

```dart
AppBar(
  title: Text('Titre'),
  leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
  backgroundColor: Colors.blue,
  elevation: 4,
)
```

### Thème

```dart
ThemeData(
  // Couleurs
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  accentColor: Colors.orange,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  
  // Typographie
  textTheme: TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
  ),
  
  // Composants
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  
  // Input
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
)
```

### Cupertino (iOS Style)

Flutter fournit aussi des widgets de style iOS :

```dart
import 'package:flutter/cupertino.dart';

CupertinoApp(
  home: CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('Titre'),
    ),
    child: Center(
      child: Text('Contenu'),
    ),
  ),
)
```

---

## Gestion de l'État

### État Local vs État Global

#### État Local (setState)

Pour l'état d'un seul widget :

```dart
class MonWidget extends StatefulWidget {
  @override
  State<MonWidget> createState() => _MonWidgetState();
}

class _MonWidgetState extends State<MonWidget> {
  int _compteur = 0;
  
  void _incrementer() {
    setState(() {
      _compteur++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Text('$_compteur');
  }
}
```

#### État Global

Pour partager l'état entre plusieurs widgets, plusieurs solutions :

### 1. InheritedWidget

```dart
class MonEtat extends InheritedWidget {
  final int compteur;
  
  const MonEtat({
    super.key,
    required this.compteur,
    required super.child,
  });
  
  static MonEtat? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MonEtat>();
  }
  
  @override
  bool updateShouldNotify(MonEtat oldWidget) {
    return compteur != oldWidget.compteur;
  }
}
```

### 2. Provider (Package populaire)

```dart
// Installation: flutter pub add provider

// Modèle
class CompteurModel extends ChangeNotifier {
  int _compteur = 0;
  int get compteur => _compteur;
  
  void incrementer() {
    _compteur++;
    notifyListeners();
  }
}

// Utilisation
Provider(
  create: (_) => CompteurModel(),
  child: MonApp(),
)

// Consommation
Consumer<CompteurModel>(
  builder: (context, model, child) {
    return Text('${model.compteur}');
  },
)
```

### 3. Riverpod (Alternative moderne)

```dart
// Installation: flutter pub add flutter_riverpod

final compteurProvider = StateNotifierProvider<CompteurNotifier, int>((ref) {
  return CompteurNotifier();
});

class CompteurNotifier extends StateNotifier<int> {
  CompteurNotifier() : super(0);
  
  void incrementer() => state++;
}

// Utilisation
Consumer(
  builder: (context, ref, child) {
    final compteur = ref.watch(compteurProvider);
    return Text('$compteur');
  },
)
```

### 4. BLoC Pattern

```dart
// Installation: flutter pub add flutter_bloc

// Événement
abstract class CompteurEvent {}
class Incrementer extends CompteurEvent {}

// État
class CompteurState {
  final int valeur;
  CompteurState(this.valeur);
}

// BLoC
class CompteurBloc extends Bloc<CompteurEvent, CompteurState> {
  CompteurBloc() : super(CompteurState(0)) {
    on<Incrementer>((event, emit) {
      emit(CompteurState(state.valeur + 1));
    });
  }
}

// Utilisation
BlocProvider(
  create: (_) => CompteurBloc(),
  child: MonApp(),
)

BlocBuilder<CompteurBloc, CompteurState>(
  builder: (context, state) {
    return Text('${state.valeur}');
  },
)
```

---

## Navigation

### Navigation Basique

```dart
// Naviguer vers une nouvelle page
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailsPage(),
  ),
);

// Retourner en arrière
Navigator.pop(context);

// Retourner avec une valeur
Navigator.pop(context, 'résultat');
```

### Navigation avec Routes Nommées

```dart
MaterialApp(
  routes: {
    '/': (context) => HomePage(),
    '/details': (context) => DetailsPage(),
    '/settings': (context) => SettingsPage(),
  },
)

// Navigation
Navigator.pushNamed(context, '/details');

// Avec arguments
Navigator.pushNamed(
  context,
  '/details',
  arguments: {'id': 123},
);

// Récupérer les arguments
final args = ModalRoute.of(context)!.settings.arguments as Map;
```

### Navigation avec Résultat

```dart
// Naviguer et attendre un résultat
final resultat = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SelectionPage(),
  ),
);

if (resultat != null) {
  print('Résultat: $resultat');
}
```

### Bottom Navigation Bar

```dart
int _indexSelectionne = 0;

Scaffold(
  body: _pages[_indexSelectionne],
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: _indexSelectionne,
    onTap: (index) {
      setState(() {
        _indexSelectionne = index;
      });
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Accueil',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Recherche',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil',
      ),
    ],
  ),
)
```

### Drawer (Menu latéral)

```dart
Scaffold(
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text('Menu'),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Accueil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Paramètres'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    ),
  ),
)
```

---

## Layouts et Conteneurs

### Contraintes et Sizing

Flutter utilise un système de contraintes pour déterminer la taille des widgets :

- **BoxConstraints** : Contraintes min/max pour width et height
- **Unbounded** : Pas de contrainte maximale
- **Tight** : Contraintes min = max
- **Loose** : Contraintes min < max

### SingleChildScrollView

```dart
SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(
    children: [
      // Widgets qui peuvent dépasser l'écran
    ],
  ),
)
```

### ListView

```dart
// ListView simple
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)

// ListView.builder (performant pour grandes listes)
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
    );
  },
)

// ListView.separated (avec séparateurs)
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (context, index) => Divider(),
  itemBuilder: (context, index) {
    return ListTile(title: Text(items[index]));
  },
)
```

### GridView

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ],
)

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.blue,
      child: Text(items[index]),
    );
  },
)
```

### Wrap

```dart
Wrap(
  spacing: 8.0,
  runSpacing: 4.0,
  children: [
    Chip(label: Text('Tag 1')),
    Chip(label: Text('Tag 2')),
    Chip(label: Text('Tag 3')),
  ],
)
```

---

## Gestion des Données

### Formulaires

```dart
class MonFormulaire extends StatefulWidget {
  @override
  State<MonFormulaire> createState() => _MonFormulaireState();
}

class _MonFormulaireState extends State<MonFormulaire> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  
  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nomController,
            decoration: InputDecoration(
              labelText: 'Nom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Traiter le formulaire
                print(_nomController.text);
              }
            },
            child: Text('Soumettre'),
          ),
        ],
      ),
    );
  }
}
```

### TextEditingController

```dart
final controller = TextEditingController();

TextField(
  controller: controller,
  onChanged: (value) {
    print('Texte changé: $value');
  },
)

// Écouter les changements
controller.addListener(() {
  print(controller.text);
});
```

### SharedPreferences (Stockage Local)

```dart
// Installation: flutter pub add shared_preferences

final prefs = await SharedPreferences.getInstance();

// Sauvegarder
await prefs.setString('nom', 'Flutter');
await prefs.setInt('age', 5);
await prefs.setBool('estActif', true);

// Lire
String? nom = prefs.getString('nom');
int? age = prefs.getInt('age');
bool? estActif = prefs.getBool('estActif');

// Supprimer
await prefs.remove('nom');
await prefs.clear();
```

### SQLite (Base de Données)

```dart
// Installation: flutter pub add sqflite path

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  
  DatabaseHelper._init();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }
  
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
  
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        date_creation TEXT
      )
    ''');
  }
}
```

---

## Asynchrone et Futures

### Futures

```dart
// Future simple
Future<String> obtenirDonnees() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Données chargées';
}

// Utilisation
obtenirDonnees().then((donnees) {
  print(donnees);
}).catchError((erreur) {
  print('Erreur: $erreur');
});

// Avec async/await
Future<void> chargerDonnees() async {
  try {
    final donnees = await obtenirDonnees();
    print(donnees);
  } catch (erreur) {
    print('Erreur: $erreur');
  }
}
```

### Streams

```dart
// Créer un Stream
Stream<int> compter() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

// Écouter un Stream
compter().listen(
  (valeur) => print(valeur),
  onError: (erreur) => print('Erreur: $erreur'),
  onDone: () => print('Terminé'),
);

// StreamBuilder dans Flutter
StreamBuilder<int>(
  stream: compter(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Erreur: ${snapshot.error}');
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    return Text('Valeur: ${snapshot.data}');
  },
)
```

### FutureBuilder

```dart
FutureBuilder<String>(
  future: obtenirDonnees(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Erreur: ${snapshot.error}');
    }
    return Text(snapshot.data ?? 'Aucune donnée');
  },
)
```

### Gestion des Erreurs

```dart
try {
  final resultat = await operationRisquee();
} on TimeoutException {
  print('Timeout');
} on FormatException catch (e) {
  print('Format invalide: $e');
} catch (e, stackTrace) {
  print('Erreur: $e');
  print('Stack trace: $stackTrace');
} finally {
  print('Toujours exécuté');
}
```

---

## Packages et Dépendances

### pubspec.yaml

```yaml
name: mon_app
description: Une application Flutter
version: 1.0.0

dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.0.0
  shared_preferences: ^2.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  
  assets:
    - images/
    - data/
  
  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf
```

### Installation de Packages

```bash
# Ajouter un package
flutter pub add http

# Ajouter un package de développement
flutter pub add --dev flutter_test

# Mettre à jour les packages
flutter pub get

# Mettre à jour vers les dernières versions
flutter pub upgrade
```

### Packages Populaires

- **http** : Requêtes HTTP
- **provider** : Gestion d'état
- **shared_preferences** : Stockage local
- **sqflite** : Base de données SQLite
- **path_provider** : Chemins système
- **image_picker** : Sélection d'images
- **url_launcher** : Ouvrir URLs
- **flutter_bloc** : Pattern BLoC
- **get_it** : Injection de dépendances
- **dio** : Client HTTP avancé

### Requêtes HTTP

```dart
// Installation: flutter pub add http

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> obtenirDonnees() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/data'),
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Échec du chargement');
  }
}
```

---

## Bonnes Pratiques

### Performance

1. **Utiliser const** : Marquer les widgets constants avec `const`
```dart
const Text('Hello') // Meilleur que Text('Hello')
```

2. **ListView.builder** : Pour les grandes listes
```dart
ListView.builder( // Meilleur que ListView
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

3. **Éviter les rebuilds inutiles** : Utiliser `const` et séparer les widgets

4. **Disposer les controllers** : Toujours disposer les controllers
```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### Code Organisation

```
lib/
├── main.dart
├── models/
│   └── user.dart
├── screens/
│   ├── home_screen.dart
│   └── details_screen.dart
├── widgets/
│   ├── custom_button.dart
│   └── custom_card.dart
├── services/
│   └── api_service.dart
├── utils/
│   └── constants.dart
└── theme/
    └── app_theme.dart
```

### Naming Conventions

- **Classes** : PascalCase (`MyWidget`)
- **Variables/Fonctions** : camelCase (`myVariable`, `myFunction`)
- **Constantes** : camelCase ou SCREAMING_CAPS (`kConstant`, `CONSTANT`)
- **Fichiers** : snake_case (`my_widget.dart`)
- **Privé** : Préfixe `_` (`_privateVariable`)

### Widgets Réutilisables

```dart
class CustomButton extends StatelessWidget {
  final String texte;
  final VoidCallback? onPressed;
  final Color? couleur;
  
  const CustomButton({
    super.key,
    required this.texte,
    this.onPressed,
    this.couleur,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: couleur ?? Colors.blue,
      ),
      child: Text(texte),
    );
  }
}
```

### Gestion des Erreurs

```dart
class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  
  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(message),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Réessayer'),
            ),
        ],
      ),
    );
  }
}
```

---

## Architecture et Patterns

### MVVM (Model-View-ViewModel)

```dart
// Model
class User {
  final String nom;
  final int age;
  User({required this.nom, required this.age});
}

// ViewModel
class UserViewModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  
  Future<void> chargerUser() async {
    // Charger depuis API
    _user = User(nom: 'Flutter', age: 5);
    notifyListeners();
  }
}

// View
class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..chargerUser(),
      child: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.user == null) {
            return CircularProgressIndicator();
          }
          return Text(viewModel.user!.nom);
        },
      ),
    );
  }
}
```

### Repository Pattern

```dart
// Interface
abstract class UserRepository {
  Future<User> obtenirUser(int id);
  Future<void> sauvegarderUser(User user);
}

// Implémentation
class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;
  final LocalStorage localStorage;
  
  UserRepositoryImpl(this.apiService, this.localStorage);
  
  @override
  Future<User> obtenirUser(int id) async {
    try {
      return await apiService.getUser(id);
    } catch (e) {
      return await localStorage.getUser(id);
    }
  }
  
  @override
  Future<void> sauvegarderUser(User user) async {
    await localStorage.saveUser(user);
    await apiService.saveUser(user);
  }
}
```

### Service Locator

```dart
// Installation: flutter pub add get_it

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => UserRepository());
}

// Utilisation
final apiService = getIt<ApiService>();
```

---

## Ressources Supplémentaires

### Commandes Flutter Utiles

```bash
# Créer un projet
flutter create mon_app

# Lancer l'app
flutter run

# Hot Reload (dans le terminal)
r

# Hot Restart
R

# Build APK
flutter build apk

# Build iOS
flutter build ios

# Analyser le code
flutter analyze

# Formater le code
flutter format .

# Tests
flutter test
```

### Widgets Utiles à Connaître

- **AnimatedContainer** : Container avec animations
- **Hero** : Animations de transition
- **AnimatedBuilder** : Animations personnalisées
- **GestureDetector** : Détection de gestes
- **InkWell** : Zone cliquable avec effet Material
- **Card** : Carte Material Design
- **Chip** : Badge/Tag
- **Divider** : Séparateur
- **LinearProgressIndicator** : Barre de progression
- **CircularProgressIndicator** : Indicateur circulaire
- **SnackBar** : Notification temporaire
- **AlertDialog** : Boîte de dialogue
- **BottomSheet** : Panneau inférieur
- **TabBar** : Onglets
- **Stepper** : Étapes
- **DatePicker** : Sélecteur de date
- **TimePicker** : Sélecteur d'heure

### Concepts Avancés

- **Keys** : Identifier les widgets dans l'arbre
- **BuildContext** : Contexte de construction
- **MediaQuery** : Informations sur l'écran
- **Theme** : Thème de l'application
- **Localizations** : Internationalisation
- **Platform Channels** : Communication avec le code natif
- **Isolates** : Parallélisme
- **Custom Painters** : Dessin personnalisé
- **Shaders** : Effets visuels avancés

---

## Conclusion

Ce guide couvre les concepts fondamentaux de Flutter et Dart. Pour approfondir :

- **Documentation officielle** : https://flutter.dev/docs
- **Cookbook** : https://flutter.dev/docs/cookbook
- **Packages** : https://pub.dev
- **Communauté** : Forums, Stack Overflow, Reddit r/FlutterDev

Bon développement Flutter ! 🚀
