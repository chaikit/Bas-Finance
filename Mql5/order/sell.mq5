//+------------------------------------------------------------------+
//|                                                         sell.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   double Pip_sl = 500 * Point();
   double Pip_tp = 750 * Point();
   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   double StopLoss = Bid + Pip_sl;
   double Profit = Bid - Pip_tp;
   
   //create request & result data
   MqlTradeRequest request = {};
   MqlTradeResult result = {};
   
   //set request data
   request.action = TRADE_ACTION_DEAL; 
   request.symbol = _Symbol;
   request.volume = 0.1;
   request.type = ORDER_TYPE_SELL;
   request.price = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   request.sl = StopLoss;
   request.tp = Profit;
   request.type_time = ORDER_TIME_GTC;
   request.type_filling = ORDER_FILLING_IOC;
   
   //--- send order the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError()); 
  }
//+------------------------------------------------------------------+
