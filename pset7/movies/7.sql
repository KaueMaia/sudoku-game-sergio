SELECT title, rating.ratings FROM movies JOIN (SELECT * FROM ratings ORDER BY rating ASC) ON id=movie_id WHERE year=2010;
