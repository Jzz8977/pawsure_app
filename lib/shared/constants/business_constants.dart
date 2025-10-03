class UserType {
  const UserType._();

  static const String customer = 'customer';
  static const String provider = 'provider';

  static const Map<String, String> labels = {customer: '客户', provider: '服务者'};
}

class MemberLevel {
  const MemberLevel._();

  static const String normal = 'normal';
  static const String silver = 'silver';
  static const String gold = 'gold';
  static const String diamond = 'diamond';

  static const Map<String, String> labels = {
    normal: '普通会员',
    silver: '银卡会员',
    gold: '金卡会员',
    diamond: '钻石会员',
  };
}

class ProviderLevel {
  const ProviderLevel._();

  static const int oneStar = 1;
  static const int twoStar = 2;
  static const int threeStar = 3;
  static const int fourStar = 4;
  static const int fiveStar = 5;
}

class AuditStatus {
  const AuditStatus._();

  static const String pending = 'pending';
  static const String approved = 'approved';
  static const String rejected = 'rejected';

  static const Map<String, String> labels = {
    pending: '待审核',
    approved: '已通过',
    rejected: '已拒绝',
  };
}

class OrderStatus {
  const OrderStatus._();

  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String refunded = 'refunded';

  static const Map<String, String> labels = {
    pending: '待接单',
    confirmed: '已确认',
    inProgress: '服务中',
    completed: '已完成',
    cancelled: '已取消',
    refunded: '已退款',
  };
}

class ServiceType {
  const ServiceType._();

  static const String petCheckup = 'pet_checkup';
  static const String vaccination = 'vaccination';
  static const String grooming = 'grooming';
  static const String training = 'training';
  static const String boarding = 'boarding';
  static const String medical = 'medical';
  static const String nutrition = 'nutrition';
  static const String walking = 'walking';

  static const Map<String, String> labels = {
    petCheckup: '宠物体检',
    vaccination: '疫苗接种',
    grooming: '宠物美容',
    training: '宠物训练',
    boarding: '宠物寄养',
    medical: '医疗治疗',
    nutrition: '营养咨询',
    walking: '遛狗服务',
  };
}

class PaymentMethod {
  const PaymentMethod._();

  static const String wechat = 'wechat';
  static const String alipay = 'alipay';
  static const String wallet = 'wallet';

  static const Map<String, String> labels = {
    wechat: '微信支付',
    alipay: '支付宝',
    wallet: '钱包余额',
  };
}

class CouponStatus {
  const CouponStatus._();

  static const String available = 'available';
  static const String used = 'used';
  static const String expired = 'expired';

  static const Map<String, String> labels = {
    available: '可用',
    used: '已使用',
    expired: '已过期',
  };
}

class CheckinType {
  const CheckinType._();

  static const String start = 'start';
  static const String progress = 'progress';
  static const String complete = 'complete';
  static const String exception = 'exception';

  static const Map<String, String> labels = {
    start: '开始服务',
    progress: '服务进度',
    complete: '完成服务',
    exception: '异常上报',
  };
}

class BusinessStatus {
  const BusinessStatus._();

  static const String active = 'active';
  static const String inactive = 'inactive';
  static const String disabled = 'disabled';
  static const String deleted = 'deleted';
}
