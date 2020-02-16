from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth import authenticate
from django.views.decorators.csrf import csrf_exempt
from app1.models import *

# Create your views here.
def index(request):
    return HttpResponse("Hello World!")

@csrf_exempt
def login(request):
    #parse username and password and authenticate
    if request.method == 'POST':
        username = request.POST['user']
        password = request.POST['pwd']
        return HttpResponse(authenticate(username=username, password=password) is not None)
    return HttpResponse(status=403)

@csrf_exempt
def register(request):
    #check if username is unique
    if request.method == 'POST':
        username = request.POST['user']
        password = request.POST['pwd']
        user = User.objects.create_user(username, email, password)
        user.save()
    return HttpResponse(status=403)

@csrf_exempt
def add_restaurant(request):
    #check if username is unique
    if request.method == 'POST':
        name = request.POST['name']
        latitude = request.POST['lat']
        longitude = request.POST['lng']
        address = request.POST['address']
        open = request.POST['open']
        close = request.POST['close']
        restaurant = Restaurants(name=name, latitude=latitude, longitude=longitude, address=address, open=open,close=close)
        restaurant.save()
        return HttpResponse(status=200)
    return HttpResponse(status=403)

@csrf_exempt
def add_inventory(request):
    if request.method == 'POST':
        name = request.POST['name']
        restaurant = Restaurants.objects.get(name=request.POST['restaurant'])
        quantity = request.POST['quantity']
        price = request.POST['price']
        picture = request.POST['picture']
        inventory = Inventory(name=name, restaurant=restaurant, quantity=quantity, price=price, picture=picture)
        inventory.save()
        return HttpResponse(status=200)
    return HttpResponse(status=403)

@csrf_exempt
def get_all_food(request):
    if request.method == 'GET':
        #get all rows from the inventory table and print restaurant.name?
        json = []
        #id,restaurant name, item name, price, quantity
        for e in Inventory.objects.all():
            dict = {}
            dict['inventory_id'] = e.id
            dict['restaurant'] = e.restaurant.name
            dict['item_name'] = e.name
            dict['price'] = e.price
            dict['quantity'] = e.quantity
            json.append(dict)
        return HttpResponse(JsonResponse(json, safe=False))
    return HttpResponse(status=403)
#
# @csrf_exempt
# def add_in_progress(request):
#     if request.method == 'POST':
#         item = Inventory.objects.get(pk=request.POST['item_id'])
#         user = User.objects.get(username=request.POST['user'])
#         quantity = request.POST['quantity']
#         in_progress = In_Progess(item=item, user=user, quantity=quantity)
#         in_progress.save()
#         return HttpResponse(status=200)
#     return HttpResponse(status=403)
# @csrf_exempt
# def remove_in_progress(request):
#     if request.method == 'POST':
#         item = Inventory.objects.get(pk=request.POST['item_id'])
#         user = User.objects.get(username=request.POST['user'])
#         quantity = request.POST['quantity']
#         in_progress = In_Progess(item=item, user=user, quantity=quantity)
#         in_progress.save()
#         return HttpResponse(status=200)
#     return HttpResponse(status=403)
#
# @csrf_exempt
# def move_in_progress(request):
#     if request.method == 'POST':
#         item = Inventory.objects.get(pk=request.POST['item_id'])
#         user = User.objects.get(username=request.POST['user'])
#         quantity = request.POST['quantity']
#         in_progress = In_Progess(item=item, user=user, quantity=quantity)
#         in_progress.save()
#         return HttpResponse(status=200)
#     return HttpResponse(status=403)
