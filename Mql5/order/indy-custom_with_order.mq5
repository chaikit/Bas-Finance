//+------------------------------------------------------------------+
//|                                                indy_with_buy.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//input position size
input double sl_point = 750 ;
input double tp_point = 1000;
input double lotsize = 0.01;

//input indicator
input string indy_name = "pinbardetector";

/*
input int      MinimalBarSpread = 200;
input int      Offset = 50;
input double   Minimal_Spread_Body_value = 2.2;
input double   Minimal_BiggerTail_value = 1.3;
input bool     UseBodyDirection = false;
input bool     UseCloseThirds = true;
input int      ExtremumOfBars = 10;
*/

//input ticket
int ticket;

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
//Order Buy

   double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);

//create request & result data
   MqlTradeRequest request_buy = {};
   MqlTradeResult result_buy = {};

//set request data
   request_buy.action = TRADE_ACTION_DEAL;
   request_buy.symbol = _Symbol;
   request_buy.volume = lotsize;
   request_buy.type = ORDER_TYPE_BUY;
   request_buy.price = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   request_buy.sl = Ask - sl_point * _Point;
   request_buy.tp = Ask + tp_point * _Point;
   request_buy.type_time = ORDER_TIME_GTC;
   request_buy.type_filling = ORDER_FILLING_IOC;


//Order Sell

   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);

//create request & result data
   MqlTradeRequest request_sell = {};
   MqlTradeResult result_sell = {};

//set request data
   request_sell.action = TRADE_ACTION_DEAL;
   request_sell.symbol = _Symbol;
   request_sell.volume = lotsize;
   request_sell.type = ORDER_TYPE_SELL;
   request_sell.price = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   request_sell.sl = Bid + sl_point * _Point;
   request_sell.tp = Bid - tp_point * _Point;
   request_sell.type_time = ORDER_TIME_GTC;
   request_sell.type_filling = ORDER_FILLING_IOC;

//////////////////////////////////////////////////////////////////////////////////

//create Buffer array
   double MyiCus_Pinbar[];
   ArraySetAsSeries(MyiCus_Pinbar,true);
   
   //double MyiCus_StopBuffer[];
   //ArraySetAsSeries(MyiCus_StopBuffer,true);
 
//indicator iCustom
   double iCus = iCustom(_Symbol,_Period,indy_name);
   
//append iCustom to Buffer array
   CopyBuffer(iCus,0,0,20,MyiCus_Pinbar);
   //CopyBuffer(iCus,1,0,10,MyiCus_StopBuffer);
   /*
      iCus = indicator handle | indy ที่เราจะเข้าไปจัดการ
      0 = indicator buffer number | ส่วนใหญ่จะมีค่าเป็น 0
      0 = start postion | จุดเริ่มของการ copy 0 คือเอาตั้งแต่จุดปัจจุบัน
      10 = count | จำนวนแท่งเทียนที่จะทำการ copy
      MyiCus = target array to copy | target list
   */
   //double OpenBuffer = MyiCus_OpenBuffer[1];
   //double StopBuffer = MyiCus_StopBuffer[1];
   

//set order on condition & 1 Order only

   if(PositionsTotal()==0)
     {
     //buy
     if(MyiCus_Pinbar[1] != EMPTY_VALUE)
       {
        ticket = OrderSend(request_buy,result_buy);
       }
     }

  }
//+------------------------------------------------------------------+
