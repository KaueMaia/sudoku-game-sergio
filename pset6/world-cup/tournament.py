# Simulate a sports tournament

import csv
import sys
import random

# Number of simluations to run
N = 1000


def main():

    # Ensure correct usage
    if len(sys.argv) != 2:
        sys.exit("Usage: python tournament.py FILENAME")

    teams = []
    counts = {}
    # TODO: Read teams into memory from file
    with open(sys.argv[1], "r") as dbfile:
        database_reader = csv.DictReader(dbfile)
        for row in database_reader:
            row['team'] = {'rating':int(row['rating'])}
            teams.append(row['team'])
            #counts[row['team']] = int(row['rating'])
    print(simulate_round(teams))
    # print(teams)
    # print(teams[0])
    #print(teams[0]['Norway']['rating'])

    # TODO: Simulate N tournaments and keep track of win counts
    i = 0
    while i < 2:
        winner = simulate_tournament(teams)
        print(winner)
        #print(counts[winner])
        # if winner in counts:
        #     counts[winner] += 1
        # else:
        #     counts[winner] = 1
        i += 1


    # Print each team's chances of winning, according to simulation
    for team in sorted(counts, key=lambda team: counts[team], reverse=True):
        print(f"{team}: {int(counts[team]) * 100 / N:.1f}% chance of winning")


def simulate_game(team1, team2):
    """Simulate a game. Return True if team1 wins, False otherwise."""
    rating1 = team1["rating"]
    rating2 = team2["rating"]
    probability = 1 / (1 + 10 ** ((rating2 - rating1) / 600))
    return random.random() < probability


def simulate_round(teams):
    """Simulate a round. Return a list of winning teams."""
    winners = []

    # Simulate games for all pairs of teams
    for i in range(0, len(teams), 2):
        if simulate_game(teams[i], teams[i + 1]):
            winners.append(teams[i])
        else:
            winners.append(teams[i + 1])

    return winners


def simulate_tournament(teams):
    """Simulate a tournament. Return name of winning team."""
    # TODO
    winners = teams
    while (len(winners) < 2):
        winners = simulate_round(winners)
    return winners[0]


if __name__ == "__main__":
    main()
