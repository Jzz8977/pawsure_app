class LivingType {
  const LivingType._();

  static const String apartment = 'apartment';
  static const String villa = 'villa';
  static const String petShop = 'pet_shop';
  static const String other = 'other';

  static const Map<String, String> labels = {
    apartment: '公寓',
    villa: '别墅',
    petShop: '宠物店',
    other: '其他',
  };
}

class LivingCondition {
  const LivingCondition._();

  static const String cage = 'cage';
  static const String fence = 'fence';
  static const String free = 'free';

  static const Map<String, String> labels = {
    cage: '笼子',
    fence: '围栏',
    free: '自由活动',
  };
}

class LivingActivityLevel {
  const LivingActivityLevel._();

  static const String high = 'high';
  static const String medium = 'medium';
  static const String low = 'low';

  static const Map<String, String> labels = {high: '高', medium: '中', low: '低'};
}

class MedicationNeed {
  const MedicationNeed._();

  static const String none = 'none';
  static const String medicine = 'medicine';
  static const String nutrition = 'nutrition';

  static const Map<String, String> labels = {
    none: '无',
    medicine: '按时服药',
    nutrition: '需要营养品',
  };
}
