from django.conf.urls import include, path
from django.conf import settings
from django.conf.urls.static import static

from sal.origurls import *

urlpatterns += [

    path(r'^saml2/', include('djangosaml2.urls')),
]
