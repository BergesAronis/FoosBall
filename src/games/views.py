from django.http import JsonResponse
from django.shortcuts import render
from rest_framework.decorators import api_view

# Create your views here.
@api_view(['POST'])
def index(request):
    response = {}
    user = request.user
    plays = user.play.all()
    scores = 0
    for play in plays:
        scores += play.scores

    response["name"] = user.username
    response["score"] = scores

    return JsonResponse(response)
