//+------------------------------------------------------------------+
//|                                      test-Price-Bid-Ask-OHLC.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
// Info of the last tick.
//-----------------------

// To be used for getting recent/latest price quotes
   MqlTick Latest_Price; // Structure to get the latest prices
   SymbolInfoTick(Symbol(),Latest_Price);  // Assign current prices to structure

// The BID price.
   static double Bid;

// The ASK price.
   static double Ask;

   Bid = Latest_Price.bid;  // Current Bid price.
   Ask = Latest_Price.ask;  // Current Ask price.
   
   double Bid2 = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   double Ask2 = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   
   Comment("Bid: ",Bid," | Ask :",Ask,"\nBid2: ",Bid2," | Ask2 :",Ask2);
   
   
  }
//+------------------------------------------------------------------+
