//+------------------------------------------------------------------+
//|                                               Tread_MA_HiLow.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//tp point
double tp_point = 750;
//create request & result data
MqlTradeRequest request_buy = {};
MqlTradeResult result_buy = {};
//create request & result data
MqlTradeRequest request_sell = {};
MqlTradeResult result_sell = {};
//ticket
int ticket;
//count
int count;
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
   double Ar_Hi[];
   double Ar_Low[];
   ArraySetAsSeries(Ar_Hi,true);
   ArraySetAsSeries(Ar_Low,true);
    
//MA
   double MA_Hi = iMA(_Symbol,_Period,50,0,MODE_EMA,PRICE_HIGH);
   double MA_Low = iMA(_Symbol,_Period,50,0,MODE_EMA,PRICE_LOW);
   
//copy buffer
   CopyBuffer(MA_Hi,0,0,5,Ar_Hi);
   CopyBuffer(MA_Low,0,0,5,Ar_Low);
   
//close
   double close_sh2 = iClose(_Symbol,_Period,2);
   double close_sh1 = iClose(_Symbol,_Period,1);
   
//set request buy data
   double Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   request_buy.action = TRADE_ACTION_DEAL;
   request_buy.symbol = _Symbol;
   request_buy.volume = 0.01;
   request_buy.type = ORDER_TYPE_BUY;
   request_buy.price = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   request_buy.sl = Ar_Low[1];
   request_buy.tp = Ask + tp_point * _Point;
   request_buy.type_time = ORDER_TIME_GTC;
   request_buy.type_filling = ORDER_FILLING_IOC;
   
//set request sell data
   double Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   request_sell.action = TRADE_ACTION_DEAL;
   request_sell.symbol = _Symbol;
   request_sell.volume = 0.01;
   request_sell.type = ORDER_TYPE_SELL;
   request_sell.price = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   
//sl = ma(hi)(sh1) and not addition
   request_sell.sl = Ar_Hi[1];
   request_sell.tp = Bid - tp_point * _Point;
   
//order sell = close(sh2) > ma(low)(sh2) and close(sh1) < ma(low)(sh1)
   if(PositionsTotal()==0)
     {
      if(close_sh2 > Ar_Low[2] && close_sh1 < Ar_Low[1])
        {
         ticket = OrderSend(request_sell,result_sell);
         if(ticket==true)
           {
            count+=1;
           }
        }
      else if(close_sh2 < Ar_Hi[2] && close_sh1 > Ar_Hi[1])
             {
              ticket = OrderSend(request_buy,result_buy);
              if(ticket==true)
                {
                 count+=1;
                }
             }     
     }
//--- request trade history 
   HistorySelect(0,TimeCurrent()); 
//--- create objects 
   int     total=HistoryDealsTotal(); 
   ulong    ticket_=0; 
   double   price; 
   double   profit; 
   datetime time; 
   string   symbol; 
   long     type; 
   long     entry; 
   int      win = 0;

//--- for all deals 
   for(uint i=0;i<total;i++) 
     { 
      //--- try to get deals ticket 
      if((ticket_=HistoryDealGetTicket(i))>0) 
        { 
         //--- get deals properties 
         profit=HistoryDealGetDouble(ticket_,DEAL_PROFIT); 
         //--- only for current symbol     
        }
     if(profit > 0)
         {
         win++;
         Comment("win = ",win-1," | total = ",count);
         }
      }
      
  }
//+--------------------- ---------------------------------------------+
