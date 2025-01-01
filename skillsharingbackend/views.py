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

    def get_queryset(self):
        query = self.request.query_params.get('query', '')  # Get the query parameter from the request's url(everything behind the ?), if not return empty string if got no value
        if query:
            # First, check for "starts with"
            starts_with_results = self.queryset.filter(name__istartswith=query)
            if starts_with_results.exists():
                return starts_with_results
        # Return "starts with" matches if they exist(eg when user key in letter p, configure frontend to display all skills starting with p first eg python, pilates etc

            # If no "starts with" matches, check for "contains"(fall back option to startswith)
            return self.queryset.filter(name__icontains=query)
        return self.queryset  # Return all skills if no query is provided

class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticatedOrReadOnly]
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    lookup_field = 'name'




