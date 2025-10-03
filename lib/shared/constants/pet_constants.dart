class PetType {
  const PetType._();

  static const String dog = 'dog';
  static const String cat = 'cat';
  static const String bird = 'bird';
  static const String fish = 'fish';
  static const String rabbit = 'rabbit';
  static const String hamster = 'hamster';
  static const String other = 'other';

  static const Map<String, String> labels = {
    dog: '狗狗',
    cat: '猫咪',
    bird: '鸟类',
    fish: '鱼类',
    rabbit: '兔子',
    hamster: '仓鼠',
    other: '其他',
  };
}

class PetSize {
  const PetSize._();

  static const String small = 'small';
  static const String medium = 'medium';
  static const String large = 'large';
  static const String giant = 'giant';

  static const Map<String, String> labels = {
    small: '小型犬(<10kg)',
    medium: '中型犬(10-25kg)',
    large: '大型犬(25-40kg)',
    giant: '巨型犬(>40kg)',
  };
}

class PetGender {
  const PetGender._();

  static const String male = 'male';
  static const String female = 'female';
  static const String unknown = 'unknown';

  static const Map<String, String> labels = {
    male: '公',
    female: '母',
    unknown: '未知',
  };
}

class NeuterStatus {
  const NeuterStatus._();

  static const String yes = 'yes';
  static const String no = 'no';
  static const String unknown = 'unknown';

  static const Map<String, String> labels = {
    yes: '已绝育',
    no: '未绝育',
    unknown: '不详',
  };
}

class AgeStage {
  const AgeStage._();

  static const String puppy = 'puppy';
  static const String young = 'young';
  static const String adult = 'adult';
  static const String senior = 'senior';
  static const String unknown = 'unknown';

  static const Map<String, String> labels = {
    puppy: '幼年期',
    young: '青年期',
    adult: '成年期',
    senior: '老年期',
    unknown: '未知',
  };
}

class PetActivityLevel {
  const PetActivityLevel._();

  static const String low = 'low';
  static const String medium = 'medium';
  static const String high = 'high';
  static const String veryHigh = 'very_high';

  static const Map<String, String> labels = {
    low: '低',
    medium: '中等',
    high: '较高',
    veryHigh: '很高',
  };
}

class HealthStatus {
  const HealthStatus._();

  static const String healthy = 'healthy';
  static const String sick = 'sick';
  static const String recovering = 'recovering';
  static const String chronic = 'chronic';
  static const String unknown = 'unknown';

  static const Map<String, String> labels = {
    healthy: '健康',
    sick: '生病',
    recovering: '康复中',
    chronic: '慢性病',
    unknown: '不详',
  };
}

class VaccineStatus {
  const VaccineStatus._();

  static const String complete = 'complete';
  static const String incomplete = 'incomplete';
  static const String overdue = 'overdue';
  static const String unknown = 'unknown';

  static const Map<String, String> labels = {
    complete: '已完成',
    incomplete: '未完成',
    overdue: '已过期',
    unknown: '未知',
  };
}

class FeedingType {
  const FeedingType._();

  static const String dryFood = 'dry_food';
  static const String wetFood = 'wet_food';
  static const String mixed = 'mixed';
  static const String raw = 'raw';
  static const String homemade = 'homemade';
  static const String other = 'other';

  static const Map<String, String> labels = {
    dryFood: '干粮',
    wetFood: '湿粮',
    mixed: '混合喂养',
    raw: '生食',
    homemade: '自制',
    other: '其他',
  };
}

class SpecialNeeds {
  const SpecialNeeds._();

  static const String medication = 'medication';
  static const String dietRestriction = 'diet_restriction';
  static const String exerciseLimitation = 'exercise_limitation';
  static const String behavioralIssue = 'behavioral_issue';
  static const String allergy = 'allergy';
  static const String seniorCare = 'senior_care';
  static const String none = 'none';

  static const Map<String, String> labels = {
    medication: '需要用药',
    dietRestriction: '饮食限制',
    exerciseLimitation: '运动限制',
    behavioralIssue: '行为问题',
    allergy: '过敏体质',
    seniorCare: '老年护理',
    none: '无特殊需求',
  };
}

class PetAvatarDefaults {
  const PetAvatarDefaults._();

  static const Map<String, Object> _values = {
    PetType.dog: {
      PetGender.male: '/assets/images/default-dog-male.png',
      PetGender.female: '/assets/images/default-dog-female.png',
      PetGender.unknown: '/assets/images/default-dog.png',
    },
    PetType.cat: {
      PetGender.male: '/assets/images/default-cat-male.png',
      PetGender.female: '/assets/images/default-cat-female.png',
      PetGender.unknown: '/assets/images/default-cat.png',
    },
    PetType.bird: '/assets/images/default-bird.png',
    PetType.fish: '/assets/images/default-fish.png',
    PetType.rabbit: '/assets/images/default-rabbit.png',
    PetType.hamster: '/assets/images/default-hamster.png',
    PetType.other: '/assets/images/default-pet.png',
  };

  static String? avatarFor(String petType, {String? gender}) {
    final value = _values[petType];
    if (value is String) {
      return value;
    }
    if (value is Map<String, String>) {
      if (gender != null && value.containsKey(gender)) {
        return value[gender];
      }
      return value[PetGender.unknown];
    }
    return null;
  }
}

class PetBreedLibrary {
  const PetBreedLibrary._();

  static const List<String> dogBreeds = [
    '金毛寻回犬',
    '拉布拉多犬',
    '哈士奇',
    '萨摩耶',
    '阿拉斯加',
    '边境牧羊犬',
    '德国牧羊犬',
    '柯基犬',
    '比熊',
    '泰迪',
    '博美',
    '吉娃娃',
    '法斗',
    '柴犬',
    '雪纳瑞',
    '马尔济斯',
    '约克夏',
    '西施犬',
    '巴哥',
    '杜宾',
    '罗威纳',
  ];

  static const List<String> catBreeds = [
    '英国短毛猫',
    '美国短毛猫',
    '苏格兰折耳猫',
    '波斯猫',
    '暹罗猫',
    '布偶猫',
    '缅因猫',
    '俄罗斯蓝猫',
    '阿比西尼亚猫',
    '孟加拉猫',
    '挪威森林猫',
    '土耳其安哥拉猫',
    '中华田园猫',
    '加菲猫',
    '孟买猫',
    '德文卷毛猫',
    '新加坡猫',
    '埃及猫',
  ];
}
