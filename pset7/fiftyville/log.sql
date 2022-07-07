-- Keep a log of any SQL queries you execute as you solve the mystery.

-- checking crimes on 288/07/2021 at Humphrey Street
    -- SELECT * FROM crime_scene_reports WHERE day=28 AND month=07 AND year=2021 AND street='Humphrey Street'
    -- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    -- | id  | year | month | day |     street      |                                                                                                       description                                                                                                        |
    -- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    -- | 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
    -- | 297 | 2021 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.                                                                                                                                                                       |
    -- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

-- cheking interviews
    -- SELECT * FROM interviews WHERE day=28 AND month=07 AND year=2021 AND transcript LIKE "%bakery%"
    -- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    -- | id  |  name   | year | month | day |                                                                                                                                                     transcript                                                                                                                                                      |
    -- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
    -- | 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
    -- | 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
    -- | 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
    -- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

--check first interview -> security camera
    -- SELECT * FROM bakery_security_logs WHERE day=28 AND month=07 AND year=2021 AND activity='exit' AND hour=10
    -- +-----+------+-------+-----+------+--------+----------+---------------+
    -- | id  | year | month | day | hour | minute | activity | license_plate |
    -- +-----+------+-------+-----+------+--------+----------+---------------+
    -- | 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
    -- | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
    -- | 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
    -- | 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
    -- | 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
    -- | 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
    -- | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
    -- | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
    -- | 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
    -- +-----+------+-------+-----+------+--------+----------+---------------+

--check second interview -> atm_transactions
    -- SELECT * FROM atm_transactions WHERE day=28 AND month=07 AND year=2021 AND atm_location LIKE "%Humphrey%" AND transaction_type='withdraw'
    -- +-----+----------------+------+-------+-----+---------------+------------------+--------+
    -- | id  | account_number | year | month | day | atm_location  | transaction_type | amount |
    -- +-----+----------------+------+-------+-----+---------------+------------------+--------+
    -- | 245 | 90209473       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 45     |
    -- | 247 | 41935128       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 15     |
    -- | 255 | 66344537       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 55     |
    -- | 258 | 92647903       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 5      |
    -- | 262 | 40665580       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 35     |
    -- | 265 | 96336648       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 20     |
    -- | 273 | 69638157       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 20     |
    -- | 276 | 13156006       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 15     |
    -- | 277 | 89843009       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 40     |
    -- | 280 | 92647903       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 40     |
    -- | 281 | 57022441       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 55     |
    -- | 290 | 79165736       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 5      |
    -- | 291 | 76849114       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 10     |
    -- | 300 | 66344537       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 60     |
    -- | 302 | 50380485       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 100    |
    -- | 309 | 46222318       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 60     |
    -- | 310 | 58673910       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 10     |
    -- | 312 | 93903397       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 35     |
    -- | 315 | 79127781       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 65     |
    -- | 316 | 95773068       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 45     |
    -- | 322 | 26797365       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 35     |
    -- | 329 | 34939061       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 100    |
    -- | 333 | 65190958       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 50     |
    -- | 334 | 99031604       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 20     |
    -- | 337 | 58552019       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 30     |
    -- | 342 | 55322348       | 2021 | 7     | 28  | Humphrey Lane | withdraw         | 5      |
    -- +-----+----------------+------+-------+-----+---------------+------------------+--------+

    --name of people withdraw money
--     SELECT id, name FROM people WHERE id IN

--     (SELECT person_id from bank_accounts where account_number in
--     (SELECT account_number FROM atm_transactions WHERE day=28 AND month=07 AND
--     year=2021 AND atm_location LIKE "%Humphrey%" AND transaction_type='withdraw')) order by name ASC
    -- +--------+-----------+
    -- |   id   |   name    |
    -- +--------+-----------+
    -- | 630782 | Alexis    |
    -- | 632023 | Amanda    |
    -- | 929343 | Andrea    |
    -- | 837455 | Andrew    |
    -- | 484375 | Anna      |
    -- | 769190 | Charles   |
    -- | 274893 | Christina |
    -- | 652412 | Denise    |
    -- | 713341 | Donna     |
    -- | 757606 | Douglas   |
    -- | 229572 | Ernest    |
    -- | 779942 | Harold    |
    -- | 567218 | Jack      |
    -- | 336397 | Joan      |
    -- | 274388 | Laura     |
    -- | 985539 | Lisa      |
    -- | 637069 | Michelle  |
    -- | 572028 | Paul      |
    -- | 704850 | Rachel    |
    -- | 341739 | Rebecca   |
    -- | 293753 | Ryan      |
    -- | 920334 | Stephen   |
    -- | 539960 | Theresa   |
    -- | 506435 | Zachary   |
    -- +--------+-----------+

--check third interview -> flights
    -- SELECT * FROM flights WHERE day=29 AND month=07 AND year=2021
    -- +----+-------------------+------------------------+------+-------+-----+------+--------+
    -- | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
    -- +----+-------------------+------------------------+------+-------+-----+------+--------+
    -- | 18 | 8                 | 6                      | 2021 | 7     | 29  | 16   | 0      |
    -- | 23 | 8                 | 11                     | 2021 | 7     | 29  | 12   | 15     |
    -- | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
    -- | 43 | 8                 | 1                      | 2021 | 7     | 29  | 9    | 30     |
    -- | 53 | 8                 | 9                      | 2021 | 7     | 29  | 15   | 20     |
    -- +----+-------------------+------------------------+------+-------+-----+------+--------+

    --check third interview -> flights -> passengers
    -- SELECT id, name from people where passport_number in

    -- (SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE day=29 AND month=07 AND year=2021)) order by name ASC

    -- +--------+-----------+
    -- |   id   |   name    |
    -- +--------+-----------+
    -- | 325548 | Brandon   |
    -- | 458378 | Brooke    |
    -- | 686048 | Bruce     |
    -- | 423393 | Carol     |
    -- | 769190 | Charles   |
    -- | 952462 | Christian |
    -- | 750165 | Daniel    |
    -- | 447494 | Dennis    |
    -- | 514354 | Diana     |
    -- | 953679 | Doris     |
    -- | 757606 | Douglas   |
    -- | 651714 | Edward    |
    -- | 788213 | Emily     |
    -- | 682850 | Ethan     |
    -- | 788911 | Gloria    |
    -- | 210641 | Heather   |
    -- | 753885 | Jennifer  |
    -- | 677698 | John      |
    -- | 210245 | Jordan    |
    -- | 809265 | Jose      |
    -- | 560886 | Kelsey    |
    -- | 395717 | Kenny     |
    -- | 253397 | Kristina  |
    -- | 251693 | Larry     |
    -- | 467400 | Luca      |
    -- | 354903 | Marilyn   |
    -- | 619074 | Matthew   |
    -- | 626361 | Melissa   |
    -- | 542503 | Michael   |
    -- | 205082 | Pamela    |
    -- | 341739 | Rebecca   |
    -- | 710572 | Richard   |
    -- | 398010 | Sofia     |
    -- | 745650 | Sophia    |
    -- | 676919 | Steven    |
    -- | 449774 | Taylor    |
    -- | 660982 | Thomas    |
    -- +--------+-----------+

---CREATE INTERSECT BETWEEN WITHDRAW LIST AND PASSENGERS:

    -- SELECT id, name FROM people WHERE id IN

    -- (SELECT person_id from bank_accounts where account_number in
    -- (SELECT account_number FROM atm_transactions WHERE day=28 AND month=07 AND
    -- year=2021 AND atm_location LIKE "%Humphrey%" AND transaction_type='withdraw'))

    -- INTERSECT SELECT id, name from people where passport_number in

    -- (SELECT passport_number FROM passengers WHERE flight_id IN (SELECT id FROM flights WHERE day=29 AND month=07 AND year=2021))

-- +--------+---------+
-- |   id   |  name   |
-- +--------+---------+
-- | 341739 | Rebecca |
-- | 757606 | Douglas |
-- | 769190 | Charles |
-- +--------+---------+




--check third interview -> phone_calls
-- SELECT * FROM phone_calls   day=29 AND month=07 AND year=2021 AND duration<=60
-- +-----+----------------+----------------+------+-------+-----+----------+
-- | id  |     caller     |    receiver    | year | month | day | duration |
-- +-----+----------------+----------------+------+-------+-----+----------+
-- | 300 | (558) 555-9741 | (801) 555-9266 | 2021 | 7     | 29  | 45       |
-- | 301 | (211) 555-3762 | (956) 555-1395 | 2021 | 7     | 29  | 47       |
-- | 309 | (547) 555-8781 | (337) 555-9411 | 2021 | 7     | 29  | 46       |
-- | 313 | (344) 555-9601 | (340) 555-8872 | 2021 | 7     | 29  | 48       |
-- | 317 | (910) 555-3251 | (579) 555-5030 | 2021 | 7     | 29  | 32       |
-- | 324 | (831) 555-0973 | (033) 555-9033 | 2021 | 7     | 29  | 57       |
-- | 353 | (901) 555-8732 | (487) 555-5865 | 2021 | 7     | 29  | 35       |
-- +-----+----------------+----------------+------+-------+-----+----------+

--check third interview -> people from caller phone number
-- SELECT * FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE day=29 AND month=07 AND year=2021 AND duration<=60)
--check license_plate with security camera -> stolen car
-- +--------+------------+----------------+-----------------+---------------+
-- |   id   |    name    |  phone_number  | passport_number | license_plate |
-- +--------+------------+----------------+-----------------+---------------+
-- | 274893 | Christina  | (547) 555-8781 | 4322787338      | 79X5400       |
-- | 293753 | Ryan       | (901) 555-8732 |                 | 0WZS77X       |
-- | 331126 | Brenda     | (831) 555-0973 | 1139561952      | N7M42GP       |
-- | 617509 | Jerry      | (558) 555-9741 | 3816396248      | 4DD691O       |
-- | 692353 | Jonathan   | (211) 555-3762 | 2047409662      | 7627B71       |
-- | 712712 | Jacqueline | (910) 555-3251 |                 | 43V0R5D       |
-- | 985497 | Deborah    | (344) 555-9601 | 8714200946      | 10I5658       |
-- +--------+------------+----------------+-----------------+---------------+

-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | id  | year | month | day | hour | minute | activity | license_plate |
-- +-----+------+-------+-----+------+--------+----------+---------------+
-- | 260 | 2021 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
-- | 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
-- | 262 | 2021 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
-- | 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
-- | 264 | 2021 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
-- | 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
-- | 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
-- | 267 | 2021 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
-- | 268 | 2021 | 7     | 28  | 10   | 35     | exit     | 1106N58       |
-- +-----+------+-------+-----+------+--------+----------+---------------+

--list all passport numbers from callers
-- SELECT flight_id, seat, passport_number from passengers where flight_id IN (SELECT id FROM flights WHERE day=29 AND month=07 AND year=2021)
-- +-----------+------+-----------------+
-- | flight_id | seat | passport_number |
-- +-----------+------+-----------------+
-- | 18        | 9C   | 2835165196      |
-- | 18        | 2C   | 6131360461      |
-- | 18        | 3C   | 3231999695      |
-- | 18        | 4C   | 3592750733      |
-- | 18        | 5D   | 2626335085      |
-- | 18        | 6B   | 6117294637      |
-- | 18        | 7A   | 2996517496      |
-- | 18        | 8D   | 3915621712      |
-- | 23        | 7D   | 4149859587      |
-- | 23        | 8A   | 9183348466      |
-- | 23        | 9B   | 7378796210      |
-- | 23        | 2C   | 7874488539      |
-- | 23        | 3A   | 4195341387      |
-- | 23        | 4A   | 6263461050      |
-- | 23        | 5A   | 3231999695      |
-- | 23        | 6B   | 7951366683      |
-- | 36        | 2A   | 7214083635      |
-- | 36        | 3B   | 1695452385      |
-- | 36        | 4A   | 5773159633      |
-- | 36        | 5C   | 1540955065      |
-- | 36        | 6C   | 8294398571      |
-- | 36        | 6D   | 1988161715      |
-- | 36        | 7A   | 9878712108      |
-- | 36        | 7B   | 8496433585      |
-- | 43        | 7B   | 7597790505      |
-- | 43        | 8A   | 6128131458      |
-- | 43        | 9A   | 6264773605      |
-- | 43        | 2C   | 3642612721      |
-- | 43        | 3B   | 4356447308      |
-- | 43        | 4A   | 7441135547      |
-- | 53        | 9B   | 7894166154      |
-- | 53        | 2C   | 6034823042      |
-- | 53        | 3D   | 4408372428      |
-- | 53        | 4D   | 2312901747      |
-- | 53        | 5A   | 1151340634      |
-- | 53        | 6D   | 8174538026      |
-- | 53        | 7A   | 1050247273      |
-- | 53        | 8C   | 7834357192      |
-- +-----------+------+-----------------+

--flight_id dos passageiros com o numero de telefone do caller
-- SELECT flight_id, passport_number FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE day=29 AND month=07 AND year=2021 AND duration<=60));
-- +-----------+------+-----------------+
-- | flight_id | seat | passport_number |
-- +-----------+------+-----------------+
-- | 9         | 5D   | 3816396248      |
-- | 14        | 9B   | 2047409662      |
-- | 22        | 2C   | 8714200946      |
-- | 29        | 6B   | 1139561952      |
-- | 32        | 8C   | 3816396248      |
-- | 46        | 7A   | 3816396248      |
-- | 51        | 3A   | 2047409662      |
-- | 55        | 3D   | 1139561952      |
-- | 55        | 4A   | 3816396248      |
-- | 56        | 2A   | 2047409662      |
-- +-----------+------+-----------------+

-- +--------+------------+----------------+-----------------+---------------+
-- |   id   |    name    |  phone_number  | passport_number | license_plate |
-- +--------+------------+----------------+-----------------+---------------+
-- | 274893 | Christina  | (547) 555-8781 | 4322787338      | 79X5400       |
-- | 293753 | Ryan       | (901) 555-8732 |                 | 0WZS77X       |
-- | 331126 | Brenda     | (831) 555-0973 | 1139561952      | N7M42GP       |
-- | 617509 | Jerry      | (558) 555-9741 | 3816396248      | 4DD691O       |
-- | 692353 | Jonathan   | (211) 555-3762 | 2047409662      | 7627B71       |
-- | 712712 | Jacqueline | (910) 555-3251 |                 | 43V0R5D       |
-- | 985497 | Deborah    | (344) 555-9601 | 8714200946      | 10I5658       |
-- +--------+------------+----------------+-----------------+---------------+