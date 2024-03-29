//+------------------------------------------------------------------+
//|                                                indy_with_buy.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

input double sl_point = 7500 ;
input double tp_point = 750;
input double lotsize = 0.01;

input int macd_fast = 12;
input int macd_slow = 26;
input int signal = 9;

double macd_pole, macd_main_1, macd_main_2;
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

//create list
   double MyMACD[];
   ArraySetAsSeries(MyMACD,true);
//indicator MA
   macd_pole = iMACD(_Symbol,_Period,macd_fast,macd_slow,signal,PRICE_TYPICAL);

//append MA to list
   CopyBuffer(macd_pole,0,0,10,MyMACD);
   /*
      MA = indicator handle | indy ที่เราจะเข้าไปจัดการ
      0 = indicator buffer number | ส่วนใหญ่จะมีค่าเป็น 0
      0 = start postion | จุดเริ่มของการ copy 0 คือเอาตั้งแต่จุดปัจจุบัน
      3 = count | จำนวนแท่งเทียนที่จะทำการ copy
      MyMA = target array to copy | target list
   */
   macd_main_1 = MyMACD[1];
   macd_main_2 = MyMACD[4];

//set order on condition & 1 Order only
   if(PositionsTotal()==0)
     {
      if(macd_main_2 < 0 && macd_main_1 >= 0) //buy condition
        {
         ticket = OrderSend(request_buy,result_buy);
        }
      else if(macd_main_2 > 0 && macd_main_1 <= 0) //sell condition
        {          
         ticket = OrderSend(request_sell,result_sell);
        }
      else
        {
         Comment("No Signal");
        }
     }
   else
     {
      Comment("Maximum Order Reach");
     }




  }
//+------------------------------------------------------------------+
