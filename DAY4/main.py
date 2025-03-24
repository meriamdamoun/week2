from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from menu_item import MenuItem

app = FastAPI()

class MenuItemCreate(BaseModel):
    name: str
    price: int

class MenuItemUpdate(BaseModel):
    new_name: str  
    new_price: int


@app.post("/menu/")
async def add_item_to_menu(item: MenuItemCreate):
    menu_item = MenuItem(item.name, item.price)
    menu_item.save()
    return {"message": f"Item '{item.name}' added successfully!"}


@app.delete("/menu/{item_name}")
async def remove_item_from_menu(item_name: str):
    MenuItem.delete(item_name)
    return {"message": f"Item '{item_name}' deleted successfully!"}


@app.put("/menu/{item_name}")
async def update_item_from_menu(item_name: str, item: MenuItemUpdate):
    MenuItem.update(item_name, item.new_name, item.new_price)
    return {"message": f"Item '{item_name}' updated to '{item.new_name}' with price {item.new_price} successfully!"}

@app.get("/menu/")
async def show_menu():
    menu_items = MenuItem.fetch_all()  
    if menu_items:
        return {"menu_items": menu_items}
    else:
        return {"message": "No menu items found."}

# uvicorn main:app --reload
