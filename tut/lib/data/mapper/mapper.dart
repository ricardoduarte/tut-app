import 'package:tut/app/extensions.dart';
import 'package:tut/domain/model.dart';
import 'package:tut/data/responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this?.id?.orEmpty() ?? '', this?.name?.orEmpty() ?? '',
        this?.numOfNotifications?.orZero() ?? 0);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? '', this?.phone?.orEmpty() ?? '',
        this?.link?.orEmpty() ?? '');
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}
