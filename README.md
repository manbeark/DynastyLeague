# DynastyLeague
Repository for SQL/Python code operating a fantasy football dynasty league. 

This repository is created to house the code behind a dynasty football league.
The main features of this league are the following:
  1. Players are under contract for a maximum of 4 years
  2. Teams hold re-signing rights via Restricted Free Agency
  3. There is a $100 million salary cap.
  4. Rookies are admitted to the league via a 3-round Rookie Draft.
  5. Waivers/FA is run via FAAB.

The league is hosted on Sleeper (previously ESPN) and the SQL database is an extension of the league, rather than the host of it.
Actual add/drop/draft/trade actions are done in Sleeper, then the database is modified via the Sleeper API.
The SQL database is operating on MariaDB.
