from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Play(models.Model):
    user = models.ForeignKey(User, related_name="play", on_delete=models.SET_NULL, null=True)
    scores = models.IntegerField(default=0)
    saves = models.IntegerField(default=0)


class Team(models.Model):
    offence = models.ForeignKey(Play, related_name="off_team", on_delete=models.SET_NULL, null=True)
    defence = models.ForeignKey(Play, related_name="def_team", on_delete=models.SET_NULL, null=True)


class Game(models.Model):
    winner = models.ForeignKey(Team, related_name="win", on_delete=models.SET_NULL, null=True)
    Loser = models.ForeignKey(Team, related_name="lose", on_delete=models.SET_NULL, null=True)
