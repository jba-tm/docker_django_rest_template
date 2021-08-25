from ._base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = get_secret('DJANGO_SECRET_KEY')

# SECURITY WARNING: define the correct hosts in production!
ALLOWED_HOSTS = ['*']

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

WEBSITE_URL = "http://127.0.0.1:8000"  # without trailing slash


if 'debug_toolbar' in INSTALLED_APPS:
    MIDDLEWARE += [
        # Debug toolbar
        'debug_toolbar.middleware.DebugToolbarMiddleware',
        'debug_toolbar_force.middleware.ForceDebugToolbarMiddleware',
    ]

    DEBUG_TOOLBAR_CONFIG = {
        "SHOW_TOOLBAR_CALLBACK": lambda request: True,
    }

    INTERNAL_IPS = [
        # ...
        '127.0.0.1',
        # ...
    ]

try:
    from .local import *
except ImportError:
    pass
