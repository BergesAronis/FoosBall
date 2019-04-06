from django.urls import path

from . import views
app_name = 'account_handling'
urlpatterns = [
    path('registration', views.account_registration, name='registration'),
    path('login', views.account_login, name='login'),
    path('logout', views.account_logout, name='logout'),
    path('api_login', views.api_login, name='api_login'),
]
