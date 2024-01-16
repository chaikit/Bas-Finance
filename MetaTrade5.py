
import MetaTrader5 as mt

class MT:
	def __init__(self,ticker=None,volume=None):
		if not ticker==None or volume==None:
			self.ticker = ticker
			self.volume = volume

	login = '51560509'
	password = 'C09mYA5@^F'
	server = 'ICMarketsSC-Demo'
	mt.initialize()
	mt.login(login, password, server)

	def OrderBuy(self,sl:float,tp:float,):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.ticker,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_BUY,
			"price": mt.symbol_info_tick(self.ticker).ask,
			'sl': sl,
			'tp': tp,
			'comment': 'Python Script Buy',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)

	def CancleBuy(self,pos:int):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.ticker,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_SELL,
			"position": pos,
			"price": mt.symbol_info_tick(self.ticker).bid,
			'comment': 'Close Position',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)

	def OrderSell(self,sl:float,tp:float):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.ticker,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_SELL,
			"price": mt.symbol_info_tick(ticker).bid,
			'sl': sl,
			'tp': tp,
			'comment': 'Python Script Open',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)

	def CancleSell(sel,pos:int):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.ticker,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_BUY,
			"position": pos,
			"price": mt.symbol_info_tick(self.ticker).ask,
			'comment': 'Close Position',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)



'''
login = '51560509'
password = 'C09mYA5@^F'
server = 'ICMarketsSC-Demo'
mt.initialize()																						# เปิดโปรแกรม Metatrader5
mt.login(login, password, server)																	# login

symbol = 'ETHUSD'
request = {
	"action": mt.TRADE_ACTION_DEAL,
	"symbol": symbol,
	"volume": 0.01,
	"type": mt.ORDER_TYPE_BUY,
	"price": mt.symbol_info_tick(symbol).ask,
	'sl': 2255.0,
	'tp': 2266.0,
	'comment': 'Python Script Buy',
	'type_time': mt.ORDER_TIME_GTC,
	'type_filling': mt.ORDER_FILLING_IOC,
}
# order = mt.order_send(request);print(order)															# ส่งคำสั่งซื้อ

request = {
	"action": mt.TRADE_ACTION_DEAL,
	"symbol": symbol,
	"volume": 0.01,
	"type": mt.ORDER_TYPE_SELL,
	"position": 559885613,
	"price": mt.symbol_info_tick(symbol).bid,
	'comment': 'Close Position',
	'type_time': mt.ORDER_TIME_GTC,
	'type_filling': mt.ORDER_FILLING_IOC,
}
# order = mt.order_send(request);print(order)															# ยกเลิกคำสั่งซื้อ

request = {
	"action": mt.TRADE_ACTION_DEAL,
	"symbol": symbol,
	"volume": 0.01,
	"type": mt.ORDER_TYPE_SELL,
	"price": mt.symbol_info_tick(symbol).bid,
	'sl': 2265.0,
	'tp': 2250.0,
	'comment': 'Python Script Open',
	'type_time': mt.ORDER_TIME_GTC,
	'type_filling': mt.ORDER_FILLING_IOC,
}
# order = mt.order_send(request);print(order)															# ส่งคำสั่งขาย

request = {
	"action": mt.TRADE_ACTION_DEAL,
	"symbol": symbol,
	"volume": 0.01,
	"type": mt.ORDER_TYPE_BUY,
	"position": 559885613,
	"price": mt.symbol_info_tick(symbol).ask,
	'comment': 'Close Position',
	'type_time': mt.ORDER_TIME_GTC,
	'type_filling': mt.ORDER_FILLING_IOC,
}
# order = mt.order_send(request);print(order)															# ยกเลิกคำสั่งขาย

'''