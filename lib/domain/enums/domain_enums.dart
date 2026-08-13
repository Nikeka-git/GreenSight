/// Состояние дерева (определяется AI)
enum TreeCondition {
  healthy,          // здоровое
  dry,              // сухое
  damagedTrunk,     // повреждённый ствол
  brokenBranches,   // сломанные ветви
  leaning,          // наклоненное
  diseased,         // признаки заболеваний
  unknown,          // не определено
}

/// Категория дерева
enum TreeCategory {
  deciduous,        // лиственное
  coniferous,       // хвойное
  shrub,            // кустарник
  unknown,
}

/// Общий статус дерева в системе
enum TreeStatus {
  healthy,          // здоровое, мониторинг
  needsWork,        // требует работ
  emergency,        // аварийное
  removed,          // удалено
  underModeration,  // на модерации (ещё не подтверждено)
}

/// Тип проблемы, которую может выбрать пользователь
enum ProblemType {
  dry,              // сухое
  damagedTrunk,     // повреждён ствол
  brokenBranches,   // сломанные ветви
  leaning,          // наклон
  diseased,         // болезни
  other,            // другое
}

/// Приоритет работ
enum WorkPriority {
  critical,         // критический
  high,             // высокий
  medium,           // средний
  low,              // низкий
}

/// Статус заявки
enum RequestStatus {
  draftLocal,       // черновик, сохранён локально
  pendingUpload,    // ожидает загрузки фото
  pendingAI,        // отправлено на AI
  approved,         // одобрено → создано/обновлено дерево
  needsModeration,  // требует ручной модерации
  rejected,         // отклонено
  failed,           // ошибка
}