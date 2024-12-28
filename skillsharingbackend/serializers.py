from rest_framework import serializers
from .models import Skills, Profile

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['user','profile_picture', 'bio', 'skills', 'hpnumber']
class SkillsSerializer(serializers.ModelSerializer):
    teachers = ProfileSerializer(read_only=True, many=True, source='user') #Customising serializer
#many=True: Since a skill can have multiple teachers (profiles), we need to use many=True to indicate that it's a list of teachers, not a single teacher.
#read_only=True: This ensures that the teachers field will only be used for reading data (i.e., returning the data in the response). You don’t want to modify the teachers field when creating or updating a Skills object.
#source='profiles': This tells Django REST Framework to use the reverse relationship profiles (which you defined in the Profile model as related_name='profiles' in the skills field). It refers to the related profiles for that skill, which are essentially the teachers of the skill.
    class Meta:
        model = Skills
        fields = ['id', 'name', 'description', 'teachers']
