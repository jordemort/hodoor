from mako.lookup import TemplateLookup
from hodoor.config import CONFIG

TEMPLATES = TemplateLookup(directories=[CONFIG.template_dir])
