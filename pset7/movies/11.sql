SELECT title FROM movies JOIN stars ON movies.id=stars.movie_id JOIN people ON stars.people_id=people.id