"""sharity URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from app1 import views

urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.login, name='login'),
    path('add_restaurant/', views.add_restaurant, name='add_restaurant'),
    path('add_inventory/', views.add_inventory, name='add_inventory'),
    # path('add_in_progress/', views.add_in_progress, name='add_in_progress'),
    path('get_all_food/', views.get_all_food, name='get_all_food'),
    path('app1/', include('app1.urls')),
    path('admin/', admin.site.urls),
]
