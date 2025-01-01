from django.test import TestCase
from .models import Skills, Profile

# Create your tests here.
class Skills(TestCase):
    @classmethod
    def setUpTestData(cls):
        Skills.objects.create(title = 'Make flowers',
        description = 'Learn how to make paper flowers')

    def test_title_content(self):
        skill = Skills.objects.get(id=1)
        expected_title = skill.title
        self.assertEquals(expected_title, 'Make flowers')

    def test_description_content(self):
        skill = Skills.objects.get(id=1)
        expected_description = skill.description
        self.assertEquals(expected_description, 'Learn how to make paper flowers ')

class Profile(TestCase):
    @classmethod
    def setUpTestData(cls):
        Profile.objects.create(name='jiajun', bio='Professional paper flower maker and gardener', hpnumber=90486500)
#for User field, can use django's built-in create_user function to create and save users with username, password and email then test the data using functions like check_password
    def test_name(self):
        profile = Profile.objects.get(id=1)
        expected_name = profile.name
        self.assertEquals(expected_name, 'jiajun')

    def test_bio(self):
        profile = Profile.objects.get(id=1)
        expected_bio = profile.bio
        self.assertEquals(expected_bio, 'Professional paper flower maker and gardener')

    def test_number(self):
        profile = Profile.objects.get(id=1)
        expected_number = profile.hpnumber
        self.assertEquals(expected_number, 90486500)