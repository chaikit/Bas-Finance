//+------------------------------------------------------------------+
//|                                  Test_PositionSizeCalculator.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window

input double MoneyRisk = 100;
input double Entry_Price = 2500;
input double SL_Price = 2450;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   double Price = MathAbs(Entry_Price - SL_Price);
   double Point_ = Price/Point();
   double TickValue = SymbolInfoDouble(NULL,SYMBOL_TRADE_TICK_VALUE);
   double MoneyRisk_1lot = Point_ * TickValue;
   double PositionSize = MoneyRisk / MoneyRisk_1lot;
   
   Comment( 
            "Entry Price : ", Entry_Price,
            "\nSL Price : ", SL_Price,
            "\nMoneyRisk : ", MoneyRisk,
            "\nMoneyRisk_1lot: ",DoubleToString(MoneyRisk_1lot,2),
            "\nPositionSize : ",DoubleToString(PositionSize,2)
            );
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
