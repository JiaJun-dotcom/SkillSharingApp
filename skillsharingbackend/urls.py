from .views import SkillsViewSet, ProfileViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register('skills', SkillsViewSet, basename='skills')
router.register('profiles', ProfileViewSet, basename='profiles')
# create routers as well that define the url patterns to the views and creates the api endpoints for
# CRUD functionality

urlpatterns = router.urls
