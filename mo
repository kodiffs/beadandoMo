using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DoczyKristof
{
    class Program
    {
        //--- Menü ---
        static void Fomenu()
        {
            int menu;
            string menuPont;
            //menüpont bekérése 
            do
            {
                do
                {
                    //yass
                    NicePos("Válasszon a menüpontok közül a számok segítségével! ");
                    //menupontok
                    Console.Write("\n\n\t1 - Téglalap" + "\n\t2 - Háromszög" +
                        "\n\t3 – Kör" + "\n\t4 – Egyedi ötlet, tetszőleges sokszög"
                        + "\n\t5 - Kilépés\n\t");
                    menuPont = Console.ReadLine();
                } while (string.IsNullOrEmpty(menuPont));
                //ellenőrzés, hogy szám-e
                bool szamE = int.TryParse(menuPont, out menu);
                if (szamE)
                {
                    menu = Convert.ToInt32(menuPont);
                }
                else
                {
                    Hiba("Nem számot adott meg.");
                    Enter("-Enter-");
                    Alap();
                }
                //ellenőrzés, hogy a megadott szám helyes-e
                if (menu < 1 || menu > 5)
                {
                    Hiba("Menüpontok csak 1 és 5 között vannak.");
                    Enter("-Enter-");
                    Alap();
                    Fomenu();
                }
            } while (menu<1 || menu>5);
            Alap();
            //vezérlő switch
            switch (menu)
            {
                case 1: Teglalap(); break;
                case 2: Haromszog(); break;
                case 3: Kor(); break;
                //case 4: ; break;      --- hianyzik a nev ---
                default: Environment.Exit(0); break;
            }
        }
        //--- Választható cucc ---
        //--- Háromszög ---
        static void Haromszog()
        {
            //lista az oldalaknak
            List<double> Oldalak = new List<double>();
            //bekérés
            string elsoSzam, masodikSzam, harmadikSzam;
            double a, b, c;
            do
            {
                do
                {
                    NicePos("Háromszög:");
                    Console.Write("\n\tAdja meg az A oldal hosszát! ");
                    elsoSzam = (Console.ReadLine());
                    Console.Write("\n\tAdja meg a B oldal hosszát! ");
                    masodikSzam = (Console.ReadLine());
                    Console.Write("\n\tAdja meg a C oldal hosszát! ");
                    harmadikSzam = (Console.ReadLine());
                    if (string.IsNullOrEmpty(elsoSzam) || string.IsNullOrEmpty(masodikSzam) 
                        || string.IsNullOrEmpty(harmadikSzam))
                    {
                        Hiba("A mező nem lehet üres!");
                        Enter("-Enter-");
                        Alap();
                    }
                } while (string.IsNullOrEmpty(elsoSzam) || string.IsNullOrEmpty(masodikSzam)
                        || string.IsNullOrEmpty(harmadikSzam));
                //ellenőrzés, hogy szám-e
                bool aSzamE = double.TryParse(elsoSzam, out a);
                bool bSzamE = double.TryParse(masodikSzam, out b);
                bool cSzamE = double.TryParse(harmadikSzam, out c);
                if (aSzamE && bSzamE && cSzamE)
                {
                    a = Convert.ToDouble(elsoSzam);
                    b = Convert.ToDouble(masodikSzam);
                    c = Convert.ToDouble(harmadikSzam);
                    if (!(a < b + c && b < a + c && c < b + a))
                    {
                        //oldalak növekvő sorrendben
                        Oldalak.Add(a);
                        Oldalak.Add(b);
                        Oldalak.Add(c);
                        Oldalak.Sort();
                        Hiba("A háromszög nem szerkeszthető.");
                        Console.Write("\n\t\t\t\t\t" +
                            "Számok növekvő sorrendben: ");
                        Console.ResetColor();
                        foreach (int mo in Oldalak)
                        {
                            Console.Write(mo + ", ");
                        }
                        Enter("-Enter-");
                        Oldalak.Clear();
                        Alap();
                    }
                    //ellenőrzés, hogy az oldal pozitív-e
                    if (a < 1 || b < 1 || c < 1)
                    {
                        Hiba("Az oldal hossz nem lehet negatív vagy nulla.");
                        Enter("-Enter-");
                        Alap();
                    }
                }
                else
                {
                    Hiba("Nem számot adott meg.");
                    Enter("-Enter-");
                    Alap();
                }
               
            } while (a < 1 || b < 1 || c < 1 || !(a < b + c && b < a + c && c < b + a));
            Zold();
            Console.WriteLine("\n\tA háromszög szerkeszthető");
            //számolás
            double s = (a + b + c) / 2.0;
            double terulet = Math.Round(Math.Sqrt(s * (s - a) * (s - b) * (s - c)), 2);
            double kerulet = 2.0 * s;
            double beIrKorS = Math.Round(Math.Sqrt(((s - a) * (s - b) * (s - c)) / s), 2);
            double KorIrKorS = Math.Round(Math.Sqrt((s * (s - b) * (s - c)) / (s - a)), 2);
            double Am = Math.Round(Math.Sqrt((a + b + c) * (-a + b + c) * (a - b + c)
                * (a + b - c)) / (2 * a), 2);
            double Bm = Math.Round(Math.Sqrt((a + b + c) * (-a + b + c) * (a - b + c)
                * (a + b - c)) / (2 * b), 2);
            double Cm = Math.Round(Math.Sqrt((a + b + c) * (-a + b + c) * (a - b + c) 
                * (a + b - c)) / (2 * c), 2);
            //kiiras omglul
            Zold();
            Console.WriteLine("\t\tTerület: {0} négyzetegység\n" +
                "\t\tKerület: {1} egység\n" +
                "\t\tKöré írható kör sugara: {2} egység\n" +
                "\t\tBele írható kör sugara: {3} egység\n" +
                "\t\tA oldalhoz tartozó magasság: {4} egység\n" +
                "\t\tB oldalhoz tartozó magasság: {5} egység\n" +
                "\t\tC oldalhoz tartozó magasság: {6} egység\n",
                terulet, kerulet, KorIrKorS, beIrKorS, Am, Bm, Cm);
            Enter(" - Enter: visszalépés a főmenübe - ");
            Alap();
            Fomenu();
        }
        //--- Random ---
        public static Random rnd = new Random();
        //--- Kör ---
        static void Kor()
        {
            //bekérés
            string megfelel;
            int sugar; //nem a cukor
            do
            {
                sugar = rnd.Next(1, 11);
                do
                {   
                    //bekérés
                    //nem igazán találtam elegánsabb működő megoldást :(
                    Console.Write("\n\n\n\n\n\n\n\n\n\n\n\n\t\t\t"
                        + "A kör sugara: {0},maradhat? (i/n) ", sugar);
                    megfelel = Console.ReadLine();
                    Alap();
                    if (megfelel != "n" && megfelel != "i")
                    {
                        Hiba("'i' (igen) vagy 'n' (nem).");
                        Enter("-Enter-");
                        Alap();
                    }
                } while (megfelel !="n" && megfelel != "i");
            } while (megfelel!="i");
            //számítás
            double kerulet = Math.Round(2 * sugar * Math.PI, 2);
            double terulet = Math.Round(Math.Pow(sugar,2) * Math.PI,2);
            int atmero = 2 * sugar;
            Zold();
            Console.Write("\n\n\n\n\n\n\n\n\n\n\n\n\t\t"
                + "A {0} egység sugarú kör átmérője {1}, kerülete {2} egység,"
                + " területe pedig {3} négyzetegység.",sugar,atmero,kerulet,terulet);
            //visszalépés
            Enter("-Enter: visszalépés a főmenübe-");
            Alap();
            Fomenu();
        }
        //--- Téglalap ---
        static void Teglalap()
        {
            //bekérés
            string elsoSzam, masodikSzam;
            int a, b;
            do
            {
                do
                {
                    //bekérés
                    NicePos("Téglalap:");
                    Console.Write("\n\n\tAdja meg az A oldal hosszát! ");
                    elsoSzam = Console.ReadLine();
                    Console.Write("\n\tAdja meg a B oldal hosszát! ");
                    masodikSzam = Console.ReadLine();
                    //ellenőrzés, hogy nem üres
                    if (string.IsNullOrEmpty(elsoSzam) || string.IsNullOrEmpty(masodikSzam))
                    {
                        Hiba("A mező nem lehet üres.");
                        Enter("-Enter-");
                        Alap();
                    }
                } while (string.IsNullOrEmpty(elsoSzam) || string.IsNullOrEmpty(masodikSzam));
                //ellenőrzés, hogy szám-e 
                bool aSzamE = int.TryParse(elsoSzam, out a);
                bool bSzamE = int.TryParse(masodikSzam, out b);
                if (aSzamE && bSzamE)
                {
                    a = Convert.ToInt32(elsoSzam);
                    b = Convert.ToInt32(masodikSzam);
                    //hiba
                    if (a < 1 || b < 1)
                    {
                        Hiba("Az oldal hossza nem lehet 0 vagy negatív.");
                        Enter("-Enter-");
                        Alap();
                    }
                    if (a > 9999 || b > 9999)
                    {

                        Hiba("Túl nagy szám. A legnagyobb kezelhető szám 9999.");
                        Enter("-Enter-");
                        Alap();
                    }
                }
                else
                {
                    Hiba("Nem számot adott meg.");
                    Enter("-Enter-");
                    Alap();
                }
            } while (a <= 0 || b <= 0 || a > 9999 || b > 9999);
            //számítás
            int terulet = a * b;
            int kerulet = 2*(a + b);
            //negyzet-e
            if (a==b)
            {
                Zold();
                Console.WriteLine("\n\tA síkidom egy négyzet melynek kerülete {0} egység, "
                    + "területe pedig {1} négyzetegység.",kerulet,terulet);
                Enter("-Enter: visszalépés a főmenübe-");
            }
            else
            {
                Zold();
                Console.WriteLine("\n\tA síkidom egy téglalap melynek kerülete {0} egység, "
                    + "területe pedig {1} négyzetegység.", kerulet, terulet);
                Enter("-Enter: visszalépés a főmenübe-");
            }
            Alap();
            Fomenu();
        }
        //--- Main ---
        static void Main(string[] args)
        {
            //cím
            Console.Title = "Síkidomok - téli szünet beadandó feladat";
            //kezdőoldal
            Fomenu();
        }
        //--- igazítás ---
        static void NicePos(string s)
        {
            int mgssg = Console.WindowHeight;
            int hssz = Console.WindowWidth;
            Console.SetCursorPosition((hssz - s.Length) / 2, mgssg / 2-8);
            Console.WriteLine(s);
        }
        //--- Színezés ---
        static void Zold()
        {
            Console.ForegroundColor = ConsoleColor.Green;
        }
        //--- Hibák kiiratása ---
        static void Hiba(string s)
        {
            Console.Clear();
            Console.ForegroundColor = ConsoleColor.Red;
            int mgssg = Console.WindowHeight;
            int hssz = Console.WindowWidth;
            Console.SetCursorPosition((hssz - s.Length) / 2, mgssg / 2);
            Console.WriteLine(s);
        }
        //--- Enter ---
        static void Enter(string s)
        {
            Console.ForegroundColor = ConsoleColor.Cyan;
            int mgssg = Console.WindowHeight;
            int hssz = Console.WindowWidth;
            Console.SetCursorPosition((hssz - (s.Length + 8)), mgssg - 5);
            Console.WriteLine(s);
            Console.ReadLine();
        }
        //--- Változtatások törlése ---
        static void Alap()
        {
            Console.ResetColor();
            Console.Clear();
        }
    }
}
