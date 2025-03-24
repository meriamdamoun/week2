
from menu_item import MenuItem 

def add_item_to_menu():
    name = input("Enter item name: ")
    price = int(input("Enter item price: "))
    item = MenuItem(name, price)
    item.save()

def remove_item_from_menu():
    name = input("Enter the name of the item to delete: ")
    MenuItem.delete(name)

def update_item_from_menu():
    old_name = input("Enter the name of the item to update: ")
    new_name = input("Enter the new name: ")
    new_price = int(input("Enter the new price: "))
    MenuItem.update(old_name, new_name, new_price)

def show_user_menu():
    while True:
        print("\nRestaurant Menu Editor")
        print("(V) View an Item")
        print("(A) Add an Item")
        print("(D) Delete an Item")
        print("(U) Update an Item")
        print("(S) Show the Menu")
        print("(X) Exit")

        choice = input("Enter your choice: ").strip().upper()

        if choice == 'A':
            add_item_to_menu()
        elif choice == 'D':
            remove_item_from_menu()
        elif choice == 'U':
            update_item_from_menu()
        elif choice == 'X':
            print("Exiting...")
            break
        else:
            print("Invalid choice, try again!")
show_user_menu()
