import socket


serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serversocket.bind(("192.168.1.98", 9090))
serversocket.listen(10)
print('Wating for client..')

connection, addr = serversocket.accept()
print("[INFO]\tConnection stablished with:", addr)

msg = ""
while not "END CONNECTION\0" in msg:
	msg = connection.recv(1024).decode()
	print("INFO]\tMessage:", msg)
connect.close()
serversocket.close()