import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(); // Initialiser Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Accueil(),
    );
  }
}

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _currentIndex = 0;
  List<String> activitesList = ['Sport', 'Shopping', 'Tout'];
  String selectedActivite = 'Tout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'accueil'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    filterActivites('Sport');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedActivite == 'Sport'
                        ? Color(0xffcaaed2)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  child: Text('Sport'),
                ),
                ElevatedButton(
                  onPressed: () {
                    filterActivites('Shopping');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedActivite == 'Shopping'
                        ? Color(0xffcaaed2)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  child: Text('Shopping'),
                ),
                ElevatedButton(
                  onPressed: () {
                    filterActivites('Tout');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedActivite == 'Tout'
                        ? Color(0xffcaaed2)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  child: Text('Tout'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (_currentIndex == 0) {
            showActivitesMenu();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          showActivitesMenu();
        },
        child: Icon(Icons.arrow_drop_down),
      )
          : null,
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return StreamBuilder<QuerySnapshot>(
        stream: selectedActivite == 'Tout'
            ? FirebaseFirestore.instance.collection('Activites').snapshots()
            : FirebaseFirestore.instance
            .collection('Activites')
            .where('title', isEqualTo: selectedActivite)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data() as Map<String, dynamic>;

              return Card(
                color: Colors.white,
                elevation: 5,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  title: Text(
                    data['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data['location'],
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        data['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailActivite(document.id),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      );
    } else if (_currentIndex == 1) {
      return AjoutPage();
    } else {
      return Container();
    }
  }

  void showActivitesMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: activitesList.map((activite) {
            return ListTile(
              title: Text(activite),
              onTap: () {
                setState(() {
                  selectedActivite = activite;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void filterActivites(String activite) {
    setState(() {
      selectedActivite = activite;
    });
  }
}


class AjoutPage extends StatefulWidget {
  @override
  _AjoutPageState createState() => _AjoutPageState();
}

class _AjoutPageState extends State<AjoutPage> {
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController numberOfPeopleController =
  TextEditingController(); // Nouveau champ pour le nombre de personnes
  File? selectedImage;
  List<dynamic>? _recognitions;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model2.tflite",
      labels: "assets/labels.txt",
    );
    print(res);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      classifyImage(File(pickedFile.path));
    }
  }

  Future<void> classifyImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
    );

    setState(() {
      _recognitions = recognitions;
      titleController.text = ''; // Laissez le champ titre vide pour que l'utilisateur le saisisse
      categoryController.text = _recognitions![0]['label'].toString().substring(2);
      selectedImage = image;
    });
  }

  Future<void> uploadImageToFirebase() async {
    if (selectedImage != null) {
      // Créez une référence de stockage avec un nom de fichier unique
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');

      // Chargez l'image dans le stockage Firebase
      UploadTask uploadTask = storageReference.putFile(selectedImage!);
      await uploadTask.whenComplete(() async {
        // Récupérez l'URL de l'image après le téléchargement
        String imageUrl = await storageReference.getDownloadURL();

        // Utilisez l'URL de l'image pour afficher l'image ou la stocker dans Firestore
        setState(() {
          imageUrlController.text = imageUrl;
        });
      });
    }
  }

  Future<void> saveDataToFirestore() async {
    // Check if values are not empty before adding to Firestore
    if (selectedImage != null &&
        titleController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        categoryController.text.isNotEmpty) {
      // Appeler la fonction pour télécharger l'image avant d'ajouter les données à Firestore
      await uploadImageToFirebase();

      // Retrieve values from text fields
      String imageUrl = imageUrlController.text;
      String title = titleController.text;
      String location = locationController.text;
      double price = double.tryParse(priceController.text) ?? 0.0;
      String category = categoryController.text;
      int numberOfPeople = int.tryParse(numberOfPeopleController.text) ?? 0;

      // Create a map with the data
      Map<String, dynamic> data = {
        'imageUrl': imageUrl,
        'title': title,
        'location': location,
        'price': price,
        'category': category,
        'numberOfPeople': numberOfPeople,
      };

      // Reference to the 'Activites' collection in Firestore
      CollectionReference activitesCollection =
      FirebaseFirestore.instance.collection('Activites');

      // Add data to Firestore
      await activitesCollection.add(data);

      // Clear text fields after adding
      imageUrlController.clear();
      titleController.clear();
      locationController.clear();
      priceController.clear();
      categoryController.clear();
      numberOfPeopleController.clear();
    } else {
      // Show an alert or error message if fields are empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Champs requis'),
            content: Text('Veuillez remplir tous les champs requis.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Image'),
            selectedImage != null
                ? Image.file(
              selectedImage!,
              height: 100,
            )
                : ElevatedButton(
              onPressed: () async {
                await pickImage();
              },
              child: Text('Sélectionnez l\'image de votre activité'),
            ),
            SizedBox(height: 20),
            Text('Titre'),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Entrez un titre',
              ),
            ),
            SizedBox(height: 20),
            Text('Catégorie (prédite avec IA)'),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: 'Catégorie',
              ),
            ),
            SizedBox(height: 20),
            Text('Lieu'),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                hintText: 'Entrez le lieu',
              ),
            ),
            SizedBox(height: 20),
            Text('Prix'),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hintText: 'Entrez le prix',
              ),
            ),
            SizedBox(height: 20),
            Text('Nombre de personnes'),
            TextField(
              controller: numberOfPeopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Entrez le nombre de personnes',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await saveDataToFirestore();
              },
              child: Text('Enregistrer'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DetailActivite extends StatelessWidget {
  final String activiteId;

  DetailActivite(this.activiteId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('Activites').doc(activiteId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var activite = snapshot.data?.data() as Map<String, dynamic>;

        return AlertDialog(
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Détails de l\'Activité',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Titre: ${activite['title']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lieu: ${activite['location']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Prix: ${activite['price']}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  // Agrandir l'image à partir de l'URL avec un style attirant
                  activite['imageUrl'] != null
                      ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        activite['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : Container(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Fermer'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
