//+------------------------------------------------------------------+
//|                                                      Test-EA.mq5 |
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
   double MyMA[]; 
   ArraySetAsSeries(MyMA,true);
   //indicator MA
   double MA = iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_CLOSE); 
   
   //append MA to list
   CopyBuffer(MA,0,0,3,MyMA);
   /*
      MA = indicator handle | indy ที่เราจะเข้าไปจัดการ
      0 = indicator buffer number | ส่วนใหญ่จะมีค่าเป็น 0
      0 = start postion | จุดเริ่มของการ copy 0 คือเอาตั้งแต่จุดปัจจุบัน
      3 = count | จำนวนแท่งเทียนที่จะทำการ copy
      MyMA = target array to copy | target list
   */
   
   Comment("MA: ",DoubleToString(MyMA[barshift],3));
  }
//+------------------------------------------------------------------+
