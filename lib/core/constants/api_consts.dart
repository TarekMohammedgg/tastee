class ApiConsts {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static getMeal(String mealName) {
    return '$baseUrl/filter.php?c=$mealName';
  }

  static getMealDetails(String mealId) {
    return '$baseUrl/lookup.php?i=$mealId';
  }

  static getCategories() {
    return '$baseUrl/categories.php';
  }
}
