from django.test import TestCase
from .models import Skills, Profile

# Create your tests here.
class Skills(TestCase):
    @classmethod
    def setUpTestData(cls):
        Skills.objects.create(title = 'Buy flowers',
        description = 'Buy flowers for baby')

    def test_title_content(self):
        skill = Skills.objects.get(id=1)
        expected_title = skill.title
        self.assertEquals(expected_title, 'Buy flowers')

    def test_description_content(self):
        skill = Skills.objects.get(id=1)
        expected_description = skill.description
        self.assertEquals(expected_description, 'Buy flowers for baby')