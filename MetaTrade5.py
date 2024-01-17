
import MetaTrader5 as mt

class MT:
	def __init__(self,symbol=None,volume=None):
		if not symbol==None or volume==None:
			self.symbol = symbol
			self.volume = volume

	def Initialize(self,login,password,server):
		mt.initialize()
		mt.login(login,password,server)
    
	def OrderBuy(self,sl,tp): 
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.symbol,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_BUY,
			"price": mt.symbol_info_tick(self.symbol).ask,
			'sl': sl,
			'tp': tp,
			'comment': 'Python Script Buy',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)
		return order

	def CancleBuy(self,pos):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.symbol,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_SELL,
			"position": pos,
			"price": mt.symbol_info_tick(self.symbol).bid,
			'comment': 'Close Position',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)
		return order
    
	def OrderSell(self,sl,tp):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.symbol,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_SELL,
			"price": mt.symbol_info_tick(self.symbol).bid,
			'sl': sl,
			'tp': tp,
			'comment': 'Python Script Open',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)
		return order
    
	def CancleSell(self,pos):
		request = {
			"action": mt.TRADE_ACTION_DEAL,
			"symbol": self.symbol,
			"volume": self.volume,
			"type": mt.ORDER_TYPE_BUY,
			"position": pos,
			"price": mt.symbol_info_tick(self.symbol).ask,
			'comment': 'Close Position',
			'type_time': mt.ORDER_TIME_GTC,
			'type_filling': mt.ORDER_FILLING_IOC,
		}
		order = mt.order_send(request);print(order)
		return order
    