from .serializers import SkillsSerializer, ProfileSerializer
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from .models import Skills, Profile

# Create your views here.
class SkillsViewSet(viewsets.ModelViewSet): #to be used with routers
    permission_classes = [IsAuthenticatedOrReadOnly]
    queryset = Skills.objects.all()
    serializer_class = SkillsSerializer
    lookup_field = 'name'

class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticatedOrReadOnly]
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    lookup_field = 'name'




