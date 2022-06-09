import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class ApplicationLocalizations {
  ApplicationLocalizations(this.locale);

   Locale locale;

  static ApplicationLocalizations? of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(context, ApplicationLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello-world': 'Hello world!',
      'loginToYourProfile': 'Login to your \nprofile',
      "email": "Email",
      "password": "Password",
      "forgotPassword": "ForgotPassword",
      "login":"Login",
      "google":"Google",
      "apple":"Apple",
      "facebook" : "Facebook",
      "asAGuestUser":"As a Guest User",
      "doNotHaveAnAccount":"Don’t have an account? ",
      "signUp":"Sign up",
      "createNewAccount":"Create new \naccount",
      "fullName":"Full Name",
      "confirmPassword":"Confirm Password",
      "bothPasswordSame":"Both password must be same",
      "alreadyHaveAnAccount":"Already have an account? ",
      "changePassword":"Change Password",
      "newPassword":"New Password",
      "currentPassword":"Current Password",
      "savePassword":"Save Password",
      "editName":"Edit name",
      "editEmail":"Edit Email",
      "editProfile":"Edit Profile",
      "update": "Update",
      "recoverYourPassword":"Recover your \npassword",
      "next":"Next",
      "continueWatching" :"Continue Watching",
      "recommended":"Recommended",
      "seeAll":"See all",
      "search":"Search",
      "emailValidation1": "Enter Email id.",
      "emailValidation2": "Enter Valid Email.",
      "passwordValidation1": "Please enter password.",
      "passwordValidation2": "Password must contain at least 6 characters.",
      "nameValidation": "Enter Name.",
      "confirmPasswordValidation": "Please enter confirm password.",
      "bothPasswordValidation": "Password and confirm password not match.",
      "enterCurrentPassword": "Enter current password",
      "enterNewPassword": "Enter new password.",
      "profileUpdatedSuccessfully": "Profile update successfully.",
      "logout": "Logout",
      "allMovies": "All Movies",
      "ok": "Ok",
      "chooseAnAction": "Choose An Action",
      "takePhoto": "Take Photo",
      "chooseFromGallery": "Choose From Gallery",
      "storyLine": "Storyline",
      "readMore": "Read More",
      "less": "Less",
      "theme": "Theme",
      "changeTheme": "Change Theme",
      "language": "Language",
      "changeLanguage":"Change Language",
      "linkTv":"Link with TV",
      "contactUs":"Contact Us",
      "termsAndCondition":"Terms & Conditions",
      "privacyPolicy":"Privacy Policy"

    },
    'fr': {
      'hello-world': 'Bonjour le monde!',
      "loginToYourProfile": "connectez-vous à votre \nprofil",
      "email": "e-mail",
      "password": "le mot de passe",
      "forgotPassword": "mot de passe oublié",
      "login":"Connexion",
      "google":"Google",
      "apple":"Apple",
      "facebook":"Facebook",
      "asAGuestUser":"En tant qu'utilisateur invité",
      "doNotHaveAnAccount":"Vous n'avez pas de compte?",
      "signUp":"S'inscrire",
      "createNewAccount":"Créer un nouveau \naccount",
      "fullName":"Nom complet",
      "confirmPassword":"Confirmer le mot de passe",
      "bothPasswordSame":"Les deux mots de passe doivent être identiques",
      "alreadyHaveAnAccount":"Vous avez déjà un compte?",
      "changePassword":"Modifier le mot de passe",
      "newPassword":"Nouveau mot de passe",
      "currentPassword":"Mot de passe actuel",
      "savePassword":"Sauvegarder le mot de passe",
      "editName":"Modifier le nom",
      "editEmail":"Modifier l'e-mail",
      "editProfile":"Modifier le profil",
      "update": "Mise à jour",
      "recoverYourPassword":"Récupérez votre \nmot de passe",
      "next": "Suivant",
      "continueWatching":"Continuer à regarder",
      "recommended":"Recommandé",
      "seeAll":"Tout voir",
      "search":"Recherche",
      "emailValidation1": "Entrez l'identifiant de messagerie.",
      "emailValidation2": "Entrez une adresse email valide.",
      "passwordValidation1": "Veuillez entrer le mot de passe.",
      "passwordValidation2": "Le mot de passe doit contenir au moins 6 caractères.",
      "nameValidation": "Entrez le nom.",
      "confirmPasswordValidation": "Veuillez saisir le mot de passe de confirmation.",
      "bothPasswordValidation": "Le mot de passe et le mot de passe de confirmation ne correspondent pas.",
      "enterCurrentPassword": "Entrez le mot de passe actuel",
      "enterNewPassword": "Entrez le nouveau mot de passe.",
      "profileUpdatedSuccessfully": "Mise à jour du profil réussie.",
      "allMovies": "Tous les films",
      "logout": "Déconnexion",
      "ok": "D'accord",
      "chooseAnAction": "Choisir une action",
      "takePhoto": "Prendre une photo",
      "chooseFromGallery": "Choisir dans la galerie",
      "storyLine": "scénario",
      "readMore": "Lire la suite",
      "less": "moins",
      "theme": "Thème",
      "changeTheme": "Changer de thème",
      "language": "Langue",
      "changeLanguage":"changer de langue",
      "linkTv":"Lien avec le téléviseur",
      "contactUs":"Contactez-nous",
      "termsAndCondition":"Conditions d'utilisation",
      "privacyPolicy":"Politique de confidentialité"

    },
    'es': {
      'hello-world': 'Hola mundo!',
      "loginToYourProfile": "Inicia sesión en tu \nperfil",
      "email": "Correo electrónico",
      "password": "Clave",
      "forgotPassword": "Has olvidado tu contraseña",
      "login":"Acceso",
      "google":"Google",
      "apple":"Apple",
      "facebook":"Facebook",
      "asAGuestUser":"Como usuaria invitada",
      "doNotHaveAnAccount":"¿No tienes una cuenta? ",
      "signUp":"Regístrate",
      "createNewAccount":"Crear nueva \ncuenta",
      "fullName":"Nombre completo",
      "confirmPassword":"Confirmar contraseña",
      "bothPasswordSame":"Ambas contraseñas deben ser iguales",
      "alreadyHaveAnAccount":"¿Ya tienes una cuenta?",
      "changePassword":"Cambiar contraseña",
      "newPassword":"Nueva Contraseña",
      "currentPassword":"Contraseña actual",
      "savePassword":"Guardar contraseña",
      "editName":"Editar nombre",
      "editEmail":"Editar correo electrónico",
      "editProfile":"Editar perfil",
      "update": "Actualizar",
      "recoverYourPassword":"Recupera tu \ncontraseña",
      "next": "Siguiente",
      "continueWatching":"Continuar viendo",
      "recommended":"Recomendado",
      "seeAll":"Ver todo",
      "search":"Buscar",
      "emailValidation1": "Ingrese la identificación del correo electrónico.",
      "emailValidation2": "Ingrese un email valido.",
      "passwordValidation1": "Por favor ingrese la contraseña.",
      "passwordValidation2": "La contraseña debe contener al menos 6 caracteres.",
      "nameValidation": "Ingrese el nombre.",
      "confirmPasswordValidation": "Por favor, introduzca la contraseña de confirmación.",
      "bothPasswordValidation": "La contraseña y la confirmación de la contraseña no coinciden.",
      "enterCurrentPassword": "Ingrese la contraseña actual",
      "enterNewPassword": "Ingrese la nueva contraseña.",
      "profileUpdatedSuccessfully": "Actualización de perfil exitosa.",
      "allMovies": "Todas las películas",
      "logout": "Cerrar sesión",
      "ok": "De acuerdo",
      "chooseAnAction": "Elige una acción",
      "takePhoto": "Tomar foto",
      "chooseFromGallery": "Elegir de la galería",
      "storyLine": "Historia",
      "readMore": "Lee mas",
      "less": "menos",
      "theme": "Tema",
      "changeTheme": "Cambiar tema",
      "language": "idioma",
      "changeLanguage":" cambiar idioma",
      "linkTv":"Enlace con TV",
      "contactUs":"Contáctenos",
      "termsAndCondition":"Términos y condiciones",
      "privacyPolicy":"Política de privacidad"
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? '** $key not found';
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ApplicationLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'es'].contains(locale.languageCode);

  @override
  Future<ApplicationLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<ApplicationLocalizations>(
      ApplicationLocalizations(locale),
    );
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}