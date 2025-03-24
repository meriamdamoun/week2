import psycopg2
class MenuManager:
   
    def __init__(self,item_name):
        self.item_name = item_name  
    @classmethod
    def connect_db(cls):
        try:
            connection = psycopg2.connect(
                 host="localhost",
                user="postgres",
                password="Admin",
                dbname="restaurent"
            )
            return connection
        except Exception as e:
            print(f"Error connecting to database: {e}")
            return None  
    @classmethod   
    def get_by_name(cls,item_name):
        connection = cls.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("select * from Menu_Items WHERE item_name = %s ",(item_name,))
                item = cursor.fetchone()
                if item:
                    print(f"Item found: {item}")
                else:
                    print(f"Item '{cls.item_name}' not found.")
                
            except Exception as e:
                print(f"Error fetching item: {e}")
            finally:
                cursor.close()
                connection.close() 
                


    
           
            
        
