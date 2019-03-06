using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.IO;

namespace ChessTools
{
    public class PGNReader
    {
        /*Flag will be used to determine if we've created a games object or not*/
        int flag = 0;
        string line;
        /*Returns all the text*/
        string EventName;
        string Site;
        string WhiteName;
        string BlackName;
        string Result;
        string WhiteElo;
        string BlackElo;
        string EventDate;
        string listOfMoves = "";

        

        int bElo;
        int wElo;

        List<ChessGame> myGames = new List<ChessGame>();


        /// <summary>
        /// Returns an iterable list of ChessGames given a PGN File
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public List<ChessGame> Reader(string file)
        {
            System.IO.StreamReader fileTest = new System.IO.StreamReader(file);
            string[] capture = new string[3];

            while ((line = fileTest.ReadLine()) != null)
            {
                if (line.StartsWith("[Event "))
                {
                    capture = line.Split('\"');
                    EventName = capture[1];
                }
                else if (line.StartsWith("[Site "))
                {
                    capture = line.Split('\"');
                    Site = capture[1];
                }
                else if (line.StartsWith("[White "))
                {
                    capture = line.Split('\"');
                    WhiteName = capture[1];
                }
                else if (line.StartsWith("[Black "))
                {
                    capture = line.Split('\"');
                    BlackName = capture[1];
                }
                else if (line.StartsWith("[Result "))
                {
                    capture = line.Split('\"');
                    Result = capture[1];
                    if(Result == "1-0")
                    {
                        Result = "W";
                    }
                    else if (Result == "0-1")
                    {
                        Result = "B";
                    }
                    else
                    {
                        Result = "D";
                    }
                }
                else if (line.StartsWith("[WhiteElo "))
                {
                    capture = line.Split('\"');
                    WhiteElo = capture[1];
                }
                else if (line.StartsWith("[BlackElo "))
                {
                    capture = line.Split('\"');
                    BlackElo = capture[1];
                }
                else if (line.StartsWith("[EventDate "))
                {
                    capture = line.Split('\"');
                    EventDate = capture[1];
                }
                else if (String.IsNullOrEmpty(line)) //Blank line moves are next
                {
                    if(flag == 0)
                    {
                        flag = 1;
                    }
                    else
                    {
                        Int32.TryParse(BlackElo, out bElo);
                        Int32.TryParse(WhiteElo, out wElo);

                        myGames.Add(new ChessGame(Result, listOfMoves, BlackName, WhiteName, EventName, Site, EventDate, bElo, wElo));
                        flag = 0; //Reset flag
                        listOfMoves = ""; //Reset listOfMoves
                    }
                    
                }
                else
                {
                    if(flag == 1) //We are in the moves section
                    {
                        listOfMoves += line;
                    }
                }
            }

            return myGames;

        }


        /// <summary>
        /// Creates and returns a dictionary for Players given an iterable list of games
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public Dictionary<string, int> createPlayers(List<ChessGame> list)
        {
            Dictionary<string, int> Players = new Dictionary<string, int>();

            foreach(ChessGame game in list)
            {
                /*White Player ADD*/
                try
                {
                    Players.Add(game.getWhite(), game.getWhiteElo());                  
                }
                catch (ArgumentException)
                {
                    /*Player already exists!*/
                    if(Players[game.getWhite()] < game.getWhiteElo()) //If we have found a better ELO update!
                    {
                        Players[game.getWhite()] = game.getWhiteElo();
                    }
                    
                }

                /*Black Player ADD*/
                try
                {
                    Players.Add(game.getBlack(), game.getBlackElo());
                }
                catch (ArgumentException)
                {
                    /*Player already exists!*/
                    if (Players[game.getBlack()] < game.getBlackElo()) //If we have found a better ELO update!
                    {
                        Players[game.getBlack()] = game.getBlackElo();
                    }

                }
            }

            return Players;
        }
    }
}
