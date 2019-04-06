
from django.http import JsonResponse
from django.contrib.auth import login, logout, authenticate
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated

import json

from . import forms

def account_registration(request):
    if request.method == 'POST':
        form = forms.RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            user.refresh_from_db()
            username = form.cleaned_data.get('username')
            user.save()
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=raw_password)
            login(request, user)
            return redirect('/')
    else:
        form = forms.RegistrationForm()
    return render(request, 'account_handling/registration.html', {'form': form})


@api_view(["GET", "POST"])
@permission_classes((IsAuthenticated,))
def api_login(request):
    if request.method == 'POST':
        username = request.data.get('username')
        raw_password = request.data.get('password')
        user = authenticate(request, username=username, password=raw_password)
        if user is not None:
            return JsonResponse({"Status" : "Logged in"})
        else:
            return JsonResponse({"Status" : "Not logged in"})
    else:
        return JsonResponse({"Status" : "Not post"})


def account_login(request):
    if request.method == 'POST':
        form = forms.LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password')
            user = authenticate(request, username=username, password=raw_password)
            if user is not None:
                login(request, user)
                return redirect('/admin')
            else:
                return redirect('/')
    else:
        form = forms.LoginForm()
    return render(request, 'account_handling/login.html', {'form': form})


def account_logout(request):
    if request.method == 'POST':
        logout(request)
        return redirect('/')
    return render(request, 'account_handling/logout.html')
