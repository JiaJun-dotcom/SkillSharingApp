from rest_framework import serializers
from .models import Skills, Profile

class SkillsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Skills
        fields = ['id', 'name', 'description']

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['id', 'name', 'username', 'profile_picture', 'bio', 'skills', 'email', 'hpnumber']