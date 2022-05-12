DROP TABLE IF EXISTS iris_data;
CREATE TABLE iris_data (
  id SERIAL PRIMARY KEY
  , sepal_length FLOAT NOT NULL, sepal_width FLOAT NOT NULL
  , petal_length FLOAT NOT NULL, petal_width FLOAT NOT NULL
  , species VARCHAR(100) NOT NULL
);

\COPY iris_data (sepal_length, sepal_width, petal_length, petal_width, species) FROM '{pwd}/iris.csv' CSV HEADER;
