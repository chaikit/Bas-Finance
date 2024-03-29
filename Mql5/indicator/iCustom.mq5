//+------------------------------------------------------------------+
//|                                                         test.mq5 |
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

//create array
   double MyiCus_Buffer0[];
   ArraySetAsSeries(MyiCus_Buffer0,true);

   double MyiCus_Buffer1[];
   ArraySetAsSeries(MyiCus_Buffer1,true);

//indicator iCustom
   double iCus = iCustom(_Symbol,PERIOD_CURRENT,"AD");
   /*
   symbol = symbol name
   period = period
   name = indicator name
   ... = list of indicator input parameters ใส่หรือไม่ใส่ก็ได้
   */

//append iCustom to array
   CopyBuffer(iCus,0,0,3,MyiCus_Buffer0);
   CopyBuffer(iCus,1,0,3,MyiCus_Buffer1);
   /*
   iCus = indicator handle | indy ที่เราจะเข้าไปจัดการ
   0 = indicator buffer number | ส่วนใหญ่จะมีค่าเป็น 0
   0 = start postion | จุดเริ่มของการ copy 0 คือเอาตั้งแต่จุดปัจจุบัน
   3 = count | จำนวนแท่งเทียนที่จะทำการ copy
   MyiCus = target array to copy | target list
   */

   Comment("iCustom 0: ",DoubleToString(MyiCus_Buffer0[barshift],3),
           "\niCustom 1: ",DoubleToString(MyiCus_Buffer1[barshift],3)
          );
  }
//+------------------------------------------------------------------+
