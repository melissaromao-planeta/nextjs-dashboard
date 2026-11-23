CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  image_url VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS invoices (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  customer_id UUID NOT NULL,
  amount INT NOT NULL,
  status VARCHAR(255) NOT NULL,
  date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS revenue (
  month VARCHAR(4) NOT NULL UNIQUE,
  revenue INT NOT NULL
);

INSERT INTO users (id, name, email, password)
VALUES (
  '410544b2-4001-4271-9855-fec4b6a6442a',
  'User',
  'user@nextmail.com',
  crypt('123456', gen_salt('bf', 10))
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO customers (id, name, email, image_url)
VALUES
  ('d6e15727-9fe1-4961-8c5b-ea44a9bd81aa', 'Evil Rabbit', 'evil@rabbit.com', '/customers/evil-rabbit.png'),
  ('3958dc9e-712f-4377-85e9-fec4b6a6442a', 'Delba de Oliveira', 'delba@oliveira.com', '/customers/delba-de-oliveira.png'),
  ('3958dc9e-742f-4377-85e9-fec4b6a6442a', 'Lee Robinson', 'lee@robinson.com', '/customers/lee-robinson.png'),
  ('76d65c26-f784-44a2-ac19-586678f7c2f2', 'Michael Novotny', 'michael@novotny.com', '/customers/michael-novotny.png'),
  ('cc27c14a-0acf-4f4a-a6c9-d45682c144b9', 'Amy Burns', 'amy@burns.com', '/customers/amy-burns.png'),
  ('13d07535-c59e-4157-a011-f8d2ef4e0cbb', 'Balazs Orban', 'balazs@orban.com', '/customers/balazs-orban.png')
ON CONFLICT (id) DO NOTHING;

INSERT INTO invoices (id, customer_id, amount, status, date)
VALUES
  ('00000000-0000-4000-8000-000000000001', 'd6e15727-9fe1-4961-8c5b-ea44a9bd81aa', 15795, 'pending', '2022-12-06'),
  ('00000000-0000-4000-8000-000000000002', '3958dc9e-712f-4377-85e9-fec4b6a6442a', 20348, 'pending', '2022-11-14'),
  ('00000000-0000-4000-8000-000000000003', 'cc27c14a-0acf-4f4a-a6c9-d45682c144b9', 3040, 'paid', '2022-10-29'),
  ('00000000-0000-4000-8000-000000000004', '76d65c26-f784-44a2-ac19-586678f7c2f2', 44800, 'paid', '2023-09-10'),
  ('00000000-0000-4000-8000-000000000005', '13d07535-c59e-4157-a011-f8d2ef4e0cbb', 34577, 'pending', '2023-08-05'),
  ('00000000-0000-4000-8000-000000000006', '3958dc9e-742f-4377-85e9-fec4b6a6442a', 54246, 'pending', '2023-07-16'),
  ('00000000-0000-4000-8000-000000000007', 'd6e15727-9fe1-4961-8c5b-ea44a9bd81aa', 666, 'pending', '2023-06-27'),
  ('00000000-0000-4000-8000-000000000008', '76d65c26-f784-44a2-ac19-586678f7c2f2', 32545, 'paid', '2023-06-09'),
  ('00000000-0000-4000-8000-000000000009', 'cc27c14a-0acf-4f4a-a6c9-d45682c144b9', 1250, 'paid', '2023-06-17'),
  ('00000000-0000-4000-8000-000000000010', '13d07535-c59e-4157-a011-f8d2ef4e0cbb', 8546, 'paid', '2023-06-07'),
  ('00000000-0000-4000-8000-000000000011', '3958dc9e-712f-4377-85e9-fec4b6a6442a', 500, 'paid', '2023-08-19'),
  ('00000000-0000-4000-8000-000000000012', '13d07535-c59e-4157-a011-f8d2ef4e0cbb', 8945, 'paid', '2023-06-03'),
  ('00000000-0000-4000-8000-000000000013', '3958dc9e-742f-4377-85e9-fec4b6a6442a', 1000, 'paid', '2022-06-05')
ON CONFLICT (id) DO NOTHING;

INSERT INTO revenue (month, revenue)
VALUES
  ('Jan', 2000),
  ('Feb', 1800),
  ('Mar', 2200),
  ('Apr', 2500),
  ('May', 2300),
  ('Jun', 3200),
  ('Jul', 3500),
  ('Aug', 3700),
  ('Sep', 2500),
  ('Oct', 2800),
  ('Nov', 3000),
  ('Dec', 4800)
ON CONFLICT (month) DO NOTHING;
