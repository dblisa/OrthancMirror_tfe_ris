# RIS — Installation et démarrage

## 1. Prérequis

Avant de commencer, vérifier que vous avez :

- Python 3.13 ou supérieur
- PostgreSQL 14 ou supérieur
- Git

## 2. Récupérer le projet

Cloner le dépôt Git 

## 3. Créer l'environnement virtuel Python

### macOS et Linux

créer :

```bash
python3 -m venv .venv
```

activer :

**macOS :**
```bash
source .venv/bin/activate
```

**Linux :**
```bash
source .venv/bin/activate
```

Installer les dépendances :

```bash
pip install -r requirements.txt
```

## 4. Configurer PostgreSQL

Le projet utilise PostgreSQL avec une base de données nommée `ris_db`.

Chaque développeur doit créer sa propre base de données locale.

### Créer la base de données

Dans le terminal :

```bash
createdb ris_db
```

Si nécessaire, utiliser :

```bash
psql -U postgres
```

Puis exécuter :

```sql
CREATE DATABASE ris_db;
```

### Importer le schéma

Depuis la racine du projet RIS :

```bash
psql -U postgres -d ris_db -f schema.sql
```

Cette commande crée les tables nécessaires au fonctionnement du RIS :
- patients
- users
- roles
- user_roles
- departments
- user_department_access
- resources
- exam_requests
- appointments

### Configurer la connexion

Vérifier les paramètres PostgreSQL dans :

```text
database/postgres_db.py
```

Paramètres habituels :

- Host : `localhost`
- Port : `5432`
- Database : `ris_db`
- Username : utilisateur PostgreSQL local
- Password : mot de passe PostgreSQL local

Chaque développeur utilise ses propres identifiants PostgreSQL.

## 5. Configurer la session

L'application utilise une clé secrète pour sécuriser les sessions.

Avant de démarrer le serveur, définir la variable d'environnement `SESSION_SECRET`.

**macOS et Linux :**

```bash
export SESSION_SECRET="une-cle-secrete-pour-le-developpement"
```

Cette clé doit être conservée confidentielle et ne doit pas être ajoutée au dépôt Git.

## 6. Lancer le site

Vérifier que PostgreSQL est démarré, puis exécuter :

```bash
uvicorn auth.main:app --reload
```

Le serveur démarre normalement à l'adresse :

**http://127.0.0.1:8000**

Pour accéder à la page de connexion :

**http://127.0.0.1:8000/login**

Pour créer un compte :

**http://127.0.0.1:8000/register**

## 7. Utiliser l'application

Depuis la page de connexion, il est possible de :

- Se connecter avec une adresse e-mail et un mot de passe.
- Créer un nouveau compte depuis la page d'inscription.

Les comptes sont enregistrés dans la table `users` de PostgreSQL.

## 8. Arrêter le serveur

Dans le terminal où tourne Uvicorn, utiliser :

```bash
CTRL + C
```

---

**Remarque :** le code source est commun aux développeurs macOS et Linux. Seules certaines commandes d'installation et la configuration locale de PostgreSQL peuvent varier.