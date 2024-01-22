//+------------------------------------------------------------------+
//|                                                  Test-Script.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
   input double StopLoss = 1000;
   input double Profit = 2000;
   input double PositionSize = 0.1;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   //create request & result data
   MqlTradeRequest request = {};
   MqlTradeResult result = {};
   
   //set request data
   request.action = TRADE_ACTION_DEAL; 
   request.symbol = _Symbol;
   request.volume = PositionSize;
   request.type = ORDER_TYPE_BUY;
   request.price = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   request.sl = StopLoss;
   request.tp = Profit;
   request.type_time = ORDER_TIME_GTC;
   request.type_filling = ORDER_FILLING_IOC;
   
   //--- send order the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError()); 
   OrderSend(request,result);
   
  }
//+------------------------------------------------------------------+
