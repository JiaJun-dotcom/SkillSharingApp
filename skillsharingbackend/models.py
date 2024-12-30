from django.db import models
from django.contrib.auth.models import User

class Skills(models.Model):
    id = models.IntegerField(primary_key=True) #primary_key must always be set to True so that each
    #object can be uniquely identified by their id when connecting to API in each API endpoint.
    name = models.CharField(max_length=200)
    description = models.TextField()
    #the related_name is used to define and use the related_name skills in this case, so that
    #in the teachers class, if we want to access skills taught by a teacher, we can use:
    #teachers.skills.all and we dont need define another manytomanyfield in teachers class, which can
    #give us an error, and to access all teachers for a skill, use skills.teachers.all()
    #whereby teachers/skills in small caps means an instance of the classes, and using dot notation
    #to access that instance's teachers/skills list values!
    #using Skills/Teachers.objects.all to query would query whole database and return ALL the skills
    #and ALL the teachers in the whole database.
    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile', null=True, blank=True)
    name = models.CharField(max_length=255, default='')
    profile_picture = models.ImageField()
    bio = models.TextField()
    hpnumber = models.IntegerField()
    skills = models.ManyToManyField(Skills, blank=True, related_name='profiles')

    def __str__(self):
        return self.name

