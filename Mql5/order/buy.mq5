//+------------------------------------------------------------------+
//|                                                  Test-Script.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

input double sl_point = 500 ;
input double tp_point = 750;
input double lotsize = 0.01;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   double Pip_sl = sl_point * Point();
   double Pip_tp = tp_point * Point();
   double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   double StopLoss = Ask - Pip_sl;
   double Profit = Ask + Pip_tp;

//create request & result data
   MqlTradeRequest request = {};
   MqlTradeResult result = {};

//set request data
   request.action = TRADE_ACTION_DEAL;
   request.symbol = _Symbol;
   request.volume = lotsize;
   request.type = ORDER_TYPE_BUY;
   request.price = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   request.sl = StopLoss;
   request.tp = Profit;
   request.type_time = ORDER_TIME_GTC;
   request.type_filling = ORDER_FILLING_IOC;

//--- send order the request
   int ticket;
   ticket = OrderSend(request,result);
   if(ticket < 0)
     {
      Comment("LastOrder: ",GetLastError());
     }
   else
     {
      Comment("Ticket: ",ticket,"\nOrders: ",OrdersTotal());
     }
  }
//+------------------------------------------------------------------+
