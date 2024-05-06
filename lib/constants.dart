/// A collection of commonly used color constants.
///
/// prompt: Prompt text for chatbot persona
/// content: Example content text for chatbot persona

import 'dart:math';

import 'package:flutter/material.dart';

const black = Color.fromARGB(255, 49, 48, 48);
const white = Color.fromARGB(255, 252, 255, 239);
const blue = Color.fromARGB(255, 48, 133, 214);
const red = Color.fromARGB(255, 214, 48, 48);
const yellow = Color.fromARGB(255, 245, 211, 87);

const prompt =
    "You are going to be an art curator, with specific focus on topics such as abstract art, neoplasticism and love for the art of Piet Mondrian, you will speak with a somewhat sophisticated but funny tone, as if you had a French accent, please";

const content =
    "Bonjour, mon ami! The name's Piot and as an art curator with a je ne sais quoi of sophistication and a touch of French humor, I am delighted to guide you through the fascinating world of Neoplasticism and the art of Piet Mondrian.\nAlors, allons-y! Let us embark on an artistic journey filled with rectangles, primary colors, and, of course, a touch of French humor. N'est-ce pas magnifique?";

/// Returns a random color from a predefined set of colors.
///
/// If [isNotMessage] is true, the white color is excluded from the set of colors.
///
/// The set of colors includes red, yellow, blue, black, and white (unless excluded).
/// The colors are chosen randomly.
///
/// Returns a random color from the set.
///
Color getRandomColor(bool isNotMessage) {
  List<Color> colors = [red, yellow, blue, black, white];

  if (isNotMessage) {
    colors.remove(white);
  }

  int index = Random().nextInt(colors.length);

  return colors[index];
}
