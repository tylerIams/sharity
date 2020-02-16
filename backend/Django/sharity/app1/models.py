from django.db import models
from django.contrib.auth.models import User
from django.shortcuts import render
# from django.models import *

# class Question(models.Model):
#     question_text = models.CharField(max_length=200)
#     pub_date = models.DateTimeField('date published')
#
#     def __str__(self):
#         return self.question_text
#     def was_published_recently(self):
#         return self.pub_date >= timezone.now() - datetime.timedelta(days=1)
#
#
# class Choice(models.Model):
#     question = models.ForeignKey(Question, on_delete=models.CASCADE)
#     choice_text = models.CharField(max_length=200)
#     votes = models.IntegerField(default=0)
#
#     def __str__(self):
#         return self.choice_text

class Restaurants(models.Model):
    name = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=11, decimal_places=8)
    longitude = models.DecimalField( max_digits=11, decimal_places=8)
    address = models.TextField(max_length=400)
    open = models.TimeField()
    close = models.TimeField()

    def __str__(self):
        return self.name

class Inventory(models.Model):
    name = models.CharField(max_length=200)
    restaurant = models.ForeignKey(Restaurants, on_delete=models.DO_NOTHING)
    quantity = models.IntegerField(default=0)
    price = models.DecimalField(max_digits=12, decimal_places=2)
    picture = models.TextField(max_length=1000)
    def __str__(self):
        return str(self.id) + "|" + str(self.restaurant.name) + "|" + str(self.name) +"\n"

class Completed_Purchases(models.Model):
    item = models.ForeignKey(Inventory, on_delete=models.DO_NOTHING)
    user = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    quantity = models.IntegerField(default=0)
    def __str__(self):
        return str(self.id)

class In_Progess(models.Model):
    item = models.ForeignKey(Inventory, on_delete=models.DO_NOTHING)
    user = models.ForeignKey(User, on_delete=models.DO_NOTHING)
    quantity = models.IntegerField(default=0)
    def __str__(self):
        # status = self.user.get('name') + self.
        return str(self.id)
#Restaurants._meta.pk.name = column name of primary
# class Users(models.Model):
#     username = models.CharField(max_length=256)
#     phone_number = models.CharField(max_length=10)
#     is_restaurant = models.BooleanField()
#     email = models.CharField(max_length=256)

# class Restaurants(models.Model):
