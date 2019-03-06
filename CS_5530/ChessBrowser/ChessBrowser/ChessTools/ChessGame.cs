using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ChessTools
{  
    public class ChessGame
    {

        // Fields
        private string Result;
        private string Moves;
        private string BlackPlayer;
        private string WhitePlayer;
        private string EventName;
        private string Site;
        private string EventDate;
        private int BlackElo;
        private int WhiteElo;

        /// <summary>
        /// ChessGame Constructor. Used to create ChessGame objects that can then be iterated if collected into a list.
        /// </summary>
        /// <param name="res"></param>
        /// <param name="moves"></param>
        /// <param name="bPlayer"></param>
        /// <param name="wPlayer"></param>
        /// <param name="eName"></param>
        /// <param name="site"></param>
        /// <param name="eDate"></param>
        /// <param name="bElo"></param>
        /// <param name="wElo"></param>

        public ChessGame(string res, string moves, string bPlayer, string wPlayer, string eName, string site, string eDate, int bElo, int wElo)
        {
            Result = res;
            Moves = moves;
            BlackPlayer = bPlayer;
            WhitePlayer = wPlayer;
            EventName = eName;
            Site = site;
            EventDate = eDate;
            BlackElo = bElo;
            WhiteElo = wElo;
        }

        public string getResult()
        {
            return Result;
        }

        public string getMoves()
        {
            return Moves;
        }

        public string getBlack()
        {
            return BlackPlayer;
        }

        public string getWhite()
        {
            return WhitePlayer;
        }

        public string getEventName()
        {
            return EventName;
        }

        public string getSite()
        {
            return Site;
        }

        public string getEventDate()
        {
            return EventDate;
        }

        public int getWhiteElo()
        {
            return WhiteElo;
        }

        public int getBlackElo()
        {
            return BlackElo;
        }


    }
}
