import psycopg2

class MenuItem:
    
    def __init__(self, name, price):
        self.name = name
        self.price = price

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

    def save(self):
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("INSERT INTO Menu_Items (item_name, item_price) VALUES (%s, %s);", (self.name, self.price))
                connection.commit()
                print(f"Item '{self.name}' added successfully!")
            except Exception as e:
                print(f"Error inserting item: {e}")
            finally:
                cursor.close()
                connection.close()

    @classmethod
    def delete(cls, item_name):
        connection = cls.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("DELETE FROM Menu_Items WHERE item_name = %s", (item_name,))
                connection.commit()
                print(f"Item '{item_name}' deleted successfully!")
            except Exception as e:
                print(f"Error deleting item: {e}")
            finally:
                cursor.close()
                connection.close()

    @classmethod
    def update(cls, old_name, new_name, new_price):
        connection = cls.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("UPDATE Menu_Items SET item_name = %s, item_price = %s WHERE item_name = %s;", 
                               (new_name, new_price, old_name))
                connection.commit()
                print(f"Item '{old_name}' updated to '{new_name}' with price {new_price} successfully!")
            except Exception as e:
                print(f"Error updating item: {e}")
            finally:
                cursor.close()
                connection.close()
    @classmethod
    def fetch_all(cls):
        connection = cls.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("SELECT item_name, item_price FROM Menu_Items;")
                rows = cursor.fetchall()
                menu_items = [{"name": row[0], "price": row[1]} for row in rows]
                return menu_items
            except Exception as e:
                print(f"Error fetching items: {e}")
                return []
            finally:
                cursor.close()
                connection.close()
