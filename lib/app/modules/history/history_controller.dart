import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryBase with _$HistoryController;

abstract class _HistoryBase with Store {
  ILocalStorage _storage;
  int lastCurrentIndex;
  bool listFinished = false;

  _HistoryBase({ILocalStorage storage}) {
    _storage = storage ?? Modular.get();

    init();
  }

  @observable
  List<Movement> movements = <Movement>[].asObservable();

  @action
  init() async {
    lastCurrentIndex = await _storage.getLastMovementIndex();
    getNextMovements();
  }

  getNextMovements() async {
    List<Movement> newMovements = (await _storage.getMovements(startIndex: lastCurrentIndex, desc: true)) ?? <Movement>[];
    lastCurrentIndex -= newMovements.length;
    listFinished = (newMovements.length < ILocalStorage.kMovementsPageCount);
    movements += newMovements.asObservable();
  }
}