# задача 1
# Нормализовать (обрезать пробелы, привести к lower).
# Отфильтровать невалидные (ровно один @, непустые части, латиница/кириллица допускаются).
# Получить уникальные домены (отсорт.) и таблицу частот: domain, cnt, share.
emails = [
 "  IVANOV@Gmail.com ", "petrova+yandex@yandex.ru", "john.doe@mail.ru",
 "anna@test.com", "bad@", "no-at-symbol", "почта@пример.рф"
]

# задача 2
# Посчитай, сколько всего заказов сделал каждый пользователь и какова его средняя сумма заказа.
# Верни результат в виде DataFrame с колонками: user_id, orders_count, avg_order_value.

df = pd.DataFrame({
  "user_id": [1, 2, 1, 3, 2, 4, 2, None],
  "order_value": [500, 700, 200, 900, 100, 300, -50, "800"]
})


# задача 3
# Отфильтруй всех пользователей из России старше 18 лет.
df = pd.DataFrame({
  "user_id": [1,2,3,4,5],
  "birthdate": ["1998-03-10","2008/07/01","1989-12-30", None, "2007-01-15"],
  "country": ["RU","ru","Russia","US", " Ru "]
})

# задача 4
# Посчитай, сколько уникальных дней логинился каждый пользователь.
# Верни DataFrame с колонками: user_id, active_days.

df = pd.DataFrame({
  "user_id": [1,2,1,3,2,1,1],
  "login_time": ["2023-01-01 23:50:00+03:00","2023-01-01 01:10:00Z","2023-01-02",
                 "2023-01-03","2023-01-03","2023-01-05","2023-01-05 23:59:59"]
})

# задача 5
# Суммировать оплаты по booking_id, слева присоединить к bookings.
# Посчитать delta = paid_amount - total_price, вывести только delta != 0 (переплаты/недоплаты).
# Вернуть booking_id, user_id, total_price, paid_amount, delta, отсортировать по |delta| убыв
bookings = pd.DataFrame({
  "booking_id":[10,11,12,13],
  "user_id":[1,1,2,3],
  "total_price":[700, 500, 900, 300]
})
payments = pd.DataFrame({
  "payment_id":[100,101,102,103,104],
  "booking_id":[10,10,11,12,12],
  "amount":[200,500,500,600,300]
})

# задача 6
# Смёржить по payment_method, card_type.
# Посчитать net_amount = amount * (1 - (acquirr_fee + service_fee)).
# Итог — агрегировать net_amount по payment_method, card_type.
payments = pd.DataFrame({
 "payment_id":[1,2,3,4],
 "payment_method":["card","card","bank","card"],
 "card_type":["visa","mc","-", "visa"],
 "amount":[1000,2000,1500,500]
})
rates = pd.DataFrame({
 "payment_method":["card","card","bank"],
 "card_type":["visa","mc","-"],
 "acquirr_fee":[0.01,0.015,0.005],
 "service_fee":[0.05,0.05,0.03]
})

