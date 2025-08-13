-- Сверка броней и оплат (переплаты/недоплаты)
-- Дано (DDL):
CREATE TABLE users (
  user_id           BIGINT PRIMARY KEY,
  registration_date DATE NOT NULL,
  campaign_key      BIGINT,
  country           TEXT
);

CREATE TABLE bookings (
  booking_id     BIGINT PRIMARY KEY,
  user_id        BIGINT NOT NULL REFERENCES users(user_id),
  room_id        BIGINT,
  check_in_date  DATE,
  check_out_date DATE,
  total_price    NUMERIC(12,2),
  booking_status TEXT
);

CREATE TABLE payments (
  payment_id     BIGINT PRIMARY KEY,
  booking_id     BIGINT NOT NULL REFERENCES bookings(booking_id),
  payment_date   DATE NOT NULL,
  amount         NUMERIC(12,2) NOT NULL,
  payment_method TEXT,
  card_type      TEXT
);
-- Задание:
-- Для каждой брони собрать сумму оплат и сравнить с total_price. Вывести только несоответствия.
-- Вывод: booking_id, total_price, paid_amount, delta (где delta = paid_amount - total_price), отсортировать по ABS(delta) убыв.


-- 2) Первый отзыв по каждому отелю
-- Дано (DDL):
CREATE TABLE hotel (
  hotel_id   BIGINT PRIMARY KEY,
  name       TEXT NOT NULL,
  city       TEXT,
  address    TEXT,
  rating     NUMERIC(3,2),
  room_count INT,
  created_at DATE
);

CREATE TABLE reviews (
  review_id    BIGINT PRIMARY KEY,
  user_id      BIGINT REFERENCES users(user_id),
  hotel_id     BIGINT NOT NULL REFERENCES hotel(hotel_id),
  rating       NUMERIC(3,2) NOT NULL,
  comment      TEXT,
  review_date  DATE NOT NULL,
  review_detail JSONB
);
-- Задание:
-- Найти самый ранний отзыв по каждому отелю и показать его рейтинг.
-- Вывод: hotel_id, name, first_review_date, first_rating.

-- 3) Пересчёт рейтинга отеля и сравнение с сохранённым
-- Дано (DDL): (те же таблицы, что в задаче 2)
CREATE TABLE hotel (
  hotel_id   BIGINT PRIMARY KEY,
  name       TEXT NOT NULL,
  city       TEXT,
  address    TEXT,
  rating     NUMERIC(3,2),
  room_count INT,
  created_at DATE
);

CREATE TABLE reviews (
  review_id    BIGINT PRIMARY KEY,
  user_id      BIGINT REFERENCES users(user_id),
  hotel_id     BIGINT NOT NULL REFERENCES hotel(hotel_id),
  rating       NUMERIC(3,2) NOT NULL,
  comment      TEXT,
  review_date  DATE NOT NULL,
  review_detail JSONB
);
-- Задание:
-- Посчитать фактический средний рейтинг отеля по отзывам и сравнить с полем hotel.rating.
-- Вывод: hotel_id, name, rating_actual, rating_stored, delta (где delta = rating_actual - rating_stored).

-- 4) Net-выручка по типу карты с «последней» ставкой
-- Дано (DDL):

CREATE TABLE payments (
  payment_id     BIGINT PRIMARY KEY,
  booking_id     BIGINT NOT NULL REFERENCES bookings(booking_id),
  payment_date   DATE NOT NULL,
  amount         NUMERIC(12,2) NOT NULL,
  payment_method TEXT,
  card_type      TEXT
);

CREATE TABLE payments_rates (
  id             BIGINT PRIMARY KEY,
  rate_date      DATE NOT NULL,
  payment_method TEXT NOT NULL,
  card_type      TEXT,
  acquirr_fee    NUMERIC(6,4) NOT NULL,  -- доля (0.0123 = 1.23%)
  service_fee    NUMERIC(6,4) NOT NULL   -- доля (0.0500 = 5.00%)
);

-- Задание:
-- Для каждой строки payments применить актуальную на сегодня последнюю ставку по паре (payment_method, card_type) из payments_rates и посчитать
-- net = amount * (1 - (acquirr_fee + service_fee)). Затем агрегировать по (payment_method, card_type).
-- Вывод: payment_method, card_type, net_amount.

-- 5) Нумерация броней пользователя по дате заезда
-- Дано (DDL):
CREATE TABLE users (
  user_id           BIGINT PRIMARY KEY,
  registration_date DATE NOT NULL,
  campaign_key      BIGINT,
  country           TEXT
);

CREATE TABLE bookings (
  booking_id     BIGINT PRIMARY KEY,
  user_id        BIGINT NOT NULL REFERENCES users(user_id),
  room_id        BIGINT,
  check_in_date  DATE,
  check_out_date DATE,
  total_price    NUMERIC(12,2),
  booking_status TEXT
);
-- Задание:
-- Пронумеровать брони каждого пользователя по возрастанию check_in_date.
-- Вывод: user_id, booking_id, check_in_date, rn.

-- 6) Первая оплата пользователя
-- Дано (DDL):
CREATE TABLE bookings (
  booking_id     BIGINT PRIMARY KEY,
  user_id        BIGINT NOT NULL REFERENCES users(user_id),
  room_id        BIGINT,
  check_in_date  DATE,
  check_out_date DATE,
  total_price    NUMERIC(12,2),
  booking_status TEXT
);

CREATE TABLE payments (
  payment_id     BIGINT PRIMARY KEY,
  booking_id     BIGINT NOT NULL REFERENCES bookings(booking_id),
  payment_date   DATE NOT NULL,
  amount         NUMERIC(12,2) NOT NULL,
  payment_method TEXT,
  card_type      TEXT
);
-- Задание:
-- Найти первую оплату каждого пользователя (по дате).
-- Вывод: user_id, first_payment_date, first_payment_amount.

-- 7) Средний чек пользователя и отклонение от общего среднего
-- Дано (DDL): (те же таблицы, что в задаче 6)

CREATE TABLE bookings (
  booking_id     BIGINT PRIMARY KEY,
  user_id        BIGINT NOT NULL REFERENCES users(user_id),
  room_id        BIGINT,
  check_in_date  DATE,
  check_out_date DATE,
  total_price    NUMERIC(12,2),
  booking_status TEXT
);

CREATE TABLE payments (
  payment_id     BIGINT PRIMARY KEY,
  booking_id     BIGINT NOT NULL REFERENCES bookings(booking_id),
  payment_date   DATE NOT NULL,
  amount         NUMERIC(12,2) NOT NULL,
  payment_method TEXT,
  card_type      TEXT
);

-- Задание:
-- Посчитать средний размер платежа для каждого пользователя и сравнить с общим средним по всем платежам.
-- Вывод: user_id, avg_amount_user, avg_amount_all, diff (где diff = avg_amount_user - avg_amount_all).
