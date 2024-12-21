import rest_framework
from django.contrib import admin
from django.urls import path, include
from .skillsharingbackend.views import SkillsViewSet, ProfileViewSet
from rest_framework.routers import DefaultRouter
from rest_framework import urls

router = DefaultRouter()
router.register('skills', SkillsViewSet, basename='skills')
router.register('profiles', ProfileViewSet, basename='profiles')
#create routers as well that define the url patterns to the views and creates the api endpoints for
#CRUD functionality

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api/auth', include(urls)) #as the rest_framework.urls includes a predefined login logout functions, and is compiled at runtime to serve its functionalities
]
#so by just include(router.urls), it would link u to the skills view page and teachers view page since
#both viewsets have been registered if you add the domain names for each behind eg /skills/, and it
#would also automatically include urls of specific skill instances eg /skills/1/, to link to the 1st
#skill by primary key.