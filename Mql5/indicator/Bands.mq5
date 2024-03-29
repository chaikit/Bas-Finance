//+------------------------------------------------------------------+
//|                                                        Bands.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

input int barshift = 0;
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
   //create list
   double MyBands_upper[]; 
   ArraySetAsSeries(MyBands_upper,true);
   
   double MyBands_middle[]; 
   ArraySetAsSeries(MyBands_middle,true);
   
    double MyBands_lower[]; 
   ArraySetAsSeries(MyBands_lower,true);
   
   //indicator bands
   double Bands = iBands(_Symbol,_Period,50,0,2.0,PRICE_CLOSE);
   
   //append MA to list
   CopyBuffer(Bands,0,0,3,MyBands_middle);
   CopyBuffer(Bands,1,0,3,MyBands_upper);
   CopyBuffer(Bands,2,0,3,MyBands_lower);
   /*
   Bands = indicator handle | indy ที่เราจะเข้าไปจัดการ
   0 = indicator buffer number | 0:middle, 1:upper, 2:lower
   0 = start postion | จุดเริ่มของการ copy 0 คือเอาตั้งแต่จุดปัจจุบัน
   3 = count | จำนวนแท่งเทียนที่จะทำการ copy
   MyMA = target array to copy | target list
   */
   Comment("Upper: ",DoubleToString(MyBands_upper[barshift],3),
           "\nMiddle: ",DoubleToString(MyBands_middle[barshift],3),
           "\nLower: ",DoubleToString(MyBands_lower[barshift],3)
           );
  }
//+------------------------------------------------------------------+
