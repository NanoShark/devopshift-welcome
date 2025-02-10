
server_list = ["nginx" , "docker", "apache"] 

try:
    server_name = input("Enter server name: ")
    if server_name == "" or server_name.isalnum()== False or server_name not in server_list:
        raise ValueError
    
except(ValueError) as e:
    print("Error:Invalid server name")

print("Server is running ")