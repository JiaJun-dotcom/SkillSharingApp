from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('', include('API.skillsharingbackend.urls')),
    path('admin/', admin.site.urls),
    path('api/auth/login/', include('dj_rest_auth.urls')),#as the rest_framework.urls includes a predefined login logout functions, and is compiled at runtime to serve its functionalities
    path('api/auth/logout/', include('dj_rest_auth.urls')),
    path('api/auth/registration', include('dj_rest_auth.registration.urls')),
]
#so by just include(router.urls), it would link u to the skills view page and teachers view page since
#both viewsets have been registered if you add the domain names for each behind eg /skills/, and it
#would also automatically include urls of specific skill instances eg /skills/1/, to link to the 1st
#skill by primary key.